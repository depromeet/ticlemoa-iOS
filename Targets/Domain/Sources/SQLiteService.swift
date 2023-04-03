//
//  SQLiteService.swift
//  Domain
//
//  Created by Shin Jae Ung on 2022/11/18.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SQLite3
import Foundation

final class SQLiteService {
    enum SQLiteError: Error {
        case openDatabase(message: String)
        case prepare(message: String)
        case createTable(message: String)
        case step(message: String)
        case bind(message: String)
    }
    
    enum CreationQuery {
        case tagTable
        
        var statement: String {
            switch self {
            case .tagTable: return """
                CREATE TABLE IF NOT EXISTS TAG(
                TAGNAME TEXT PRIMARY KEY NOT NULL
                );
                """
            }
        }
    }
    
    enum InsertionQuery {
        case tag(named: String)
        
        var statement: String {
            switch self {
            case .tag: return """
                INSERT INTO TAG (TAGNAME) VALUES (?);
                """
            }
        }
    }
    
    enum SelectionQuery {
        case allTags
        
        var statement: String {
            switch self {
            case .allTags:
                return """
                SELECT * FROM TAG
                """
            }
        }
    }

    private let groupIdentifier = "group.com.depromeet.ticlemoa"
    private let path = "nyongnyong.sqlite"
    private var db: OpaquePointer? = nil

    init() throws {
        let database = try openDatabase()
        self.db = database
    }
    
    deinit {
        sqlite3_close(db)
    }

    private func openDatabase() throws -> OpaquePointer? {
        var db: OpaquePointer?
        guard let dbURL: URL = FileManager.default.containerURL(
            forSecurityApplicationGroupIdentifier: groupIdentifier
        )?.appendingPathComponent(path) else {
            throw SQLiteError.openDatabase(message: "Invalid URL")
        }

        if sqlite3_open(dbURL.path, &db) == SQLITE_OK {
            return db
        } else {
            throw SQLiteError.openDatabase(message: "Unable to open database")
        }
    }
    
    private func prepare(forQuery string: String) throws -> OpaquePointer? {
        var statement: OpaquePointer?
        guard sqlite3_prepare_v2(db, string, -1, &statement, nil) == SQLITE_OK else {
            throw SQLiteError.prepare(message: "SQLite3 is not prepared")
        }
        return statement
    }
    
    func createTableIfNotExist(byQuery query: CreationQuery) throws {
        let createTableStatement = try prepare(forQuery: query.statement)
        defer { sqlite3_finalize(createTableStatement) }
        if sqlite3_step(createTableStatement) != SQLITE_DONE {
            throw SQLiteError.createTable(message: "TAG table is not created")
        }
    }
    
    func insert(byQuery query: InsertionQuery) throws {
        let insertStatement = try prepare(forQuery: query.statement)
        defer { sqlite3_finalize(insertStatement) }
        switch query {
        case .tag(let name):
            try insertTag(insertStatement: insertStatement, tagName: name)
        }
    }
    
    func select(byQuery query: SelectionQuery) throws -> [String] {
        let selectStatement = try prepare(forQuery: query.statement)
        defer { sqlite3_finalize(selectStatement) }
        return try selectTag(selectStatement: selectStatement)
    }
    
    private func insertTag(insertStatement: OpaquePointer?, tagName name: String) throws {
        let name = NSString(string: name)
        sqlite3_bind_text(insertStatement, 1, name.utf8String, -1, nil)
        if sqlite3_step(insertStatement) != SQLITE_DONE {
            throw SQLiteError.step(message: "Could not insert row")
        }
    }
    
    private func selectTag(selectStatement: OpaquePointer?) throws -> [String] {
        var result: [String] = []
        while sqlite3_step(selectStatement) == SQLITE_ROW {
            guard let tag = sqlite3_column_text(selectStatement, 0) else {
                throw SQLiteError.step(message: "Element is not a text")
            }
            result.append(String(cString: tag))
        }
        return result
    }
}
