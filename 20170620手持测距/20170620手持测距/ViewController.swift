//
//  ViewController.swift
//  20170620手持测距
//
//  Created by Duanz on 2017/6/20.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController,CBCentralManagerDelegate,CBPeripheralDelegate {
    
    var myCentralManager : CBCentralManager!
    var myPeripheral : CBPeripheral!
    
    let distance = "2A19"
    
    @IBOutlet weak var scanbutton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
         myCentralManager = CBCentralManager.init(delegate: self as? CBCentralManagerDelegate, queue: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func Scan(_ sender: UIButton) {
        switch myCentralManager.state{
        case .poweredOn:NSLog("正在扫描")
                        myCentralManager.scanForPeripherals(withServices: nil, options: nil)
                        statusLabel.text = "正在扫描"
                        self.scanbutton.isEnabled = false
        default: break
        }
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch myCentralManager.state {
        case .poweredOn:
            NSLog("蓝牙已开启")
            statusLabel.text? = "蓝牙已开启"
        default:
            NSLog("蓝牙没打开")
            statusLabel.text? = "蓝牙未开启"
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if peripheral.identifier.uuidString == "A6C1857E-7FE0-4C36-890E-AB9CDD253FF7"{
            myPeripheral = peripheral
            central.stopScan()
            central.connect(peripheral, options: nil)
            statusLabel.text? = "开始连接"
            print("正在连接")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        statusLabel.text? = "连接成功，正在扫描信息"
        peripheral.delegate = self
        peripheral.discoverServices(nil)
        
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        statusLabel.text? = "连接失败"
        scanbutton.isEnabled = true
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if((error) != nil){
            statusLabel.text? = "查找服务失败"
            scanbutton.isEnabled = true
        }else{
            for service in peripheral.services! {
                peripheral.discoverCharacteristics(nil, for: service)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if((error) != nil){
            statusLabel.text = "查找服务失败"
            scanbutton.isEnabled = true
        }else{
            for characteristic in service.characteristics! {
                peripheral.setNotifyValue(true, for: characteristic)
                if(characteristic.uuid.uuidString == distance){
                    peripheral.readValue(for: characteristic)
                }
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if((error) != nil){
            statusLabel.text? = "获取数值失败"
            return
        }else{
            if(characteristic.uuid.uuidString == distance){
                var distancebyte = [UInt8](characteristic.value!)
                let distancevalue : Int = Int.init(distancebyte[0])
                self.statusLabel.text = String.init(format: "距离是：%d",statusLabel.text!,distancevalue)
            }
            scanbutton.isEnabled = true
            statusLabel.text = "Done"
        }
    }
}

