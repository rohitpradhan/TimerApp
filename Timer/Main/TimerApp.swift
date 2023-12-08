//
//  TimerApp.swift
//  Timer
//
//  Created by Rohit Pradhan on 08/12/23.
//

import SwiftUI

@main
struct TimerApp: App {
    
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("Notification permission granted")
            } else if let error = error {
                print("Error requesting notification permission: \(error.localizedDescription)")
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            CountdownView(viewModel: CountdownViewModel())
        }
    }
}
