//
//  ExportInfoFeature.swift
//  UserInterface
//
//  Created by 김용우 on 2023/01/13.
//  Copyright © 2023 nyongnyong. All rights reserved.
//

import Foundation

protocol ExportInfoFeature {
    func findThumnail(url: URL) async throws -> String?
    func findTitle(url: URL) async throws -> String?
    func slice(by content: String, from: String, to: String) -> String?
}

extension ExportInfoFeature {
    
    func findThumnail(url: URL) async throws -> String? {
        for try await line in url.lines {
            if line.contains("og:image") {
                return exportURL(by: line)
            }
        }
        return nil
    }
    
    func findTitle(url: URL) async throws -> String? {
        for try await line in url.lines {
            if line.contains("og:title") {
                return exportURL(by: line)
            }
        }
        return nil
    }
    
    private func exportURL(by line: String) -> String? {
        print(line)
        let slicedLine = line
            .filter({ $0 != " " })
            .map({ String($0) }) .joined()
        if let exportedURL = slice(by: slicedLine, from: "content=\"", to: "\"/>") {
            print("\(#function) \(exportedURL)")
            return exportedURL
        }
        return nil
    }
    
    func slice(by content: String, from: String, to: String) -> String? {
        guard let rangeFrom = content.range(of: from)?.upperBound else { return nil }
        guard let rangeTo = content[rangeFrom...].range(of: to)?.lowerBound else { return nil }
        return String(content[rangeFrom..<rangeTo])
    }
    
}
