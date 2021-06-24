//
//  CodableExtension.swift
//  SnapaskHomework
//
//  Created by Albert_Chien on 2021/6/24.
//

import Foundation

extension Encodable {
    func encoded() -> Data? {
        do {
            let data = try JSONEncoder().encode(self)
            return data
        } catch {
            print("Encodable encoded error:\(error.localizedDescription)")
            return nil
        }
    }
}
