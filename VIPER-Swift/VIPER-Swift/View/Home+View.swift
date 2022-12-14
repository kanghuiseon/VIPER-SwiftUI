//
//  Home+View.swift
//  VIPER-Swift
//
//  Created by 강희선 on 2022/09/16.
//

import SwiftUI
import Swinject

struct HomeView: View {
    @ObservedObject var vm: ViewModel
    @Namespace var controlAnimation
    
    init(_ vm: ViewModel) {
        self.vm = vm
    }
    
    @ViewBuilder
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Spacer()
                Button(
                    action: {
                        vm.addBook()
                    },
                    label: {
                        Image("plus")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .padding(.horizontal, 20)
                    }
                )
            }
            switch vm.viewState {
            case .loading:
                ProgressView()
            case .loaded(let bookList):
                VStack(alignment: .leading, spacing: 10) {
                    title(bookList.count)
                    segmentControl
                    if vm.selectedControl == "쌓아보기" {
                        stack(bookList: bookList)
                    } else {
                        list(bookList)
                    }
                    Spacer()
                }
                .padding(.top, 20)
                .padding(.horizontal, 20)
                
            default: EmptyView()
            }
            Spacer()
        }
        .onAppear { vm.loadDatabox() }
    }
    
    @ViewBuilder
    func title(_ bookCount: Int) -> some View {
        Text("전체 \(bookCount) 권")
            .font(.system(size: 20).bold())
    }
    
    var segmentControl: some View {
        HStack(alignment: .center, spacing: 0) {
            ForEach(vm.controls, id: \.self) { control in
                Text(control)
                    .foregroundColor(control == vm.selectedControl ? .white : .black)
                    .frame(height: 40)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background {
                        if vm.selectedControl == control {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(hex: "a648ff")!)
                                .opacity(0.8)
                                .matchedGeometryEffect(id: "Control", in: controlAnimation)
                        }
                    }
                    .animation(.linear(duration: 0.3), value: vm.selectedControl)
                    .onTapGesture {
                        vm.selectedControl = control
                    }
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.init(red: 0, green: 0, blue: 0, opacity: 0.1))
        )
    }
    
    @ViewBuilder
    func stack(bookList: BookModelList) -> some View {
        HStack(spacing: 0) {
            Spacer()
            VStack(spacing: 0) {
                Spacer()
                ForEach(bookList, id: \.id) { book in
                    Text(book.name)
                        .frame(width: 300, height: book.height)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(book.color)
                        )
                        .offset(x: book.x)
                }
            }
            Spacer()
        }
    }
    
    @ViewBuilder
    func list(_ bookList: [BookModel]) -> some View {
        let gridItems: [GridItem] = [
            .init(.flexible(minimum: 0, maximum: .infinity)),
            .init(.flexible(minimum: 0, maximum: .infinity)),
            .init(.flexible(minimum: 0, maximum: .infinity)),
        ]
        
        LazyVGrid(columns: gridItems) {
            ForEach(bookList, id: \.id) { book in
                bookCard(
                    imageName: book.imageName,
                    title: book.name,
                    writer: book.writer,
                    rating: book.rating
                )
            }
        }
        .padding(.top, 20)
    }
    
    @ViewBuilder
    func bookCard(
        imageName: String,
        title: String,
        writer: String,
        rating: Float
    ) -> some View {
        let imageWidth = UIScreen.main.bounds.width / 3 - 20
        Button(action: {
            
        }) {
            VStack(spacing: 5) {
                Image(imageName)
                    .resizable()
                    .frame(width: imageWidth, height: imageWidth * 3/2)
                Text(title)
                    .foregroundColor(.black)
                    .lineLimit(1)
                Text(writer)
                    .foregroundColor(.black)
                ratingStar(0.4)
            }
        }
        
    }
    
    @ViewBuilder
    func ratingStar(_ rating: CGFloat) -> some View {
        EmptyView()
    }
}

extension HomeView {
    typealias BookModelList = [BookModel]
    
    struct BookModel {
        var id: UUID
        var name: String
        var imageName: String
        var writer: String
        var rating: Float
        var x: CGFloat
        var height: CGFloat
        var color: Color
    }
    
    
}

extension HomeView.ViewModel {
    enum ViewState {
        case `none`
        case loading
        case loaded(_ bookList: BookModelList)
        case error(_ error: Error)
    }
}

extension HomeView.ViewModel: HomeViewDelegate {
    func displayBookList(_ bookList: [HomeView.BookModel]) {
        viewState = .loaded(bookList)
    }
}

extension HomeView {
    class ViewModel: ObservableObject {
        typealias BookModelList = HomeView.BookModelList
        let presenter: HomePresenter
        
        // MARK: states
        /// 뷰 상태
        @Published var viewState: ViewState = .none
        /// segmented control
        @Published var selectedControl: String = "쌓아보기"
        
        // MARK: datas
        /// segmented control datas
        var controls: [String] = ["쌓아보기", "리스트형 보기"]
        
        init(container: Container) {
            self.presenter = container.resolve(HomePresenter.self) ?? RealHomePresenter(container)
        }
        
        func loadDatabox() {
            presenter.fetchBookList()
        }
        
        func getBookInfo(_ id: String) {
            
        }
        
        func addBook() {
            presenter.pushToAddNewBook()
        }
        
        func goDetail(bookID: Int) {
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(.init(container: .preview))
    }
}
