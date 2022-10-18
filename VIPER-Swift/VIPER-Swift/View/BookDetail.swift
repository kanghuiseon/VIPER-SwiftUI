//
//  BookDetail.swift
//  VIPER-Swift
//
//  Created by 강희선 on 2022/10/17.
//

import SwiftUI

struct BookDetailView: View {
    @ObservedObject var vm: ViewModel
    @Namespace var animation
    
    init(_ vm: ViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        VStack(spacing: 0) {
            switch vm.viewState {
            case .loading:
                ProgressView()
            case .loaded(let book):
                content(book: book)
                    .padding(.horizontal, 20)
            default:
                EmptyView()
            }
        }
        .onAppear { vm.getBookDetail() }
    }
    
    @ViewBuilder
    func content(book: BookDetailModel) -> some View {
        VStack(spacing: 40) {
            bookInfo(book)
            duration(book)
            description(book)
            Spacer()
        }
    }
    
    @ViewBuilder
    func bookInfo(_ book: BookDetailModel) -> some View {
        VStack(spacing: 10) {
            Text(book.name)
                .font(.title)
            Image(book.imageName)
                .resizable()
                .frame(width: UIScreen.main.bounds.width / 3, height: 200)
                .shadow(
                    color: Color(hex: "#EEEEEE")!,
                    radius: 3,
                    x: 3,
                    y: 3
                )
            Text(book.writer)
                .font(.caption)
        }
    }
    
    @ViewBuilder
    func duration(_ book: BookDetailModel) -> some View {
        VStack(spacing: 10) {
            HStack(spacing: 0) {
                Text("독서 기간")
                Spacer()
            }
            HStack(spacing: 10) {
                Text("시작")
                    .font(.system(size: 13))
                    .foregroundColor(Color(hex: "#A174CF")!)
                Text(book.startDate)
                    .font(.system(size: 13))
                Spacer()
                Text("종료")
                    .font(.system(size: 13))
                    .foregroundColor(Color(hex: "#A174CF")!)
                Text(book.endDate)
                    .font(.system(size: 13))
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(hex: "#EEEEEE")!)
            )
        }
    }
    
    @ViewBuilder
    func description(_ book: BookDetailModel) -> some View {
        VStack(alignment: .leading) {
            segmentedControl
            if vm.selectedControl == "책 정보" {
                descriptionContent(book.bookInfo)
            } else {
                memo(book.memo)
            }
        }
    }
    
    var segmentedControl: some View {
        HStack(spacing: 0) {
            ForEach(vm.segmentControls, id: \.self) { control in
                Text(control)
                    .padding(10)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .overlay(alignment: .top) {
                        Rectangle()
                            .fill(Color(hex: "#A174CF")!)
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "Control", in: animation)
                            .isHidden(control != vm.selectedControl, remove: true)
                    }
                    .animation(.easeInOut, value: vm.selectedControl)
                    .onTapGesture {
                        vm.selectedControl = control
                    }
            }
        }
    }
    
    @ViewBuilder
    func descriptionContent(_ bookInfo: [BookInfo]) -> some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(bookInfo, id: \.title) { info in
                    VStack(alignment: .leading, spacing: 20) {
                        Text(info.title)
                            .fontWeight(.bold)
                        Text(info.content)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func memo(_ memo: Memo) -> some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(spacing: 0) {
                Text("나의 메모")
                Spacer()
                Button(action: vm.writeMemo) {
                    Text("작성하기")
                        .foregroundColor(Color(hex: "#A174CF")!)
                }
            }
            VStack(spacing: 20) {
                Text(memo.content)
                    .padding(.top, 10)
                    .padding(.horizontal, 20)
                HStack(spacing: 0) {
                    Spacer()
                    Text(memo.modifiedDate)
                        .padding(10)
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
            .background(alignment: .bottomTrailing) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(hex: "#EEEEEE")!)
            }
        }
    }
}

extension BookDetailView {
    struct BookDetailModel {
        var id: Int
        var name: String
        var imageName: String
        var writer: String
        var rating: Float
        var startDate: String
        var endDate: String
        var bookInfo: [BookInfo]
        var memo: Memo
    }
    
    struct BookInfo {
        var title: String
        var content: String
    }
    
    struct Memo {
        var content: String
        var modifiedDate: String
    }
}

extension BookDetailView.ViewModel {
    enum ViewState {
        case `none`
        case loading
        case loaded(_ book: BookDetailModel)
        case error(_ error: Error)
    }
}

extension BookDetailView {
    class ViewModel: ObservableObject {
        typealias BookDetailModel = BookDetailView.BookDetailModel
        @Published var viewState: ViewState = .none
        @Published var selectedControl: String = "메모"
        var segmentControls = ["책 정보", "메모"]
        var bookId: Int
        var startDate: Date?
        var endDate: Date?
        
        init(bookId: Int) {
            self.bookId = bookId
        }
        
        func getBookDetail() {
            viewState = .loaded(
                .init(
                    id: 3,
                    name: "28 (정유정 장편소설)",
                    imageName: "28",
                    writer: "정유정",
                    rating: 3.0,
                    startDate: "2020.9.27",
                    endDate: "2020.10.27",
                    bookInfo: [
                        .init(title: "책 소개", content: "발표하는 작품마다 독자들의 열광적인 지지를 받으며 한국문학의 대체불가한 작가로 자리매김한 정유정이 신작 완전한 행복으로 돌아왔다."),
                        .init(title: "출판사", content: "은행나무"),
                        .init(title: "ISBN", content: "123124324525"),
                        .init(title: "페이지", content: "524")
                    ],
                    memo: .init(content: "정말 재밌다sdfawefwrwefawefawefawefasdfsafwefweafw!", modifiedDate: "2020.10.27")
                )
            )
        }
        
        func writeMemo() {
            
        }
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView(.init(bookId: 3))
    }
}
