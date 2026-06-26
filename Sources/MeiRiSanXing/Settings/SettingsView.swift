import SwiftUI
struct SettingsView: View {
    @AppStorage("reminderHour") private var hour = 21
    @AppStorage("reminderMinute") private var minute = 0
    @AppStorage("reminderOn") private var on = false
    var body: some View {
        Form {
            Section("每日提醒") {
                Toggle("开启提醒", isOn:$on).onChange(of:on) { _, v in
                    v ? NotificationService.schedule(hour:hour, minute:minute) : NotificationService.cancelAll()
                }
                if on {
                    DatePicker("时间", selection:Binding(get:{
                        Calendar.current.date(from:DateComponents(hour:hour, minute:minute)) ?? Date()
                    }, set:{
                        let c=Calendar.current.dateComponents([.hour,.minute], from:$0)
                        hour=c.hour ?? 21; minute=c.minute ?? 0
                        NotificationService.schedule(hour:hour, minute:minute)
                    }), displayedComponents:.hourAndMinute)
                }
            }
            Section("关于") {
                HStack { Text("版本"); Spacer(); Text("1.0.0").foregroundColor(.secondary) }
                HStack { Text("数据"); Spacer(); Text("本地 + iCloud").foregroundColor(.secondary) }
            }
        }.navigationTitle("设置")
    }
}
