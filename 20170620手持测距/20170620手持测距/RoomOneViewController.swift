//
//  RoomOneViewController.swift
//  20170620手持测距
//
//  Created by Duanz on 2017/6/20.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit
import CoreBluetooth

class RoomOneViewController: UIViewController,CBCentralManagerDelegate,CBPeripheralDelegate {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
