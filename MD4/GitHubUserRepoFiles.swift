// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

struct GitHubUserRepoFiles: Codable {
    let name: String?
    let downloadURL: String?

    enum CodingKeys: String, CodingKey {
        case name
        case downloadURL = "download_url"
    }
}

typealias RepoFiles = [GitHubUserRepoFiles]
