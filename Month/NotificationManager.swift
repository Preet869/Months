import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    
    private init() {}
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Notification permission granted.")
                self.scheduleMonthlyNotification()
            } else if let error = error {
                print("Notification permission error: \(error.localizedDescription)")
            } else {
                print("Notification permission denied.")
            }
        }
    }
    
    func scheduleMonthlyNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Time for your monthly photo!"
        content.body = "Open the app to capture this month's moment."
        content.sound = .default
        
        // Trigger on the 1st of every month at noon
        var dateComponents = DateComponents()
        dateComponents.day = 1
        dateComponents.hour = 12
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "monthly_photo_reminder", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Monthly notification scheduled successfully.")
            }
        }
    }
} 