//
//  MenuList.swift
//  YiYi
//
//  Created by John Melody Me on 24/02/2023.
//

import SwiftUI

struct MenuList {
    public static var mainMenu :[Menu] = [
        Menu(id: 0, name: "NFC读写器", image: "nfc"),
        Menu(id: 1, name: "蓝牙实用程序", image: "bluetooth"),
        Menu(id: 2, name: "网络实用程序", image: "wifi")
    ]
}
