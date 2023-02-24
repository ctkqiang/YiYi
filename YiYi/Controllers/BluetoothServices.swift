//
//  BluetoothServices.swift
//  YiYi
//
//  Created by John Melody Me on 25/02/2023.
//


#if canImport(Foundation)
import Foundation
#endif

#if canImport(Combine)
import Combine
#endif

#if canImport(CoreBluetooth)
import CoreBluetooth
#endif



final public class BluetoothService: NSObject, CBPeripheralDelegate, CBCentralManagerDelegate {
    private var centralManager: CBCentralManager! = nil
    
    private var stateSubject: PassthroughSubject<CBManagerState, Never> = .init()
    private var peripheralSubject: PassthroughSubject<CBPeripheral, Never> = .init()
    private var serviceUUID: String = ""
    
    public var service: String {
        get {
            return self.serviceUUID
        }
        
        set(value) {
            self.serviceUUID = value
        }
    }
    
    public func start() throws -> Void {
        var uuid = self.serviceUUID == "" ? nil : CBUUID(string: self.serviceUUID)
        
        self.centralManager = .init(delegate: self, queue: nil)
        self.centralManager.scanForPeripherals(withServices: [uuid!])
    }
    
    public func connect(peripheral: CBPeripheral) throws -> Void {
        self.centralManager.stopScan()
        
        peripheral.delegate = self
        
        self.centralManager.connect(peripheral)
    }
    
    public func stop() throws -> Void {
        self.centralManager.stopScan()
    }
    
}

extension BluetoothService {
    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
        stateSubject.send(central.state)
        
        switch central.state {
        case .poweredOff:
            NSLog("Power OFf")
        case .poweredOn:
            NSLog("Powered On.")
            central.scanForPeripherals(withServices: nil)
        case .unsupported:
            NSLog("Unsupported.")
        case .unauthorized:
            NSLog("Unauthorized.")
        case .unknown:
            NSLog("Unknown")
        case .resetting:
            NSLog("Resetting")
        @unknown default:
            NSLog("Something is wrong")
        }
    }
    
    public func centralManager(
        _ central: CBCentralManager,
        didDiscover peripheral: CBPeripheral,
        advertisementData: [String : Any],
        rssi RSSI: NSNumber
    ) {
        peripheralSubject.send(peripheral)
    }
}
