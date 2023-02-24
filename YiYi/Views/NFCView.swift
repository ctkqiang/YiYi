//
//  NFCView.swift
//  YiYi
//
//  Created by John Melody Me on 24/02/2023.
//

#if canImport(SwiftUI)
import SwiftUI
#endif


struct NFCView: View {
    public var body: some View {
        NavigationView {
            VStack {
                
            }
            .navigationTitle(MenuList.mainMenu[0].name)
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                
            }
        }
    }
}

struct NFCView_Previews: PreviewProvider {
    static var previews: some View {
        NFCView()
    }
}
