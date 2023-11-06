//
//  AlarmViewModel.swift
//  webApp
//
//  Created by mingyukim on 11/6/23.
//

import Foundation

struct NoticeItem: Identifiable {
    var id = UUID()
    var title: String
    var description: String
    var updatedText: String
}

class AlarmViewModel: ObservableObject {
    
    @Published var items: [NoticeItem] = [
        NoticeItem(title: "알림1", description: "알림1 내용입니다.", updatedText: "2분 전"),
        NoticeItem(title: "알림2", description: "알림2 내용입니다.", updatedText: "10분 전"),
        NoticeItem(title: "알림3", description: "알림3 내용입니다.", updatedText: "1시간 전"),
        NoticeItem(title: "알림4", description: "알림4 내용입니다.", updatedText: "3시간 전"),
        NoticeItem(title: "알림5", description: "알림5 내용입니다.", updatedText: "2일 전"),
    ]
}
