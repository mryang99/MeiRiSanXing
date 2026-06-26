import Foundation
import SwiftData

@Model
final class MeditationSession {
    var id: UUID = UUID()
    var date: Date = Date()
    var durationMinutes: Int = 0
    var notes: String = ""
    init(date: Date = Date(), durationMinutes: Int = 0, notes: String = "") {
        self.id = UUID()
        self.date = date
        self.durationMinutes = durationMinutes
        self.notes = notes
    }
}
