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
        //即將換下一年的照片時，會疊圖現在的照片跟下一年的照片
        alphaImg = Float(YearSlider.value) - Float(Int(YearSlider.value))        
        //ChooseImg2是疊圖的上面那張圖，是半透明的(直接設定的)，要顯示下一張照片
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
            //點選自動就能自動播放照片
            clickAuto = 1
            autoButton.setTitle("停止",for: .normal)//點選自動後，按鈕文字會變為「停止」
            timeImgYear = Int(YearSlider.value)//從當下顯示的年分開始撥放
            //用Timer，每1.5秒會自動運作 function timeFunc 來自動播放
            self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(timeFunc), userInfo: nil, repeats: true)
        }
        else{
            //點選停止就會停止自動播放照片
            clickAuto = 0
            autoButton.setTitle("自動",for: .normal)//點選停止後，按鈕文字會變回「自動」
            if timer != nil {
                timer?.invalidate()
            }
        }
    }
    
    @objc func timeFunc() {
        //print("123")
        print(timeImgYear)

        //一、先顯示去年的照片加上今年的照片的疊圖:
        //疊圖的上面那張要顯示下一張照片
        delayYear = timeImgYear + 1//下一張照片        
        //ChooseImg2是疊圖的上面那張圖，是半透明的(直接設定的)，要顯示下一張照片
        ChooseImg2.image = UIImage(named: "\(delayYear).png")
        ChooseImg2.isHidden = false      

        if timeImgYear < 108{
            timeImgYear += 1
        }
        else{
            timeImgYear = 85
        }
        
        //延遲功能，延遲0.5秒(500milliseconds)，進來timeFunc後，會先顯示去年的照片加上今年的照片的疊圖，0.5秒後，再只顯示這年的圖
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500), execute: {
            //二、只顯示這年的圖
            self.ChooseImg2.isHidden = true//疊圖的上面那張ChooseImg2隱藏            
            self.YearLabel.text = "\(self.timeImgYear)"
            self.YearSlider.value = Float(self.timeImgYear)
            self.ChooseImg.image = UIImage(named: "\(self.timeImgYear).png")
        })
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
