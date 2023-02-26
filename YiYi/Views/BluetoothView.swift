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
    
    @State private var isPresent: Bool = false
    
    public var body: some View {
        NavigationView {
            VStack {
                List(self.bluetoothService.peripheralNames, id:\.self) { peripheral in
                    Button {
                        
                        // Copy to clipboard
                        try! Utilities.copyToClipboard(data: "\(peripheral)") { data in
                            if !data { return }
                            
                            NSLog("详细内容: \(peripheral[0])")
                        }
                        
                        try! self.bluetoothService.connectToDevice(
                            peripheral: self.bluetoothService.peripherals[0]
                        )
                    } label: {
                        VStack(alignment: .leading) {
                            Text("命名: \(peripheral[0])").font(
                                Font.custom("tianzhen", size: 20)
                            )
                            
                            Text("调试资讯: \(peripheral[1])").font(
                                Font.custom("tianzhen", size: 12)
                            )
                            
                            Text("ANCS验证: \(peripheral[2])").font(
                                Font.custom("tianzhen", size: 12)
                            )
                            
                            Text("服务: \(peripheral[3] == "nil" ? "《没有任何服务》" : peripheral[3])").font(
                                Font.custom("tianzhen", size: 12)
                            )
                            
                            Text("情况: \(peripheral[4])").font(
                                Font.custom("tianzhen", size: 12)
                            )
                            
                            Text("UUID: 《\(peripheral[5])》").font(
                                Font.custom("tianzhen", size: 12)
                            )
                            
                            Text("正在扫描: 《\(peripheral[6])》").font(
                                Font.custom("tianzhen", size: 12)
                            )
                            
                            Text("数据: 《\(peripheral[7])》").font(
                                Font.custom("tianzhen", size: 9)
                            )
                            
                            Text(
                                "RSSI: 《 \(peripheral[8]) 》"
                            ).font(
                                Font.custom("tianzhen", size: 12)
                            )
                        }
                    }
                }
            }
            .refreshable {
                self.isPresent.toggle()
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
