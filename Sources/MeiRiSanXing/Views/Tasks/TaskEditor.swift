import SwiftUI
struct TaskEditor: View {
    @Environment(\.dismiss) var dismiss
    @State private var title = ""; @State private var urgency: Urgency = .normal
    @State private var deadline = Date().addingTimeInterval(86400)
    @State private var hasDeadline = false; @State private var progress = 0.0
    let onSave: (String, Urgency, Date?, Int) -> Void
    var body: some View {
        NavigationStack {
            Form {
                Section("任务") { TextField("标题", text:$title) }
                Section("紧急") { Picker("", selection:$urgency) {
                    ForEach(Urgency.allCases) { Text($0.label).tag($0) }
                }.pickerStyle(.segmented) }
                Section("截止") {
                    Toggle("设置截止时间", isOn:$hasDeadline)
                    if hasDeadline { DatePicker("日期", selection:$deadline, displayedComponents:.date) }
                }
                Section("进度") { Slider(value:$progress, in:0...100, step:5); Text("\(Int(progress))%").font(.caption).foregroundColor(.secondary) }
            }.navigationTitle("任务")
            .toolbar {
                ToolbarItem(placement:.cancellationAction) { Button("取消") { dismiss() } }
                ToolbarItem(placement:.confirmationAction) { Button("保存") {
                    onSave(title, urgency, hasDeadline ? deadline : nil, Int(progress)); dismiss()
                }.disabled(title.trimmingCharacters(in:.whitespaces).isEmpty) }
            }
        }.presentationDetents([.medium,.large])
    }
}
