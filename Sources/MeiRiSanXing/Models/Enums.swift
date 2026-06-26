import Foundation

enum Urgency: String, Codable, CaseIterable, Identifiable {
    case urgent = "urgent"
    case normal = "normal"
    case low = "low"
    var id: String { rawValue }
    var label: String {
        switch self {
        case .urgent: return "紧急"
        case .normal: return "普通"
        case .low: return "低优先"
        }
    }
}

enum Mood: String, Codable, CaseIterable, Identifiable {
    case great = "great"; case good = "good"; case neutral = "neutral"
    case down = "down"; case stressed = "stressed"
    var id: String { rawValue }
    var label: String {
        switch self {
        case .great: return "很好"; case .good: return "不错"
        case .neutral: return "一般"; case .down: return "低落"
        case .stressed: return "焦虑"
        }
    }
}

struct AutoSummaryData: Codable {
    var totalMeditationMinutes: Int = 0
    var totalSessions: Int = 0
    var taskCompletionRate: Double = 0.0
    var tasksDone: Int = 0
    var tasksTotal: Int = 0
    var reflectionDays: Int = 0
    var totalDaysInPeriod: Int = 0
}

struct FreeParagraph: Codable, Identifiable {
    var id: UUID = UUID()
    var content: String = ""
    var sortOrder: Int = 0
}
