//
//  RoomOneViewController.swift
//  20170620手持测距
//
//  Created by Duanz on 2017/6/20.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit
import CoreBluetooth

class RoomOneViewController: UIViewController,CBPeripheralDelegate{

    @IBOutlet weak var textfiled: UITextField!
    @IBOutlet weak var doortextfield: UITextField!
    @IBOutlet weak var windowtextfiled: UITextField!
    
    @IBOutlet weak var doorScanHigh: UIButton!
    @IBOutlet weak var doorScanLength: UIButton!
    @IBOutlet weak var doortoLeft: UIButton!
    @IBOutlet weak var doortoRight: UIButton!
    @IBOutlet weak var doorHighLabel: UILabel!
    @IBOutlet weak var doorLengthLabel: UILabel!
    @IBOutlet weak var doortoLeftLabel: UILabel!
    @IBOutlet weak var doortoRightLabel: UILabel!
    
    @IBOutlet weak var windowScanHigh: UIButton!
    @IBOutlet weak var windowScanLength: UIButton!
    @IBOutlet weak var windowtoLeft: UIButton!
    @IBOutlet weak var windowtoRight: UIButton!
    @IBOutlet weak var windowtoGround: UIButton!
    @IBOutlet weak var windowtoTop: UIButton!
    @IBOutlet weak var windowHighLabel: UILabel!
    @IBOutlet weak var windowLengthLabel: UILabel!
    @IBOutlet weak var windowtoLeftLabel: UILabel!
    @IBOutlet weak var windowtoRightLabel: UILabel!
    @IBOutlet weak var windowtoGroundLabel: UILabel!
    @IBOutlet weak var windowtoTopLabel: UILabel!
    
    @IBOutlet weak var changbutton: UIButton!
    @IBOutlet weak var changlebel: UILabel!
    @IBOutlet weak var kuanbutton: UIButton!
    @IBOutlet weak var kuanlabel: UILabel!
    @IBOutlet weak var gaobutton: UIButton!
    @IBOutlet weak var gaolabel: UILabel!
    
    
    @IBAction func nametexting(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func doorlocation(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func windowlocation(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    let distance = "2A16"//改
    var myPeripheral : CBPeripheral!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        for service in peripheral.services!{
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        for characteristic in service.characteristics!{
            peripheral.setNotifyValue(true, for: characteristic)
            if characteristic.uuid.uuidString == distance{
                peripheral.readValue(for: characteristic)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if characteristic.uuid.uuidString == distance{
            var distancebyte = [UInt8](characteristic.value!)
            let distancevalue : Int = Int.init(distancebyte[0])
            if changbutton.isTouchInside == true{
                self.changlebel.text = String.init(format: "%d", changlebel.text!,distancevalue)
            }
            if kuanbutton.isTouchInside == true{
                 self.kuanlabel.text = String.init(format: "%d", kuanlabel.text!,distancevalue)
            }
            if gaobutton.isTouchInside == true{
                self.gaolabel.text = String.init(format: "%d", gaolabel.text!,distancevalue)
            }
            
            if doorScanHigh.isTouchInside == true{
                self.doorHighLabel.text = String.init(format: "%d", doorHighLabel.text!,distancevalue)
            }
            if doortoLeft.isTouchInside == true{
                self.doortoLeftLabel.text = String.init(format: "%d", doortoLeftLabel.text!,distancevalue)
            }
            if doortoRight.isTouchInside == true{
                self.doortoRightLabel.text = String.init(format: "%d", doortoRightLabel.text!,distancevalue)
            }
            if doorScanLength.isTouchInside == true{
                self.doorLengthLabel.text = String.init(format: "%d", doorLengthLabel.text!,distancevalue)
            }
            
            if windowScanHigh.isTouchInside == true{
                self.windowHighLabel.text = String.init(format: "%d", windowHighLabel.text!,distancevalue)
            }
            if windowScanLength.isTouchInside == true{
                self.windowLengthLabel.text = String.init(format: "%d", windowLengthLabel.text!,distancevalue)
            }
            if windowtoTop.isTouchInside == true{
                self.windowtoTopLabel.text = String.init(format: "%d", windowtoTopLabel.text!,distancevalue)
            }
            if windowtoRight.isTouchInside == true{
                self.windowtoRightLabel.text = String.init(format: "%d", windowtoRightLabel.text!,distancevalue)
            }
            if windowtoLeft.isTouchInside == true{
                self.windowtoLeftLabel.text = String.init(format: "%d", windowtoLeftLabel.text!,distancevalue)
            }
            if windowtoGround.isTouchInside == true{
                self.windowtoGroundLabel.text = String.init(format: "%d", windowtoGroundLabel.text!,distancevalue)
            }
        }
    }
}
