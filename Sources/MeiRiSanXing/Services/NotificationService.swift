import Foundation; import UserNotifications
struct NotificationService {
    static func requestAuth() {
        UNUserNotificationCenter.current().requestAuthorization(options:[.alert,.sound]) { _, _ in }
    }
    static func schedule(hour:Int, minute:Int) {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        var dc = DateComponents(); dc.hour=hour; dc.minute=minute
        let content: UNMutableNotificationContent = {
            let c = UNMutableNotificationContent()
            c.title = "每日三醒"; c.body = "该来冥想/写反思了 ✨"; c.sound = .default
            return c
        }()
        let req = UNNotificationRequest(identifier:"daily-reminder",
            content:content, trigger:UNCalendarNotificationTrigger(dateMatching:dc, repeats:true))
        UNUserNotificationCenter.current().add(req)
    }
    static func cancelAll() { UNUserNotificationCenter.current().removeAllPendingNotificationRequests() }
}
