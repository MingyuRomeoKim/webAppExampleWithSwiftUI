//
//  SettingView.swift
//  webApp
//
//  Created by mingyukim on 11/1/23.
//

import SwiftUI

struct NotificationView: View {
    // 알림 관련
    @ObservedObject var notificationManager = NotificationManager()
    
    // 앱의 상태 변화를 감지하기 위한 NotificationCenter
    private let notificationCenter = NotificationCenter.default
    
    // 토글 버튼 관리용 변수
    @State private var isToggledCamera = false
    @State private var isToggledAlarm = false
    
    // 변경 전 상태를 추적하는 변수
    @State private var previousIsToggledAlarm = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("알림설정")
                .font(.headline)
            Spacer().frame(height: 20)
            VStack {
                HStack{
                    Text("카메라 권한 설정")
                    if #available(iOS 17, *) {
                        Toggle(isOn: $isToggledCamera) {}
                            .onChange(of: isToggledCamera, initial: true) { oldValue,newValue in
                                UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.isToggledCamera)
                            }
                    } else {
                        Toggle(isOn: $isToggledCamera) {}
                            .onChange(of: isToggledCamera) { newValue in
                                UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.isToggledCamera)
                            }
                        
                    }
                }                
                Spacer().frame(height: 10)
                HStack {
                    Text("알림 권한 설정")
                    if #available(iOS 17, *) {
                        Toggle(isOn: $isToggledAlarm) {}
                            .onChange(of: isToggledAlarm, initial: true) { oldValue,newValue in
                                
                                if !newValue && oldValue {
                                    // 토글을 끌 때 설정으로 안내
                                    if let url = URL(string: UIApplication.openSettingsURLString),
                                       UIApplication.shared.canOpenURL(url) {
                                        // iOS 설정 앱을 열기
                                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                    }
                                }
                                
                                if newValue {
                                    // 사용자를 설정 화면으로 안내하거나
                                    // 알림 권한 요청을 다시 시도합니다.
                                    notificationManager.requestPermission() { granted in
                                        if granted {
                                            // 사용자가 알림을 허용한 경우 UI를 업데이트합니다.
                                            self.isToggledAlarm = true
                                        }
                                    }
                                }
                                
                                UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.isToggledAlarm)
                            }
                    } else {
                        Toggle(isOn: $isToggledAlarm) {}
                            .onChange(of: isToggledAlarm) { newValue in
                                // 토글이 꺼졌고, 이전에는 켜져 있었을 때 설정창으로 이동
                                if !newValue && previousIsToggledAlarm {
                                    if let url = URL(string: UIApplication.openSettingsURLString),
                                       UIApplication.shared.canOpenURL(url) {
                                        UIApplication.shared.open(url)
                                    }
                                }
                                
                                if newValue {
                                    // 사용자를 설정 화면으로 안내하거나
                                    // 알림 권한 요청을 다시 시도합니다.
                                    notificationManager.requestPermission() { granted in
                                        if granted {
                                            // 사용자가 알림을 허용한 경우 UI를 업데이트합니다.
                                            self.isToggledAlarm = true
                                        }
                                    }
                                }
                                
                                // 변경 사항을 UserDefaults에 저장
                                UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.isToggledAlarm)
                                // 변경 전 상태를 업데이트
                                previousIsToggledAlarm = newValue
                            }
                    }
                    
                }
            }
            .onAppear(perform: {
                // View가 표시될 때 초기 알림 설정 상태 확인
                checkNotificationSettings()
                
                // 알람 상태 가져오기
                isToggledCamera = UserDefaults.standard.bool(forKey: UserDefaultsKeys.isToggledCamera)
                isToggledAlarm = UserDefaults.standard.bool(forKey: UserDefaultsKeys.isToggledAlarm)
                
                previousIsToggledAlarm = isToggledAlarm
                
                // 앱이 활성화될 때마다 알림 설정 상태를 확인하도록 NotificationCenter에 옵저버를 추가합니다.
                notificationCenter.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) { _ in
                    // 앱이 포그라운드 상태로 전환될 때 알림 설정을 확인합니다.
                    self.checkNotificationSettings()
                }
            })
            
            .onDisappear(perform: {
                // View가 사라질 때 NotificationCenter의 옵저버를 제거합니다.
                notificationCenter.removeObserver(self)
            })
        }
    }
    
    // 알림 설정을 확인하는 메서드
    private func checkNotificationSettings() {
        notificationManager.checkNotificationSettings { enabled in
            self.isToggledAlarm = enabled
        }
    }
}

struct AccountManageView: View {
    @Binding var isLogin: Bool
    
    // Binding 초기화를 위한 새로운 초기화 메소드를 만듭니다.
    init(isLogin: Binding<Bool>) {
        _isLogin = isLogin
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("계정관리")
                .font(.headline)
            
            HStack {
                // 이미지와 '계정관리' 텍스트를 포함하는 VStack
                VStack(alignment: .leading, spacing: 10) {
                    Image(systemName: "person") // SwiftUI의 Image 뷰를 사용
                        .resizable()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .overlay(
                            Circle().stroke(Color.white, lineWidth: 1)
                        )
                        .shadow(radius: 1)
                }
                .frame(width: .infinity , height: 104)
                
                VStack(alignment: .leading, spacing: 10) {
                    if isLogin {
                        Text("김민규")
                            .font(.body)
                        Text("환영합니다")
                            .font(.subheadline)
                    } else {
                        Text("서비스를 이용하시려면\n로그인 해주세요.")
                            .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
                            .font(.custom("AppleSDGothicNeo-Medium", size: 16))
                            .lineSpacing(19.2 - 16)
                            .multilineTextAlignment(.leading)
                    }
                }
                .padding(.leading,16)
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 10) {
                    Button(action: {
                        if isLogin {
                            isLogin = false
                        } else {
                            isLogin = true
                        }
                        
                    }) {
                        Text(isLogin ? "로그아웃" : "로그인")
                    }
                }
            }
        }
    }
}


struct SettingView: View {
    // 로그인 유무 관리용 변수
    @State private var isLogin = false
    // NavigationLink의 활성화 상태를 관리하는 변수
    @State private var isShowingAlarmView = false
    // 사용자 정의 뒤로 가기 동작을 처리하기 위한 변수
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            VStack {
                // Header
                HeaderView(presentationMode: _presentationMode, isShowingAlarmView: $isShowingAlarmView,headerType: .setting)
                // End Header
                
                // Content
                ScrollView {
                    AccountManageView(isLogin: $isLogin)
                        .padding(20)
                    Divider()
                    NotificationView()
                        .padding(20)
                    Divider()
                }
                // End Content
            }
            .background(
                ZStack {  // ZStack 사용으로 각 NavigationLink를 숨김 처리
                    NavigationLink(destination: AlarmView(), isActive: $isShowingAlarmView) {
                        EmptyView()
                    }
                }
            )
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    SettingView()
}
