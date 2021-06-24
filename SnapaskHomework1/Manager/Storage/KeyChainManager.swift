//
//  KeyChainManager.swift
//  SnapaskHomework
//
//  Created by Albert_Chien on 2021/6/24.
//

import SwiftKeychainWrapper

protocol KeyChainable {
    var accessToken: String? {get set}
}

class KeyChainManager :KeyChainable {
    @KeyChain(key: "accessToken", defaultValue: nil)
    var accessToken: String?
}

extension KeyChainManager {
    @propertyWrapper
    struct KeyChain<T> {
        let key: String
        let defaultValue: T

        init(key: String, defaultValue: T) {
            self.key = key
            self.defaultValue = defaultValue
        }

        var wrappedValue: T {
            get {
                switch T.self {
                case is String?.Type:
                    return KeychainWrapper.standard.string(forKey: key) as? T ?? defaultValue
                default:
                    return defaultValue
                }
            }
            set {
                if let value = newValue as? String {
                    KeychainWrapper.standard.set(value, forKey: key)
                } else {
                    KeychainWrapper.standard.removeObject(forKey: key)
                }
            }
        }
    }
}
