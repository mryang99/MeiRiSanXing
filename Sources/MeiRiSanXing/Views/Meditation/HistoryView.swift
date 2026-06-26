import SwiftUI; import SwiftData
struct HistoryView: View {
    @Environment(\.dismiss) var dismiss
    @Query(sort:\MeditationSession.date, order:.reverse) var sessions: [MeditationSession]
    var body: some View {
        NavigationStack {
            List {
                ForEach(sessions) { s in
                    HStack {
                        VStack(alignment:.leading) {
                            Text(s.date, style:.date).font(.headline)
                            if !s.notes.isEmpty { Text(s.notes).font(.caption).foregroundColor(.secondary) }
                        }; Spacer()
                        Text("\(s.durationMinutes) 分钟").fontWeight(.semibold).foregroundColor(Color(red:0.29,green:0.56,blue:0.85))
                    }
                }
            }.navigationTitle("冥想历史")
            .toolbar { ToolbarItem(placement:.confirmationAction) { Button("关闭") { dismiss() } } }
        }
    }
}
