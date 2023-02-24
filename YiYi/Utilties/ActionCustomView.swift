//
//  ActionCustomView.swift
//  YiYi
//
//  Created by John Melody Me on 24/02/2023.
//

#if canImport(SwiftUI)
import SwiftUI
#endif

struct ActionCustomView {
    public static func backButton(presentationMode: Binding<PresentationMode>) throws -> some View {
       try! Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            HStack {
                Image(systemName: "chevron.backward")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.blue)
                Text("返回").font(
                    Font.custom("tianzhen", size: 20)
                )
                .foregroundColor(.blue)
            }
        }.onBackSwipe {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

