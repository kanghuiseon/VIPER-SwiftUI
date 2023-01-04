//
//  AddBookView.swift
//  VIPER-Swift
//
//  Created by 강희선 on 2022/12/04.
//

import Swinject
import SwiftUI

struct AddBookView: View {
    @ObservedObject var vm: ViewModel
    
    init(_ vm: ViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 0) {
                Spacer()
                Button(
                    action: vm.addBook,
                    label: {
                        Text("저장")
                            .foregroundColor(.purple)
                    }
                )
            }
            Text("제목")
            TextField("", text: $vm.title)
            
            Text("지은이")
            TextField("", text: $vm.writer)
            
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

extension AddBookView {
    class ViewModel: ObservableObject {
        let presenter: HomePresenter
        @Published var title: String = ""
        @Published var writer: String = ""
        
        init(_ container: Container) {
            self.presenter = container.resolve(HomePresenter.self) ?? RealHomePresenter(container)
        }
        
        func addBook() {
            presenter.addNewBook(title: title, writer: writer)
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView(.init(.preview))
    }
}
