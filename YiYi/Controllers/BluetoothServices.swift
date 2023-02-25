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

public class BluetoothService: NSObject, ObservableObject, CBPeripheralDelegate {
    private var centralManager: CBCentralManager?
    private var peripherals: [CBPeripheral] = [CBPeripheral]()
    private var btQueue = DispatchQueue(label: "BT Queue")
    
    @Published public var peripheralNames: [[String]] = []
    
    public override init() {
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: self.btQueue, options: nil)
    }
   
    public func start() throws -> Void {
        self.centralManager?.scanForPeripherals(withServices: nil)
    }
    
    public func connect(peripheral: CBPeripheral) throws -> Void {
        
    }
    
    public func stop() throws -> Void {
        self.centralManager!.stopScan()
    }
    
}

extension BluetoothService: CBCentralManagerDelegate {
    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOff:
            NSLog("《蓝牙电源关闭》")
        case .poweredOn:
            NSLog("Powered On.")
            self.centralManager?.scanForPeripherals(withServices: nil)
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
        if !self.peripherals.contains(peripheral) {
            self.peripherals.append(peripheral)
            self.peripheralNames.append([
                peripheral.name ?? "《未命名的设备》",
                peripheral.debugDescription,
                String(describing: peripheral.ancsAuthorized),
                String(describing: peripheral.services)
            ])
        }
    }
}
