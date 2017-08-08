//
//  檔名： GameController.swift
//  專案： GuessGame2
//
//  《Swift 入門指南》 V3.00 的範例程式
//  購書連結
//         Google Play  : https://play.google.com/store/books/details?id=AO9IBwAAQBAJ
//         iBooks Store : https://itunes.apple.com/us/book/id1079291979
//         Readmoo      : https://readmoo.com/book/210034848000101
//         Pubu         : http://www.pubu.com.tw/ebook/65565?apKey=576b20f092
//
//  作者網站： http://www.kaiching.org
//  電子郵件： kaichingc@gmail.com
//
//  作者： 張凱慶
//  時間： 2017/08/01
//

import UIKit
import GameplayKit

class GameController: UIViewController {
    //MARK: 屬性
    
    //答案
    var answer: Int? = nil
    var answerArray = [Int]()
    
    //使用者輸入
    var userinput = -1
    var userinputString = ""
    var userInputArray = [Int]()
    
    //位數與計次
    var digit = 0
    var aCounter = 0
    var bCounter = 0
    var count = 0
    
    //Core data
    static var count = 0
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var tasks: [Score] = []
    
    //MARK: 視窗屬性
    @IBOutlet weak var displayNumber: UILabel!
    @IBOutlet weak var displayAB: UILabel!
    @IBOutlet weak var displayTimes: UILabel!
    @IBOutlet weak var displayTable: UITextView!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    @IBOutlet weak var button0: UIButton!
    
    //MARK: 視窗方法
    
    @IBAction func method1(_ sender: UIButton) {
        userinput = 1
        next()
    }
    
    @IBAction func method2(_ sender: UIButton) {
        userinput = 2
        next()
    }
    
    @IBAction func method3(_ sender: UIButton) {
        userinput = 3
        next()
    }
    
    @IBAction func method4(_ sender: UIButton) {
        userinput = 4
        next()
    }
    
    @IBAction func method5(_ sender: UIButton) {
        userinput = 5
        next()
    }
    
    @IBAction func method6(_ sender: UIButton) {
        userinput = 6
        next()
    }
    
    @IBAction func method7(_ sender: UIButton) {
        userinput = 7
        next()
    }
    
    @IBAction func method8(_ sender: UIButton) {
        userinput = 8
        next()
    }
    
    @IBAction func method9(_ sender: UIButton) {
        userinput = 9
        next()
    }
    
    @IBAction func method0(_ sender: UIButton) {
        userinput = 0
        next()
    }
    
    //MARK: 方法
    
