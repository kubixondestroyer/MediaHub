import Foundation

struct Movie: Codable, Identifiable {
    let id: String
    var title: String
    var director: String
    var created: TimeInterval
    var isWatched: Bool
    
    mutating func setWatched(_ state: Bool) {
        isWatched = state
    }
}
