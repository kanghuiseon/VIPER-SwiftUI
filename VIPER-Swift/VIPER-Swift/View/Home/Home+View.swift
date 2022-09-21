//
//  Home+View.swift
//  VIPER-Swift
//
//  Created by 강희선 on 2022/09/16.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var vm: ViewModel
    @Namespace var controlAnimation
    
    init(_ vm: ViewModel) {
        self.vm = vm
    }
    
    @ViewBuilder
    var body: some View {
        VStack(spacing: 0) {
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
                                .fill(.pink)
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
    func stack(bookList: [BookModel]) -> some View {
        HStack(spacing: 0) {
            Spacer()
            VStack(spacing: 0) {
                Spacer()
                ForEach(bookList, id: \.id) { book in
                    Text(book.name)
                        .frame(width: 200, height: book.height)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.random())
                        )
                        .offset(x: book.x)
                }
            }
            Spacer()
        }
    }
    
    @ViewBuilder
    func list(_ bookList: [BookModel]) -> some View {
        EmptyView()
    }
}

struct BookModel {
    var id: String
    var name: String
    var rating: Float
    var x: CGFloat
    var height: CGFloat
    var color: Color
}

extension HomeView.ViewModel {
    enum ViewState {
        case `none`
        case loading
        case loaded(_ bookList: [BookModel])
        case error(_ error: Error)
    }
}

extension HomeView {
    class ViewModel: ObservableObject {
        // MARK: infjected
        let presenter: HomePresenter
        
        // MARK: states
        /// 뷰 상태
        @Published var viewState: ViewState = .none
        /// segmented control
        @Published var selectedControl: String = "쌓아보기"
        
        // MARK: datas
        /// segmented control datas
        var controls: [String] = ["쌓아보기", "리스트형 보기"]
        
        init(container: DIContainer) {
            self.presenter = container.resolve(HomePresenter.self)!
        }
        
        // functions
        func loadDatabox() {
            presenter.getBookList()
        }
        
        func goDetail() {
            presenter.goDetail()
        }
    }
}

extension HomeView.ViewModel: HomePresenterDelegate {
    func renderLoading() {
        viewState = .loading
    }
    
    func render(_ error: Error) {
        viewState = .error(error)
    }
    
    func render(_ bookList: [BookModel]) {
        viewState = .loaded(bookList)
    }
}

struct HomeViewView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(.init(container: .init()))
    }
}
