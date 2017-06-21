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
        if (peripheral.name?.hasSuffix("101"))!{
            myPeripheral = peripheral
            central.stopScan()
            central.connect(peripheral, options: nil)
            statusLabel.text? = "开始连接"
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

}

