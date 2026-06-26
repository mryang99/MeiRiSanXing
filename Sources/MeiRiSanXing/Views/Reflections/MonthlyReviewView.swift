import SwiftUI; import SwiftData
struct MonthlyReviewView: View {
    @Environment(\.modelContext) var ctx
    @State private var summary: AutoSummaryData?; @State private var notes = ""
    @State private var existing: MonthlyReview?
    var body: some View {
        ScrollView {
            VStack(spacing:16) {
                if let s = summary {
                    VStack(spacing:16) {
                        row(icon:"sparkles", label:"冥想总时长", val:"\(s.totalMeditationMinutes) 分钟", color:.purple)
                        Divider(); row(icon:"checklist", label:"任务完成率", val:"\(Int(s.taskCompletionRate*100))%", color:.green)
                        Divider(); row(icon:"pencil", label:"反思天数", val:"\(s.reflectionDays)/\(s.totalDaysInPeriod) 天", color:.blue)
                    }.padding().card()
                    VStack(alignment:.leading, spacing:8) {
                        Text("我的月总结").font(.headline)
                        TextEditor(text:$notes).frame(minHeight:150).padding(8).background(Color(.systemGray6)).cornerRadius(8)
                    }.padding().card()
                    Button(action:save) {
                        Text("保存月总结").fontWeight(.semibold).frame(maxWidth:.infinity)
                            .padding().background(Color(red:0.29,green:0.56,blue:0.85)).foregroundColor(.white).cornerRadius(12)
                    }.padding(.horizontal)
                } else { ProgressView() }
            }.padding(.vertical)
        }.onAppear(perform:load)
    }
    func load() {
        let ms = Date().startOfMonth; summary = SummaryService(ctx:ctx).monthly(from:ms)
        if let e = try? ctx.fetch(FetchDescriptor<MonthlyReview>(
            predicate: #Predicate { $0.monthStartDate >= ms && $0.monthStartDate < ms.endOfMonth })).first {
            existing = e; notes = e.userNotes
        }
    }
    func save() {
        guard let s = summary else { return }
        let r: MonthlyReview; if let e = existing { r = e } else { r = MonthlyReview(monthStartDate:Date().startOfMonth); ctx.insert(r) }
        r.autoSummary = s; r.userNotes = notes; try? ctx.save()
    }
    func row(icon:String, label:String, val:String, color:Color) -> some View {
        HStack { Image(systemName:icon).foregroundColor(color).font(.title3); Text(label).foregroundColor(.secondary); Spacer(); Text(val).fontWeight(.semibold) }
    }
}
