//
//  ContentView.swift
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

struct ContentView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var showToast = false
    
    public var body: some View {
        NavigationView {
            
            VStack{
                ForEach(MenuList.mainMenu, id: \.id) { button in
                    NavigationLink {
                        // @TODO add logic
                        
                        switch button.id {
                        case 0:
                            NFCView()
                        case 1:
                            BluetoothView()
                        case 2:
                            WirelessView()
                        case 3:
                            ShellView()
                        default: self
                        }
                        
                    } label: {
                        
                        VStack {
                            Image(button.image)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .padding(5)
                            Text(button.name).font(
                                Font.custom("tianzhen", size: 15)
                            )
                        }
                        .padding()
                        .background(
                            self.colorScheme == .dark ? .gray : Color(UIColor.systemGroupedBackground)
                        )
                        .cornerRadius(10)
                    }
                }
                .padding()
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("关于") {
                        self.showToast.toggle()
                    }
                }
            }
            .padding()
            .toast(isPresenting: $showToast){
                AlertToast(
                    type: .error(.red),
                    title: "这个应用程序是由鐘智强开发的。\n开发者不对造成的任何损失负责。"
                )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
