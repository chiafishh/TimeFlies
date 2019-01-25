//
//  BViewController.swift
//  Years
//
//  Created by User02 on 2019/1/24.
//  Copyright © 2019 Chiafishh. All rights reserved.
//

import UIKit


class BViewController: UIViewController {
    
    var timer : Timer?
    var clickAuto = 0
    var timeImgYear = 99
    
   // var timer:NSTimer!
    
    @IBOutlet var ChooseImg: UIImageView!
    @IBOutlet var YearLabel: UILabel!
    @IBOutlet var YearSlider: UISlider!
    
    @IBOutlet var autoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if timer != nil {
            timer?.invalidate()
        }
    }
    
    @IBAction func YearSliderFunc(_ sender: Any) {
        //DateDPicker.date
        YearLabel.text = String(Int(YearSlider.value))
        ChooseImg.image = UIImage(named: "\(Int(YearSlider.value)).png")
    }
    
    @IBAction func ClickAutoButton(_ sender: Any) {
        if clickAuto == 0{
            clickAuto = 1
            timeImgYear = Int(YearSlider.value)
            autoButton.setTitle("停止",for: .normal)
            self.timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(timeFunc), userInfo: nil, repeats: true)
        }
        else{
            clickAuto = 0
            autoButton.setTitle("自動",for: .normal)
            if timer != nil {
                timer?.invalidate()
            }
        }
    }
    
    @objc func timeFunc() {
        //print("123")
        print(timeImgYear)
        YearLabel.text = "\(timeImgYear)"
        YearSlider.value = Float(timeImgYear)
        ChooseImg.image = UIImage(named: "\(timeImgYear).png")
        if timeImgYear < 108{
            timeImgYear += 1
        }
        else{
            timeImgYear = 99
        }        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

