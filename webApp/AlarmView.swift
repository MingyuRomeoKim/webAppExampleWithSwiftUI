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
    
    @State var items: [NoticeItem] = [
        NoticeItem(title: "알림1", description: "알림1 내용입니다.", updatedText: "2분 전"),
        NoticeItem(title: "알림2", description: "알림2 내용입니다.", updatedText: "10분 전"),
        NoticeItem(title: "알림3", description: "알림3 내용입니다.", updatedText: "1시간 전"),
        NoticeItem(title: "알림4", description: "알림4 내용입니다.", updatedText: "3시간 전"),
        NoticeItem(title: "알림5", description: "알림5 내용입니다.", updatedText: "2일 전"),
    ]
    
    var body: some View {
        VStack {
            // Header
            HeaderView(presentationMode: _presentationMode, isShowingAlarmView: .constant(false),headerType: .notice)
            // End Header
            
            // Content
            List {
                ForEach(items) { item in
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
            // End Content
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    
    func deleteItem(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
}

struct NoticeItem: Identifiable {
    var id = UUID()
    var title: String
    var description: String
    var updatedText: String
}

struct AlarmView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmView()
    }
}


#Preview {
    AlarmView()
}
