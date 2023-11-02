//
//  ContentView.swift
//  webApp
//
//  Created by mingyukim on 10/30/23.
//

import SwiftUI
import CoreData
import WebKit

struct ContentView: View {
    
    @ObservedObject var webViewModel: WebViewModel = WebViewModel()
    
    var request: URLRequest = URL(string: Constants.DOMAIN_PATH).map { URLRequest(url: $0) }!
    
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                WebView(request: request, webViewModel: webViewModel)
                
                ToolbarView(goBackAction: webViewModel.goBack, goForwardAction: webViewModel.goForward, goHomeAction: webViewModel.goHome)
                    .background(Color.gray.opacity(0.1))
            }
        }
        
    }
}
#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
