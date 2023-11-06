//
//  NotificationManager.swift
//  webApp
//
//  Created by mingyukim on 11/6/23.
//

import Foundation
import UserNotifications
import SwiftUI

class NotificationManager: ObservableObject {
    
    func requestPermission(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { [weak self] granted, error in
            // 오류 체크: 요청 과정에서 오류가 발생했는지 확인합니다.
            if let error = error {
                print("Error requesting permissions: \(error)")
                return
            }
            
            DispatchQueue.main.async {
                if granted {
                    // 권한이 허용된 경우
                    completion(true)
                } else {
                    // 권한이 거부된 경우, 사용자를 설정 페이지로 안내합니다.
                    self?.openAppSettings()
                    completion(false)
                }
            }
        }
    }
    
    // 사용자를 이 앱의 설정 화면으로 안내하는 메서드입니다.
    private func openAppSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl)
        }
    }
    
    // 현재 알림 설정을 검색하는 메서드
    func checkNotificationSettings(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                switch settings.authorizationStatus {
                case .authorized, .provisional:
                    // 알림이 활성화된 경우
                    completion(true)
                default:
                    // 알림이 비활성화된 경우
                    completion(false)
                }
            }
        }
    }
}
