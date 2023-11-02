//
//  SettingView.swift
//  webApp
//
//  Created by mingyukim on 11/1/23.
//

import SwiftUI

struct SettingView: View {
    // 로그인 유무 관리용 변수
    @State private var isLogin = false
    
    var body: some View {
        VStack {
            // Header
            HeaderView()
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
        
    }
}

#Preview {
    SettingView()
}

struct HeaderView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        HStack {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }){
                Image(systemName: "chevron.left")
                    .font(.system(size: 26))
                    .foregroundColor(.black)
            }
            Spacer()
            Text("설정")
                .font(.system(size: 26, weight: .heavy))
                .frame(maxWidth: .infinity)
            Spacer()
            Spacer()
        }.padding()
        
        Rectangle()
            .fill(Color.black.opacity(0.05))
            .frame(height: 4)
            .edgesIgnoringSafeArea(.horizontal)
    }
}

struct NotificationView: View {
    @State private var isNotificationEnabled: Bool = false
    @State private var isNotificationEnabled2: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("알림설정")
                .font(.headline)
            Spacer().frame(height: 20)
            HStack {
                Text("알림1")
                Toggle(isOn: $isNotificationEnabled) {
                    
                }
            }
            Spacer().frame(height: 10)
            HStack {
                Text("알림2")
                Toggle(isOn: $isNotificationEnabled2) {
                    
                }
            }
        
            if isNotificationEnabled {
                // 알림1 켜짐
            } else {
                // 알림1 꺼짐
            }
            
            if isNotificationEnabled2 {
                // 알림2 켜짐
            } else {
                // 알림2 꺼짐
            }
        }
    }
}

struct AccountManageView: View {
    @Binding var isLogin: Bool
    
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
