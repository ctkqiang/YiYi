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
    private var btQueue = DispatchQueue(label: "BT Queue")
    public var peripherals: [CBPeripheral] = [CBPeripheral]()
    
    @Published public var peripheralNames: [[String]] = []
    
    public required override init() {
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: .main, options: nil)
    }
    
    public func start() throws -> Void {
        self.centralManager?.scanForPeripherals(withServices: nil)
    }
    
    public func connectToDevice(peripheral: CBPeripheral) throws -> Void {
        if self.centralManager?.state != CBManagerState.poweredOn {
            if peripheral.name!.isEmpty {
                NSLog("没有选择蓝牙外围设备。")
                return
            }
            
            self.centralManager?.connect(peripheral)
        }
    }
    
    public func stop() throws -> Void {
        self.centralManager!.stopScan()
    }
    
    public static func signalStrength(rssi: String) throws -> String {
        let value: Int = Int(rssi)!
        
        if value < -55 {
            return "非常强"
        }
        
        else if value < -67 && value > -55 {
            return "蛮强"
        }
        
        else if value < -80 && value > -67 {
            return "正常"
        }
        
        else if value < -90 && value > -80 {
            return "差"
        }
        
        else if value > -90 {
            return "非常差"
        }
        
        return "未知"
    }
    
}

extension BluetoothService: CBCentralManagerDelegate {
    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOff:
            NSLog("《蓝牙电源关闭》")
        case .poweredOn:
            NSLog("《蓝牙电源已开启》")
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
            print("\(advertisementData.keys)\(advertisementData.values)")
            self.peripheralNames.append([
                "《\(peripheral.name ?? "未命名的设备")》" ,
                String(describing: peripheral.debugDescription.decomposedStringWithCanonicalMapping),
                String(describing: peripheral.ancsAuthorized ? "《是》" : "《否》" ),
                String(describing: peripheral.services),
                String(describing: peripheral.state.rawValue == 0 ? "《断开连接》" : "《连接》"),
                peripheral.identifier.uuidString,
                "\(central.isScanning ? "是" : "否")",
                "\(advertisementData.debugDescription.decomposedStringWithCanonicalMapping)",
                RSSI.stringValue
            ])
        }
    }
}
