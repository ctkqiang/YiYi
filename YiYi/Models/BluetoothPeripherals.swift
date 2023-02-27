//
//  BluetoothPeripherals.swift
//  YiYi
//
//  Created by John Melody Me on 25/02/2023.
//
#if canImport(Foundation)
import Foundation
#endif

public struct BluetoothPeripherals: Identifiable {
    public var id: Int
    public var name: String
    public var debugInfo: String
    public var ancsAuth: String
    public var services: String
    public var stauts: String
    public var uuid: String
    public var isScanning: String
    public var data: String
    public var rssi: String
}
