import SwiftUI
struct ReflectionView: View {
    @State private var tab: Tab = .daily
    enum Tab: String, CaseIterable { case daily="今日"; case weekly="本周"; case monthly="本月" }
    var body: some View {
        NavigationStack {
            VStack(spacing:0) {
                Picker("周期", selection:$tab) { ForEach(Tab.allCases, id:\.self) { Text($0.rawValue).tag($0) } }
                    .pickerStyle(.segmented).padding()
                switch tab {
                case .daily: DailyReflectionView()
                case .weekly: WeeklyReviewView()
                case .monthly: MonthlyReviewView()
                }
            }.background(Color(.systemGroupedBackground)).navigationTitle("反思")
            .toolbar { ToolbarItem(placement:.navigationBarTrailing) {
                NavigationLink(destination: SettingsView()) { Image(systemName: "gear") }
            }}
        }
    }
}
