//
//  ContentView.swift
//  YiYi
//
//  Created by John Melody Me on 24/02/2023.
//

#if canImport(SwiftUI)
import SwiftUI
#endif

struct ContentView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    public var body: some View {
        NavigationView {
            Grid {
                GridRow {
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
                            .background(Color(UIColor.systemGroupedBackground))
                            .cornerRadius(10)
                        }
                    }
                    .padding()
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
