import Foundation
import SwiftData

@Model
final class DailyReflection {
    var id: UUID = UUID()
    var date: Date = Date()
    var structuredAnswers: [String: String] = [:]
    var freeParagraphsData: Data = Data()
    var mood: String?
    var freeParagraphs: [FreeParagraph] {
        get {
            guard !freeParagraphsData.isEmpty,
                  let r = try? JSONDecoder().decode([FreeParagraph].self, from: freeParagraphsData)
            else { return [] }
            return r
        }
        set { freeParagraphsData = (try? JSONEncoder().encode(newValue)) ?? Data() }
    }
    var moodEnum: Mood? {
        get { mood.flatMap { Mood(rawValue: $0) } }
        set { mood = newValue?.rawValue }
    }
    init(date: Date = Date()) {
        self.id = UUID()
        self.date = date
        self.structuredAnswers = ["today_best": "", "tomorrow_three": ""]
    }
}
