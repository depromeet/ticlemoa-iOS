//
//  DateFormatter+Extensions.swift
//  UserInterface
//
//  Created by 김우성 on 2022/12/11.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import Foundation

extension DateFormatter {
    static let allNumericUSA: DateFormatter = {
        print("Initializing DateFormatter")
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        
        return formatter
    }()
}

extension String {
    func dateParsed() -> Date {
        guard let parsedDate = DateFormatter.allNumericUSA.date(from: self) else { return Date() }
        
        return parsedDate
    }
}
