//
//  OnBoarding.swift
//  VIPER-Swift
//
//  Created by 강희선 on 2022/12/04.
//

import Swinject
import SwiftUI
import Combine

struct OnBoarding: View {
    @ObservedObject var vm: ViewModel
    
    init(vm: ViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        Button("Go to Home~!") {
            vm.goHome()
        }
    }
}

extension OnBoarding.ViewModel: OnBoardingDelegate {
    
}

extension OnBoarding {
    class ViewModel: ObservableObject {
        private let presenter: OnBoardingPresenter
        private let cancellables = Set<AnyCancellable>()
        
        init(_ container: Container) {
            self.presenter = container.resolve(OnBoardingPresenter.self)!
        }
        
        func goHome() {
            presenter.pushToMain()
        }
    }
}

struct OnBoarding_Previews: PreviewProvider {
    static var previews: some View {
        OnBoarding(vm: .init(.preview))
    }
}
