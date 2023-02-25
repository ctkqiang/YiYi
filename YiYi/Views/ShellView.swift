//
//  ShellView.swift
//  YiYi
//
//  Created by John Melody Me on 24/02/2023.
//


#if canImport(SwiftUI)
import SwiftUI
#endif

#if canImport(SwiftTerm)
import SwiftTerm
#endif

struct ShellView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Environment(\.colorScheme) private var colorScheme
    
    private var isShell: Bool = true
    
    var body: some View {
        
        NavigationView {
            VStack {
                //@TODO Adjust
//                ZStack {
//                    Text(" machine-one:$ ")
//                        .foregroundColor(self.colorScheme == .dark ? .white : .black)
//                        .frame(
//                            maxWidth: .infinity,
//                            maxHeight: .infinity,
//                            alignment: .topLeading
//                        )
//                }
                
                
                
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: try! ActionCustomView.backButton(presentationMode: self.presentationMode)
        )
        
    }
}

struct ShellView_Previews: PreviewProvider {
    static var previews: some View {
        ShellView()
    }
}
