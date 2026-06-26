import Testing; import SwiftData; import Foundation
@testable import MeiRiSanXing
@MainActor @Test func testWeeklySummary() {
    let c = try! ModelContainer(for:MeditationSession.self,TaskItem.self,DailyReflection.self,configurations:ModelConfiguration(isStoredInMemoryOnly:true))
    let ctx = c.mainContext
    ctx.insert(MeditationSession(durationMinutes:20))
    let t = TaskItem(title:"测试", progress:100); t.isDone=true; ctx.insert(t)
    let s = SummaryService(ctx:ctx).weekly(from:Date().startOfWeek)
    #expect(s.totalMeditationMinutes >= 20); #expect(s.tasksDone >= 1)
}
