//
//  Utilities.swift
//  YiYi
//
//  Created by John Melody Me on 25/02/2023.
//
#if canImport(SwiftUI)
import SwiftUI
#endif

public struct Utilities {
    public static func copyToClipboard(data: String, complete: @escaping(Bool) -> ()) throws -> Void {
        UIPasteboard.general.string = data
        
        if UIPasteboard.general.string == nil {
            return
        }
        
        DispatchQueue.main.async {
            complete(true)
        }
    }
}
