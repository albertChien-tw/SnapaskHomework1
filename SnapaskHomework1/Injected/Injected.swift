//
//  Injected.swift
//  SnapaskHomework
//
//  Created by Albert_Chien on 2021/6/24.
//

import Foundation

@propertyWrapper
struct Injected<Service> {
    private var service: Service

    public init(defaultValue: Service) {
        #if TESTING
        guard let resolve = DIContainer.shared.resolve(type: Service.self) else {fatalError("please register before resolve")}
        self.service = resolve
        #else
        self.service = defaultValue
        #endif
    }
    var wrappedValue: Service {
        get { return service }
        mutating set { service = newValue }
    }
}
