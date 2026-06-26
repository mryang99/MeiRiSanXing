import Foundation
import SwiftData

@Model
final class TaskItem {
    var id: UUID = UUID()
    var title: String = ""
    var urgency: String = Urgency.normal.rawValue
    var deadline: Date?
    var progress: Int = 0
    var isDone: Bool = false
    var createdAt: Date = Date()
    var urgencyEnum: Urgency {
        get { Urgency(rawValue: urgency) ?? .normal }
        set { urgency = newValue.rawValue }
    }
    init(title: String, urgency: Urgency = .normal, deadline: Date? = nil, progress: Int = 0) {
        self.id = UUID()
        self.title = title
        self.urgency = urgency.rawValue
        self.deadline = deadline
        self.progress = progress
        self.isDone = progress >= 100
        self.createdAt = Date()
    }
}
