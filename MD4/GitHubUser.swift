// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

struct GitHubUser: Codable {
    let avatarURL: String?
    let name, company, bio: String?

    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
        case name, company, bio
    }
}
