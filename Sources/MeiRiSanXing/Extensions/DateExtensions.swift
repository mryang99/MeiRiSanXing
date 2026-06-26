import Foundation
extension Date {
    var startOfDay: Date { Calendar.current.startOfDay(for: self) }
    var startOfWeek: Date {
        Calendar.current.date(from: Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
    }
    var startOfMonth: Date {
        Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
    }
    var endOfDay: Date { Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)! }
    var endOfWeek: Date { Calendar.current.date(byAdding: .day, value: 7, to: startOfWeek)! }
    var endOfMonth: Date { Calendar.current.date(byAdding: .month, value: 1, to: startOfMonth)! }
}
