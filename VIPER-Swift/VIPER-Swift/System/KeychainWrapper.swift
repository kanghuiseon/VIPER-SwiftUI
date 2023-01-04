//
//  KeychainWrapper.swift
//  VIPER-Swift
//
//  Created by 강희선 on 2022/12/07.
//

import Foundation
import SwiftKeychainWrapper

struct KeychainParameter<Value, Strategy>
where Strategy: KeychainValueStrategy {
    let key: String
    let defaultValue: Value
    let strategy = Strategy.self
}

@propertyWrapper
struct Keychain<Value, Strategy>
where Strategy: KeychainValueStrategy,
      Strategy.Value == Value {
    let key: String
    let defaultValue: Value
    let strategy: Strategy.Type
    
    init(_ parameter: KeychainParameter<Value, Strategy>) {
        self.key = parameter.key
        self.defaultValue = parameter.defaultValue
        self.strategy = parameter.strategy
    }
    
    var wrappedValue: Value {
        get {
            strategy.load(key: key, defaultValue: defaultValue)
        }
        set {
            strategy.save(key: key, newValue: newValue)
        }
    }
}

protocol KeychainValueStrategy {
    associatedtype Value
    static func load(key: String, defaultValue: Value) -> Value
    static func save(key: String, newValue: Value)
    static func remove(key: String)
}

extension KeychainValueStrategy {
    static func remove(key: String) {
        KeychainWrapper.standard.removeObject(forKey: key)
    }
}

struct StringValueStrategy: KeychainValueStrategy {
    static func load(key: String, defaultValue: String) -> String {
        KeychainWrapper.standard.string(forKey: key) ?? defaultValue
    }
    
    static func save(key: String, newValue: String) {
        KeychainWrapper.standard.set(newValue, forKey: key)
    }
}

enum KeychainCase { }

extension KeychainCase {
    static func rrn() -> KeychainParameter<String, StringValueStrategy> {
        .init(key: "rrn", defaultValue: "")
    }
}

class Test {
    @Keychain(KeychainCase.rrn()) var rrn: String
    
    func getRRN() -> String {
        rrn
    }
    
    func setRRN(_ rrn: String) {
        self.rrn = rrn
    }
}
