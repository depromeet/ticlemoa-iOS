//
//  Network.swift
//  Ticlemoa
//
//  Created by Yongwoo Marco on 2022/11/11.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import Foundation

struct DecodingTypeExample: Codable {
    var title: String = "Example Title"
}

// Just Example Method
func fetchData() async throws -> [DecodingTypeExample] {
    return [DecodingTypeExample]()
}

// Get Data Example
extension DecodingTypeExample {
    static var responseArray: [DecodingTypeExample] {
        get async throws {
            try await fetchData()
        }
    }
}

// Subscript Get Data Example
extension DecodingTypeExample {
    enum Error: Swift.Error { case outOfRange }
    
    /// Example
    /// Task {
    ///     dump(try await DecodingTypeExample[1]
    /// }
    ///
    static subscript(_ index: Int) -> String {
        get async throws {
            let responseArray = try await self.responseArray
            
            guard responseArray.indices.contains(index) else {
                throw Error.outOfRange
            }
            
            return responseArray[index].title
        }
    }
}


class NetworkExample {
    
    // Fetching Example
    func fetchSomething(_ urlString: String) async throws -> DecodingTypeExample {
        let url = URL(string: urlString)!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(DecodingTypeExample.self, from: data)
    }
    
    
    /// HTML <title> tag Example
    /// Example)
    /// Task {
    ///     if let title = try await NetworkExample().findTitle(url: URL(string: "URL넣으3")!) {
    ///         print(title)
    ///     }
    /// }
    func findTitle(_ url: URL) async throws -> String? {
        for try await line in url.lines {
            if line.contains("<title>") {
                return line.description.trimmingCharacters(in: .whitespaces)
            }
        }
        return nil
    }
}
