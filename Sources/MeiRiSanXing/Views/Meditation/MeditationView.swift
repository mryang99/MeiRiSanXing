import SwiftUI; import SwiftData
struct MeditationView: View {
    @Environment(\.modelContext) private var ctx
    @Query private var sessions: [MeditationSession]
    @State private var showHistory = false; @State private var showManual = false
    @State private var manualMin = 10; @State private var manualNotes = ""
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing:16) {
                    TimerView().frame(height:360)
                        .background(RoundedRectangle(cornerRadius:16).fill(Color(.systemBackground)).shadow(color:.black.opacity(0.06),radius:8,y:2))
                        .padding(.horizontal)
                    todayCard; weekChart
                }.padding(.vertical)
            }.background(Color(.systemGroupedBackground)).navigationTitle("冥想")
            .toolbar {
                ToolbarItem(placement:.navigationBarTrailing) { Button("历史") { showHistory=true } }
                ToolbarItem(placement:.navigationBarLeading) { Button("", systemImage:"plus.circle") { showManual=true } }
            }
            .sheet(isPresented:$showHistory) { HistoryView() }
            .sheet(isPresented:$showManual) {
                NavigationStack {
                    Form {
                        DatePicker("日期", selection:.constant(Date()), displayedComponents:.date)
                        Stepper("时长: \(manualMin) 分钟", value:$manualMin, in:1...180)
                        TextField("备注", text:$manualNotes)
                    }.navigationTitle("补录").toolbar {
                        ToolbarItem(placement:.confirmationAction) { Button("保存") {
                            ctx.insert(MeditationSession(durationMinutes:manualMin, notes:manualNotes))
                            try? ctx.save(); showManual=false
                        }}
                        ToolbarItem(placement:.cancellationAction) { Button("取消") { showManual=false } }
                    }
                }.presentationDetents([.medium])
            }
            .onReceive(NotificationCenter.default.publisher(for:.init("SaveMeditation"))) { n in
                if let d=n.userInfo?["d"] as? Int, let notes=n.userInfo?["n"] as? String {
                    ctx.insert(MeditationSession(durationMinutes:d, notes:notes)); try? ctx.save()
                }
            }
        }
    }
    var todayCard: some View {
        let m = sessions.filter{Calendar.current.isDateInToday($0.date)}.reduce(0){$0+$1.durationMinutes}
        return HStack {
            Label("今日冥想", systemImage:"clock"); Spacer()
            Text("\(m) 分钟").fontWeight(.semibold).foregroundColor(Color(red:0.29,green:0.56,blue:0.85))
        }.padding().background(RoundedRectangle(cornerRadius:12).fill(Color(.systemBackground)).shadow(color:.black.opacity(0.04),radius:4,y:1))
        .padding(.horizontal)
    }
    var weekChart: some View {
        let data: [(String,Int)] = (0..<7).reversed().map {
            let d=Calendar.current.date(byAdding:.day, value:-$0, to:Date())!
            let m=sessions.filter{Calendar.current.isDate($0.date, inSameDayAs:d)}.reduce(0){$0+$1.durationMinutes}
            let f=DateFormatter(); f.dateFormat="E"
            return (f.string(from:d), m)
        }
        let maxV = max(data.map(\.1).max() ?? 1, 1)
        return VStack(alignment:.leading, spacing:12) {
            Text("最近 7 天").font(.headline)
            HStack(alignment:.bottom, spacing:8) {
                ForEach(data, id:\.0) { day, m in
                    VStack(spacing:4) {
                        Text("\(m)").font(.caption2).foregroundColor(.secondary)
                        RoundedRectangle(cornerRadius:4).fill(Color(red:0.29,green:0.56,blue:0.85).opacity(0.6))
                            .frame(height:max(4, CGFloat(m)/CGFloat(maxV)*100))
                        Text(day).font(.caption2).foregroundColor(.secondary)
                    }.frame(maxWidth:.infinity)
                }
            }
        }.padding().background(RoundedRectangle(cornerRadius:12).fill(Color(.systemBackground)).shadow(color:.black.opacity(0.04),radius:4,y:1)).padding(.horizontal)
    }
}
