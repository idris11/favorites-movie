// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movieModel = try? newJSONDecoder().decode(MovieModel.self, from: jsonData)

import Foundation

// MARK: - MovieModel
struct MovieModel: Decodable {
    let results: [Result]
}
