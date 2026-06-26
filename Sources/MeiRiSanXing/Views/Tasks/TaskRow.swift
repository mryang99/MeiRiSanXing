import SwiftUI
struct TaskRow: View {
    @Bindable var task: TaskItem
    var body: some View {
        HStack(spacing:12) {
            Button { task.isDone.toggle(); if task.isDone { task.progress=100 } }
                label: { Image(systemName:task.isDone ? "checkmark.circle.fill":"circle")
                    .font(.title3).foregroundColor(task.isDone ? .green : urgencyColor) }
            VStack(alignment:.leading, spacing:4) {
                Text(task.title).strikethrough(task.isDone).foregroundColor(task.isDone ? .secondary : .primary)
                if let d=task.deadline {
                    HStack(spacing:4) { Image(systemName:"calendar").font(.caption2); Text(d, style:.date).font(.caption2) }
                        .foregroundColor(d<Date() ? .red : .secondary)
                }
            }
            Spacer()
            Image(systemName: task.urgencyEnum == .urgent ? "exclamationmark.circle.fill"
                  : task.urgencyEnum == .normal ? "minus.circle.fill" : "checkmark.circle.fill")
                .foregroundColor(urgencyColor).font(.caption)
            VStack(alignment:.trailing, spacing:2) {
                ProgressView(value:Double(task.progress), total:100).frame(width:60)
                Text("\(task.progress)%").font(.caption2).foregroundColor(.secondary)
            }
        }.padding(.vertical,4)
    }
    var urgencyColor: Color {
        switch task.urgencyEnum { case .urgent: return .red; case .normal: return .blue; case .low: return .green }
    }
}
