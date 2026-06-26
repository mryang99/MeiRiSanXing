import Foundation; import SwiftData
@Model
final class MonthlyReview {
    var id: UUID = UUID(); var monthStartDate: Date = Date()
    var autoSummaryData: Data = Data(); var userNotes: String = ""
    var autoSummary: AutoSummaryData {
        get {
            guard !autoSummaryData.isEmpty,
                  let r = try? JSONDecoder().decode(AutoSummaryData.self, from: autoSummaryData)
            else { return AutoSummaryData() }; return r
        }
        set { autoSummaryData = (try? JSONEncoder().encode(newValue)) ?? Data() }
    }
    init(monthStartDate: Date) { self.id = UUID(); self.monthStartDate = monthStartDate }
}
