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
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    public var body: some View {
        NavigationView {
            VStack {
                
            }
            .navigationTitle(MenuList.mainMenu[0].name).font(Font.custom("tianzhen", size: 20))
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: try! ActionCustomView.backButton(presentationMode: self.presentationMode)
        )
    }
}

struct NFCView_Previews: PreviewProvider {
    static var previews: some View {
        NFCView()
    }
}
