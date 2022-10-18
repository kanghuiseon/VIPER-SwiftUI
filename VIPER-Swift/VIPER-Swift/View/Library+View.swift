//
//  Library.swift
//  VIPER-Swift
//
//  Created by 강희선 on 2022/09/16.
//

import SwiftUI

struct LibraryView: View {
    @ObservedObject var vm: ViewModel
    @Namespace var animation
    
    init(_ vm: ViewModel) {
        self.vm = vm
    }
    
    @ViewBuilder
    var body: some View {
        VStack(spacing: 0) {
            switch vm.viewState {
            case .loaded(let bookList):
                content(bookList)
            case .loading:
                ProgressView()
            default:
                EmptyView()
            }
        }
        .onAppear(perform: vm.loadDatabox)
    }
    
    @ViewBuilder
    func content(_ books: BookList) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            title
            segmentedControl
            bookList(books)
            Spacer()
        }
        .padding(.horizontal, 20)
    }
    
    var title: some View {
        Text("나의 서재")
            .font(.title)
            .fontWeight(.bold)
            .padding(.vertical, 40)
    }
    
    var segmentedControl: some View {
        HStack(spacing: 0) {
            ForEach(vm.segmentControls, id: \.self) { control in
                Text(control)
                    .padding(10)
                    .overlay(alignment: .top) {
                        Rectangle()
                            .fill(Color(hex: "#A174CF")!)
                            .frame(height: 4)
                            .matchedGeometryEffect(id: "Control", in: animation)
                            .isHidden(control != vm.selectedControl, remove: true)
                    }
                    .animation(.easeInOut, value: vm.selectedControl)
                    .onTapGesture {
                        vm.selectedControl = control
                    }
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        .overlay(alignment: .top) {
            Rectangle()
                .fill(Color(hex: "#EEEEEE")!)
                .frame(height: 1)
        }
    }
    
    @ViewBuilder
    func bookList(_ books: BookList) -> some View {
        ScrollView(showsIndicators: false) {
            ForEach(books, id: \.id) { book in
                bookCard(book)
            }
        }
    }
    
    @ViewBuilder
    func bookCard(_ book: Book) -> some View {
        Button(action: vm.goDetail) {
            HStack(spacing: 0) {
                Image(book.imageName)
                    .resizable()
                    .frame(width: 80, height: 100)
                VStack(alignment: .leading, spacing: 5) {
                    Text(book.name)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Text(book.writer + "(지은이)")
                        .font(.system(size: 14))
                        .foregroundColor(Color(hex: "#9E9E9E")!)
                        .padding(.bottom, 10)
                    HStack(spacing: 5) {
                        Text("시작")
                            .foregroundColor(Color(hex: "#A174CF")!)
                        Text(book.startDate)
                            .foregroundColor(Color(hex: "#9E9E9E")!)
                        Text("종료")
                            .foregroundColor(Color(hex: "#A174CF")!)
                        Text(book.endDate)
                            .foregroundColor(Color(hex: "#9E9E9E")!)
                    }
                    .font(.system(size: 14))
                }
                .padding(.horizontal, 10)
            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .mask {
                RoundedRectangle(cornerRadius: 10)
            }
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .shadow(color: Color(hex: "#EEEEEE")!, radius: 5, x: 0, y: 0)
            )
        }
        .padding(.top, 10)
    }
}

extension LibraryView {
    typealias BookList = [Book]
    struct Book {
        var id: Int
        var name: String
        var imageName: String
        var writer: String
        var rating: Float
        var startDate: String
        var endDate: String
    }
}

extension LibraryView {
    enum ViewState {
        case none
        case loading
        case loaded(_ bookList: BookList)
        case error(_ error: Error)
    }
}

extension LibraryView {
    class ViewModel: ObservableObject {
        @Published var viewState: ViewState = .none
        @Published var selectedControl: String = "전체"
        let segmentControls = ["전체", "읽은 책", "읽고 있는 책", "읽고 싶은 책"]
        
        func loadDatabox() {
            viewState = .loaded([
                .init(id: 0, name: "연년세세 - 황정은 연작소설", imageName: "sese", writer: "황정은", rating: 4, startDate: "2022.08.24", endDate: "2022.08.26"),
                .init(id: 1, name: "완전한 행복(정유정 장편소설)", imageName: "happy", writer: "정유정", rating: 5, startDate: "2021.11.27", endDate: ""),
                .init(id: 2, name: "소년이 온다(한강 장편소설)", imageName: "boy", writer: "한강 ", rating: 4.5, startDate: "2020.08.26", endDate: "2020.09.02"),
                .init(id: 3, name: "28 (정유정 장편소설)", imageName: "28", writer: "정유정", rating: 3.0, startDate: "2021.01.18", endDate: "2021.01.18"),
                .init(id: 4, name: "채식주의자 (한강 연작소설)", imageName: "55555216", writer: "한강", rating: 5.0, startDate: "2020.10.16", endDate: "2020.10.16")
            ])
        }
        
        func goDetail() {
            
        }
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView(.init())
    }
}
