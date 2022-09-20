//
//  Presenter.swift
//  VIPER-Swift
//
//  Created by 강희선 on 2022/09/21.
//

import Foundation

protocol PresenterDelegate: AnyObject {
//    associatedtype ViewModel: Hashable
    
    func renderLoading()
    func render(_ error: Error)
//    func render(_ model: ViewModel)
}
