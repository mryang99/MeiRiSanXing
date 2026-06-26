import SwiftUI; import SwiftData

@main
struct MeiRiSanXingApp: App {
    init() { NotificationService.requestAuth() }
    var body: some Scene {
        WindowGroup { ContentView() }
            .modelContainer(sharedModelContainer)
    }
    var sharedModelContainer: ModelContainer {
        let schema = Schema([
            MeditationSession.self, TaskItem.self, DailyReflection.self,
            WeeklyReview.self, MonthlyReview.self,
        ])
        do { return try ModelContainer(for: schema) }
        catch { fatalError("\(error)") }
    }
}
