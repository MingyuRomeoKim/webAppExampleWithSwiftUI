//
//  AlarmView.swift
//  webApp
//
//  Created by mingyukim on 11/3/23.
//

import SwiftUI

struct AlarmView: View {
    // 사용자 정의 뒤로 가기 동작을 처리하기 위한 변수
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var alarmData = AlarmViewModel()
    
    // 알림 관련
    @ObservedObject var notificationManager = NotificationManager()
    @State private var isNotificationsEnabled: Bool = false
    // 앱의 상태 변화를 감지하기 위한 NotificationCenter
    private let notificationCenter = NotificationCenter.default
    
    var body: some View {
        VStack {
            // Header
            HeaderView(presentationMode: _presentationMode, isShowingAlarmView: .constant(false),headerType: .notice)
            // End Header
            if !isNotificationsEnabled {
                VStack(spacing:0) {
                    VStack{
                        Image("newAlarmSettingIcon")
                        Spacer().frame(height:30)
                        Text("실시간으로 소식을 받아보시려면 \n알림 설정이 필요해요")
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                        Spacer().frame(height:38)
                        Button(action: {
                            // 사용자를 설정 화면으로 안내하거나
                            // 알림 권한 요청을 다시 시도합니다.
                            notificationManager.requestPermission() { granted in
                                if granted {
                                    // 사용자가 알림을 허용한 경우 UI를 업데이트합니다.
                                    self.isNotificationsEnabled = true
                                } else {
                                    // 필요한 경우 사용자가 알림을 거부한 경우 처리합니다.
                                }
                            }
                        }) {
                            Image("newAlarmSettingButtonIcon")
                        }
                    }
                    .position(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/4)
                }
            }else {
                // Content
                if alarmData.items.isEmpty {
                    VStack{
                        Image("newAlarmNotYetIcon")
                        Spacer().frame(height:30)
                        Text("목록이 없습니다")
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                    .position(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/4)
                } else {
                    List {
                        ForEach(alarmData.items) { item in
                            VStack(alignment: .leading) {
                                Text(item.title)
                                    .font(.headline)
                                Text(item.description)
                                    .font(.subheadline)
                                Text(item.updatedText)
                                    .font(.footnote)
                            }
                            .padding(.vertical, 5)
                        }
                        .onDelete(perform: deleteItem)
                    }
                    .listStyle(PlainListStyle())  // 배경 색상과 구분선을 제거하기 위한 스타일
                    .background(Color.white)
                    .ignoresSafeArea(.all, edges: .all)  // 여백 제거하기
                }
                // End Content
            }
        }
        .onAppear(perform: {
            // View가 표시될 때 초기 알림 설정 상태 확인
            checkNotificationSettings()
            
            // 앱이 활성화될 때마다 알림 설정 상태를 확인하도록 NotificationCenter에 옵저V버를 추가합니다.
            notificationCenter.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) { [notificationCenter] _ in
                // 앱이 포그라운드 상태로 전환될 때 알림 설정을 확인합니다.
                self.checkNotificationSettings()
            }
        })
        .onDisappear(perform: {
            // View가 사라질 때 NotificationCenter의 옵저버를 제거합니다.
            notificationCenter.removeObserver(self)
        })
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    
    func deleteItem(at offsets: IndexSet) {
        alarmData.items.remove(atOffsets: offsets)
    }
    
    // 알림 설정을 확인하는 메서드
    private func checkNotificationSettings() {
        notificationManager.checkNotificationSettings { enabled in
            self.isNotificationsEnabled = enabled
        }
    }
}



struct AlarmView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmView()
    }
}


#Preview {
    AlarmView()
}
