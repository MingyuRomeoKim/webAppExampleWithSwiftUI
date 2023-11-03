//
//  HeaderView.swift
//  webApp
//
//  Created by mingyukim on 11/3/23.
//

import SwiftUI

enum HeaderType {
    case setting
    case notice
}

struct HeaderView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var isShowingAlarmView: Bool
    var headerType: HeaderType
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 26))
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                Text(headerTitle(for: headerType))
                    .font(.system(size: 26, weight: .heavy))
                    .frame(maxWidth: .infinity)
                
                Spacer()
                
                if headerType != .notice {
                    Button(action: {
                        isShowingAlarmView = true
                    }) {
                        Image(systemName: "bell")
                            .font(.system(size: 26))
                            .foregroundColor(.black)
                    }
                } else {
                    Button(action: {}) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.clear)
                    }
                }
            }
            .padding()
            
            Rectangle()
                .fill(Color.black.opacity(0.05))
                .frame(height: 4)
                .edgesIgnoringSafeArea(.horizontal)
        }
    }
    
    func headerTitle(for type: HeaderType) -> String {
        switch type {
        case .setting: return "설정"
        case .notice: return "알림"
        }
    }
}

#Preview {
    HeaderView(isShowingAlarmView: .constant(false), headerType: .notice)
}
