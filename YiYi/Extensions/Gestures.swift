//
//  Gestures.swift
//  YiYi
//
//  Created by John Melody Me on 25/02/2023.
//

#if canImport(SwiftUI)
import SwiftUI
#endif


extension View {
    public func onBackSwipe(perform action: @escaping () -> Void) throws -> some View {
        gesture(
            DragGesture().onEnded({ value in
                if value.startLocation.x < 50 && value.translation.width > 80 {
                    action()
                }
                
                return
            })
        )
    }
}
