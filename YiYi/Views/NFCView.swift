//
//  NFCView.swift
//  YiYi
//
//  Created by John Melody Me on 24/02/2023.
//

#if canImport(SwiftUI)
import SwiftUI
#endif

#if canImport(SwiftNFC)
import SwiftNFC
#endif

struct NFCView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject private var NFCR = NFCReader()
    @ObservedObject private var NFCW = NFCWriter()
    
    private func readNFC() throws -> Void {
        self.NFCR.read()
    }
    
    private func writeNFC(data: String) throws -> Void {
        self.NFCW.msg = data
        self.NFCW.write()
    }
    
    public var body: some View {
        NavigationView {
            VStack {
                
                HStack(alignment: .bottom) {
                        Button {
                            try! self.readNFC()
                        } label: {
                            Text("读取《NFC》数据")
                                .font(
                                    Font.custom("tianzhen", size: 15)
                                )
                                .padding()
                                .background(Color(UIColor.systemGroupedBackground))
                                .cornerRadius(10)
                                .foregroundColor(.green)
                        }
                        
                        Button {
                            // @TODO Write
                        } label: {
                            Text("写 《NFC》 数据")
                                .font(
                                    Font.custom("tianzhen", size: 15)
                                )
                                .padding()
                                .background(Color(UIColor.systemGroupedBackground))
                                .cornerRadius(10)
                                .foregroundColor(.red)
                        }
                    }.frame(height: 80)
                    
                    Spacer()
                    
                    VStack {
                        Text("")
                    }
                 
            }.navigationTitle(MenuList.mainMenu[0].name).font(Font.custom("tianzhen", size: 20))
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
