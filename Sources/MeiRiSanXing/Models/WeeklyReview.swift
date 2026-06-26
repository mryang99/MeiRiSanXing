import Foundation; import SwiftData
@Model
final class WeeklyReview {
    var id: UUID = UUID(); var weekStartDate: Date = Date()
    var autoSummaryData: Data = Data(); var userNotes: String = ""
    var autoSummary: AutoSummaryData {
        get {
            guard !autoSummaryData.isEmpty,
                  let r = try? JSONDecoder().decode(AutoSummaryData.self, from: autoSummaryData)
            else { return AutoSummaryData() }; return r
        }
        set { autoSummaryData = (try? JSONEncoder().encode(newValue)) ?? Data() }
    }
    init(weekStartDate: Date) { self.id = UUID(); self.weekStartDate = weekStartDate }
}
