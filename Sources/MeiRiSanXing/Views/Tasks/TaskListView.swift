import SwiftUI; import SwiftData
struct TaskListView: View {
    @Environment(\.modelContext) var ctx
    @Query(sort:\TaskItem.createdAt, order:.reverse) var tasks: [TaskItem]
    @State private var showEditor = false
    var body: some View {
        NavigationStack {
            List {
                ForEach(Urgency.allCases, id:\.self) { level in
                    let filtered = tasks.filter { $0.urgencyEnum==level && !$0.isDone }
                    if !filtered.isEmpty {
                        Section {
                            ForEach(filtered) { t in
                                TaskRow(task: t).contentShape(Rectangle())
                            }.onDelete { i in for idx in i { ctx.delete(filtered[idx]) } }
                        } header: {
                            Label(level.label, systemImage: level==.urgent ? "exclamationmark.triangle.fill"
                                  : level==.normal ? "minus" : "checkmark")
                                .foregroundColor(level==.urgent ? .red : level==.normal ? .blue : .green)
                        }
                    }
                }
                let done = tasks.filter(\.isDone)
                if !done.isEmpty {
                    Section("已完成") { ForEach(done) { TaskRow(task:$0) }
                        .onDelete { i in for idx in i { ctx.delete(done[idx]) } } }
                }
            }.navigationTitle("待办")
            .overlay { if tasks.isEmpty { ContentUnavailableView("还没有任务", systemImage:"checklist") } }
            .toolbar { ToolbarItem(placement:.bottomBar) {
                Button { showEditor=true } label: { Label("新建", systemImage:"plus.circle.fill").font(.headline) }
            } }
            .sheet(isPresented:$showEditor) {
                TaskEditor(onSave: { title, urg, dl, prog in
                    ctx.insert(TaskItem(title:title, urgency:urg, deadline:dl, progress:prog))
                    try? ctx.save()
                })
            }
        }
    }
}
