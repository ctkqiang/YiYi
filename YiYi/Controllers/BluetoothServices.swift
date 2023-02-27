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
    private var sendCharacteristic:CBCharacteristic?
    
    public var peripherals: [CBPeripheral] = [CBPeripheral]()
    public var isBluetoothUnavailable: Bool = true
    
    @Published public var peripheralNames: [[String]] = [[String]]()
    @Published public var scannedPeripheral: [BluetoothPeripherals] = [BluetoothPeripherals]()
    
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
            } else {
                self.centralManager?.connect(peripheral)
            }
        }
    }
    
    public var bluetoothStatus: Bool {
        get {
            return self.isBluetoothUnavailable
        }
        
        set(isBluetoothOff) {
            self.isBluetoothUnavailable = isBluetoothOff
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
    
    public func writeDataToPeripheral(data: Data, peripheral: CBPeripheral, result: @escaping(String) -> ()) throws -> Void {
        DispatchQueue.main.async {
            peripheral.writeValue(data, for: self.sendCharacteristic!, type:CBCharacteristicWriteType.withResponse)
            
            result("ok")
        }
    }
}

extension BluetoothService: CBCentralManagerDelegate {
    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOff:
            NSLog("《蓝牙电源关闭》")
            self.bluetoothStatus = false
        case .poweredOn:
            NSLog("《蓝牙电源已开启》")
            self.bluetoothStatus = false
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
            
            let result = BluetoothPeripherals(
                id: self.scannedPeripheral.count,
                name: "《\(peripheral.name ?? "未命名的设备")》",
                debugInfo: String(describing: peripheral.debugDescription.decomposedStringWithCanonicalMapping),
                ancsAuth: String(describing: peripheral.ancsAuthorized ? "《是》" : "《否》" ),
                services: String(describing: peripheral.services),
                stauts: String(describing: peripheral.state.rawValue == 0 ? "《断开连接》" : "《连接》"),
                uuid: peripheral.identifier.uuidString,
                isScanning: "\(central.isScanning ? "是" : "否")",
                data:  "\(advertisementData.debugDescription.decomposedStringWithCanonicalMapping)",
                rssi: RSSI.stringValue
            )
            
            self.scannedPeripheral.append(result)
        }
    }
}
