//
//  CountdownViewModel.swift
//  Timer
//
//  Created by Rohit Pradhan on 08/12/23.
//
import SwiftUI
import Combine
import UserNotifications

class CountdownViewModel: ObservableObject {
    //MARK: - Properties
    @Published private var timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    @Published private var timeRemaining: TimeInterval = 60
    @Published private var isTimerRunning = false
    private var originalTime: TimeInterval = 60
    private var startTime: Date?
    private var pauseTime: TimeInterval = 0
    private var cancellables: Set<AnyCancellable> = []
    
    //MARK: - Init
    init() {
        setupObservers()
    }
    
    //MARK: - Setup
    private func setupObservers() {
        timer
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                if self.isTimerRunning, let startTime = self.startTime {
                    let elapsed = Date().timeIntervalSince(startTime) + self.pauseTime
                    self.timeRemaining = max(self.originalTime - elapsed, 0)
                    if self.timeRemaining == 0 {
                        self.stopTimer()
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    //MARK: - Public
    func startTimer() {
        if !isTimerRunning {
            startTime = Date()
            timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
            isTimerRunning = true
            self.sendNotification()
        }
    }
    
    func stopTimer() {
        timer.upstream.connect().cancel()
        timeRemaining = 0
        isTimerRunning = false
        startTime = nil
        pauseTime = 0
    }
    
    func startPauseTimer() {
        if isTimerRunning {
            timer.upstream.connect().cancel()
            if let startTime = startTime {
                pauseTime += Date().timeIntervalSince(startTime)
            }
            isTimerRunning = false
        } else {
            startTimer()
        }
    }
    
    func toggleTimer() {
        if isTimerRunning {
            stopTimer()
        } else {
            startTimer()
        }
    }
    
    var timerText: String {
        return String(format: "%.2f", timeRemaining)
    }
    
    var startPauseButtonTitle: String {
        return isTimerRunning ? Constants.Strings.pause : Constants.Strings.start
    }
    
    var remainingFillValue: CGFloat {
        return CGFloat(1.0 - (timeRemaining / originalTime))
    }
    
    //MARK: - Notifications
    private func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = Constants.Strings.notificationTitle
        content.body = Constants.Strings.notificationBody
        content.sound = UNNotificationSound.default
        
        cancelNotifications()
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeRemaining == 0 ? originalTime : timeRemaining, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error sending notification: \(error.localizedDescription)")
            }
        }
    }
    
    func cancelNotifications() -> Void {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
