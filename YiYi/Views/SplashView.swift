//
//  SplashView.swift
//  YiYi
//
//  Created by John Melody Me on 24/02/2023.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive: Bool = false
    
    public var body: some View {
        ZStack {
            if self.isActive {
                ContentView()
            } else {
                Image("splash")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 400)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
