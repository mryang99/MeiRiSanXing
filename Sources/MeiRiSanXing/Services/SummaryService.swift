import Foundation; import SwiftData
struct SummaryService {
    let ctx: ModelContext
    func weekly(from start: Date) -> AutoSummaryData {
        let end = start.endOfWeek
        let sessions = (try? ctx.fetch(FetchDescriptor<MeditationSession>(
            predicate: #Predicate { $0.date >= start && $0.date < end }))) ?? []
        let tasks = (try? ctx.fetch(FetchDescriptor<TaskItem>(
            predicate: #Predicate { $0.createdAt >= start && $0.createdAt < end }))) ?? []
        let refls = (try? ctx.fetch(FetchDescriptor<DailyReflection>(
            predicate: #Predicate { $0.date >= start && $0.date < end }))) ?? []
        let done = tasks.filter(\.isDone).count
        return AutoSummaryData(
            totalMeditationMinutes: sessions.reduce(0){$0+$1.durationMinutes},
            totalSessions: sessions.count,
            taskCompletionRate: tasks.isEmpty ? 0 : Double(done)/Double(tasks.count),
            tasksDone: done, tasksTotal: tasks.count,
            reflectionDays: refls.count, totalDaysInPeriod: 7)
    }
    func monthly(from start: Date) -> AutoSummaryData {
        let end = start.endOfMonth
        let sessions = (try? ctx.fetch(FetchDescriptor<MeditationSession>(
            predicate: #Predicate { $0.date >= start && $0.date < end }))) ?? []
        let tasks = (try? ctx.fetch(FetchDescriptor<TaskItem>(
            predicate: #Predicate { $0.createdAt >= start && $0.createdAt < end }))) ?? []
        let refls = (try? ctx.fetch(FetchDescriptor<DailyReflection>(
            predicate: #Predicate { $0.date >= start && $0.date < end }))) ?? []
        let done = tasks.filter(\.isDone).count
        let days = Calendar.current.range(of:.day, in:.month, for:start)?.count ?? 30
        return AutoSummaryData(
            totalMeditationMinutes: sessions.reduce(0){$0+$1.durationMinutes},
            totalSessions: sessions.count,
            taskCompletionRate: tasks.isEmpty ? 0 : Double(done)/Double(tasks.count),
            tasksDone: done, tasksTotal: tasks.count,
            reflectionDays: refls.count, totalDaysInPeriod: days)
    }
}
