//
//  BluetoothView.swift
//  YiYi
//
//  Created by John Melody Me on 24/02/2023.
//


#if canImport(SwiftUI)
import SwiftUI
#endif

#if canImport(AlertToast)
import AlertToast
#endif

struct BluetoothView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject private var bluetoothService: BluetoothService = BluetoothService()
    
    @State private var isPresent: Bool = false
    @State private var isBluetoothOff: Bool = true
    @State private var isPeripheralsSHow: Bool = false
    @State private var peripherals: [String] = [String]()
    
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
                        
                        self.peripherals = [peripheral[1],peripheral[5],peripheral[8]]
                       
                        if self.peripherals.count > 0 {
                            self.isPeripheralsSHow = true
                        } else {
                            self.isPeripheralsSHow = false
                        }
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
            .toast(isPresenting: self.$isBluetoothOff) {
                AlertToast(
                    type: .error(.red),
                    title: "请启用蓝牙功能"
                )
            }
            .toast(isPresenting: self.$isPeripheralsSHow){
                AlertToast(
                    type: .complete(.blue),
                    title: "\(self.peripherals)"
                )
            }
            .navigationTitle(MenuList.mainMenu[1].name).font(Font.custom("tianzhen", size: 20))
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: try! ActionCustomView.backButton(presentationMode: self.presentationMode)
        )
        .onAppear {
            self.isBluetoothOff = self.bluetoothService.bluetoothStatus
        }
    }
}

struct BluetoothView_Previews: PreviewProvider {
    static var previews: some View {
        BluetoothView()
    }
}
