import SwiftUI
struct MeditationResultSheet: View {
    let duration: Int; let onSave: (String) -> Void
    @State private var notes = ""; @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            VStack(spacing:20) {
                Image(systemName:"sparkles").font(.system(size:48)).foregroundColor(Color(red:0.29,green:0.56,blue:0.85))
                Text("冥想完成").font(.title2).fontWeight(.semibold)
                Text("时长: \(duration) 分钟").font(.title3).foregroundColor(.secondary)
                TextField("添加备注（可选）", text:$notes, axis:.vertical).textFieldStyle(.roundedBorder).lineLimit(3...6).padding(.horizontal)
                Spacer()
            }.padding()
            .toolbar {
                ToolbarItem(placement:.cancellationAction) { Button("放弃") { dismiss() } }
                ToolbarItem(placement:.confirmationAction) { Button("保存") { onSave(notes); dismiss() } }
            }
        }
    }
}
