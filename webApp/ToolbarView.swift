//
//  ToolbarView.swift
//  webApp
//
//  Created by mingyukim on 10/31/23.
//

import SwiftUI
import WebKit

struct ToolbarView: View {
    
    @State private var showSettings = false
    
    var goBackAction: () -> Void
    var goForwardAction: () -> Void
    var goHomeAction: () -> Void
    
    var body: some View {
        HStack {
            Button(action: {goBackAction()}) {
                Text("이전")
            }
            
            Spacer()
            
            Button(action: {goForwardAction()}) {
                Text("다음")
            }
            
            Spacer()
            
            Button(action: {goHomeAction()}) {
                Text("홈")
            }
            
            Spacer()
            
            NavigationLink(destination: SettingView(), isActive: $showSettings) {
                Button(action: {
                    showSettings = true
                }) {
                    Text("설정")
                }
            }
            
            
        }
        .padding()
    }
    
}

struct ToolbarView_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarView(goBackAction: {}, goForwardAction: {}, goHomeAction: {})
    }
}
