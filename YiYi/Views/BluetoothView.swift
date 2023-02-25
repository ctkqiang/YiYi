//
//  BluetoothView.swift
//  YiYi
//
//  Created by John Melody Me on 24/02/2023.
//


#if canImport(SwiftUI)
import SwiftUI
#endif


struct BluetoothView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject private var bluetoothService: BluetoothService = BluetoothService()
    
    var body: some View {
        NavigationView {
            VStack {
                List(self.bluetoothService.peripheralNames, id:\.self) { peripheral in
                    Button {
                        // Do nothing for now
                    } label: {
                        Text(peripheral)
                    }
                }.refreshable {
                    // Do nothing for now
                }
            }
            .navigationTitle(MenuList.mainMenu[1].name).font(Font.custom("tianzhen", size: 20))
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: try! ActionCustomView.backButton(presentationMode: self.presentationMode)
        )
    }
}

struct BluetoothView_Previews: PreviewProvider {
    static var previews: some View {
        BluetoothView()
    }
}
