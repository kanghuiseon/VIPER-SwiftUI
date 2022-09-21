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
        VStack(alignment: .leading, spacing: 10) {
            title
            segmentControl
            if vm.selectedControl == "쌓아보기" {
                stack
            } else {
                list
            }
            Spacer()
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .onAppear { vm.loadDatabox() }
    }
    
    var title: some View {
        Text("전체 \(vm.books.count) 권")
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
    
    var stack: some View {
        HStack(spacing: 0) {
            Spacer()
            VStack(spacing: 0) {
                Spacer()
                ForEach(vm.books, id: \.id) { book in
                    Text(book.name)
                        .frame(width: 200, height: book.height ?? vm.randomHeight)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.random())
                        )
                        .offset(x: vm.randomX)
                }
            }
            Spacer()
        }
    }
    
    var list: some View {
        EmptyView()
    }
}

extension HomeView.ViewModel {
    struct Book {
        var id: String
        var name: String
        var rating: Float
        var x: CGFloat?
        var height: CGFloat?
        var color: Color?
    }
}

extension HomeView {
    class ViewModel: ObservableObject {
        // MARK: infjected
        let presenter: HomePresenter? = nil
        
        // MARK: states
        @Published var selectedControl: String = "쌓아보기"
        
        // MARK: datas
        var controls: [String] = ["쌓아보기", "리스트형 보기"]
        var books: [Book] = [
            .init(id: "0", name: "완전한 행복", rating: 4.5, x: -8),
            .init(id: "1", name: "소년이 온다", rating: 2.5, x: 3),
            .init(id: "2", name: "28", rating: 5.0),
            .init(id: "3", name: "아가미", rating: 2.0),
            .init(id: "4", name: "채식주의자", rating: 5.0),
            .init(id: "5", name: "연년세세", rating: 1.5),
        ]
        
        var randomHeight: CGFloat {
            CGFloat(Int.random(in: 18..<50))
        }
        
        var randomX: CGFloat {
            CGFloat(Double.random(in: -10.0...10.0))
        }
        
        init(container: DIContainer) {
//            self.presenter = container.resolve(HomePresenter.self)
//            presenter.setDelegate(self)
        }
        
        // functions
        func loadDatabox() {
            
        }
    }
}

extension HomeView.ViewModel: HomePresenterDelegate {
    func renderLoading() {
        
    }
    
    func render(_ error: Error) {
        
    }
    
    func getBookList() {
        
    }
}

struct HomeViewView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(.init(container: .init()))
    }
}

enum ViewState {
    case none
    case loading
    case loaded
    case error
}
