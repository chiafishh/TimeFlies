//
//  AViewController.swift
//  Years
//
//  Created by User02 on 2019/1/24.
//  Copyright © 2019 Chiafishh. All rights reserved.
//

import UIKit

class AViewController: UIViewController {
    var timer : Timer?
    var clickAuto = 0
    var timeImgYear = 85
    var alphaImg:Float = 0
    var delayYear = 0
    
    @IBOutlet var ChooseImg: UIImageView!
    @IBOutlet var ChooseImg2: UIImageView!
    @IBOutlet var YearSlider: UISlider!
    @IBOutlet var YearLabel: UILabel!    
    @IBOutlet var autoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ChooseImg2.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if timer != nil {
            timer?.invalidate()
        }
    }
    
    @IBAction func YearSliderFunc(_ sender: Any) {
        YearLabel.text = String(Int(YearSlider.value))
        ChooseImg.image = UIImage(named: "\(Int(YearSlider.value)).png")
        alphaImg = Float(YearSlider.value) - Float(Int(YearSlider.value))
        if alphaImg > 0.8{
            ChooseImg2.image = UIImage(named: "\(Int(YearSlider.value)+1).png")
            ChooseImg2.isHidden = false
        }
        else{
            ChooseImg2.isHidden = true
        }
        print(Float(YearSlider.value))
    }
    
    @IBAction func ClickAutoButton(_ sender: Any) {
        if clickAuto == 0{
            clickAuto = 1
            autoButton.setTitle("停止",for: .normal)
            timeImgYear = Int(YearSlider.value)
            self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(timeFunc), userInfo: nil, repeats: true)
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

        delayYear = timeImgYear + 1
        
        print("delay")
        
        ChooseImg2.image = UIImage(named: "\(delayYear).png")
        ChooseImg2.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500), execute: {
            self.ChooseImg2.isHidden = true
            
            self.YearLabel.text = "\(self.timeImgYear)"
            self.YearSlider.value = Float(self.timeImgYear)
            //ChooseImg2.isHidden = true
            self.ChooseImg.image = UIImage(named: "\(self.timeImgYear).png")
        })
        print("delayE")
                
        if timeImgYear < 108{
            timeImgYear += 1
        }
        else{
            timeImgYear = 85
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