    //按下按鈕後統一處理
    func next() {
        //位數遞增
        digit += 1
        
        //將使用者輸入加入答案陣列
        userInputArray.append(userinput)
        
        //顯示使用者輸入
        var temp = ""
        for i in userInputArray {
            temp += String(i)
        }
        displayNumber.text = temp
        
        //處理重複數字
        switch userinput {
        case 0:
            button0.isEnabled = false
            button0.backgroundColor = UIColor.lightGray
        case 1:
            button1.isEnabled = false
            button1.backgroundColor = UIColor.lightGray
        case 2:
            button2.isEnabled = false
            button2.backgroundColor = UIColor.lightGray
        case 3:
            button3.isEnabled = false
            button3.backgroundColor = UIColor.lightGray
        case 4:
            button4.isEnabled = false
            button4.backgroundColor = UIColor.lightGray
        case 5:
            button5.isEnabled = false
            button5.backgroundColor = UIColor.lightGray
        case 6:
            button6.isEnabled = false
            button6.backgroundColor = UIColor.lightGray
        case 7:
            button7.isEnabled = false
            button7.backgroundColor = UIColor.lightGray
        case 8:
            button8.isEnabled = false
            button8.backgroundColor = UIColor.lightGray
        case 9:
            button9.isEnabled = false
            button9.backgroundColor = UIColor.lightGray
        default:
            lockButtons()
        }
        
        //將0改成可按
        if !userInputArray.contains(0) {
            button0.isEnabled = true
            button0.backgroundColor = UIColor.darkGray
        }
        
        //猜完一次
        if digit == 4 {
            count += 1
            displayTimes.text = String(count)
            
            userinputString = displayNumber.text!
            
            //計算AB值
            for i in userInputArray {
                if answerArray.contains(i) {
                    if userInputArray.index(of: i) == answerArray.index(of: i) {
                        aCounter += 1
                    }
                    else {
                        bCounter += 1
                    }
                }
            }
            
            //結果處理
            if aCounter == 4 {
                //結束遊戲
                displayAB.text = "猜中！"
                lockButtons()
                
                //儲存到 Core Data
                let task = Score(context: context)
                task.answer = Int64(answer!)
                task.times = Int64(count)
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
                
                //轉移到 Result Scene
                let newScene = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "Result") as UIViewController
                let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
                appDelegate.window?.rootViewController = newScene
            }
            else {
                //顯示結果
                displayAB.text = String(aCounter) + "A" + String(bCounter) + "B"
                displayTable.text? += userinputString + ":" + displayAB.text! + "\n"
                //歸零
                reset()
            }
        }
    }
    
    //歸零
    func reset() {
        userinput = -1
        userinputString = ""
        userInputArray.removeAll()
        displayNumber.text = " "
        digit = 0
        aCounter = 0
        bCounter = 0
        unlockButtons()
        //第一位數不能為0
        button0.isEnabled = false
        button0.backgroundColor = UIColor.lightGray
    }
    
    //將按鈕鎖上
    func lockButtons() {
        button0.isEnabled = false
        button0.backgroundColor = UIColor.lightGray
        button1.isEnabled = false
        button1.backgroundColor = UIColor.lightGray
        button2.isEnabled = false
        button2.backgroundColor = UIColor.lightGray
        button3.isEnabled = false
        button3.backgroundColor = UIColor.lightGray
        button4.isEnabled = false
        button4.backgroundColor = UIColor.lightGray
        button5.isEnabled = false
        button5.backgroundColor = UIColor.lightGray
        button6.isEnabled = false
        button6.backgroundColor = UIColor.lightGray
        button7.isEnabled = false
        button7.backgroundColor = UIColor.lightGray
        button8.isEnabled = false
        button8.backgroundColor = UIColor.lightGray
        button9.isEnabled = false
        button9.backgroundColor = UIColor.lightGray
    }
    
    //將按鈕打開
    func unlockButtons() {
        button0.isEnabled = true
        button0.backgroundColor = UIColor.darkGray
        button1.isEnabled = true
        button1.backgroundColor = UIColor.darkGray
        button2.isEnabled = true
        button2.backgroundColor = UIColor.darkGray
        button3.isEnabled = true
        button3.backgroundColor = UIColor.darkGray
        button4.isEnabled = true
        button4.backgroundColor = UIColor.darkGray
        button5.isEnabled = true
        button5.backgroundColor = UIColor.darkGray
        button6.isEnabled = true
        button6.backgroundColor = UIColor.darkGray
        button7.isEnabled = true
        button7.backgroundColor = UIColor.darkGray
        button8.isEnabled = true
        button8.backgroundColor = UIColor.darkGray
        button9.isEnabled = true
        button9.backgroundColor = UIColor.darkGray
    }
    
    //MARK: 預設方法
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //設定答案
        answerArray = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        
        while true {
            answerArray = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: answerArray) as! [Int]
            
            if answerArray[0] != 0 {
                break
            }
        }
        
        answerArray = [answerArray[0], answerArray[1], answerArray[2], answerArray[3]]
        answer = answerArray[0] * 1000 + answerArray[1] * 100 + answerArray[2] * 10 + answerArray[3]
                
        //歸零
        reset()
        count = 0
        
        //設定訊息
        displayNumber.text = "開始遊戲"
        displayAB.text = " "
        displayTimes.text = " "
        displayTable.text? = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
