//
//  檔名： ResultController.swift
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

class ResultController: UIViewController {
    //MARK: 屬性
    
    //Core data
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var tasks: [Score] = []
    
    //MARK: 視窗元件屬性
    @IBOutlet weak var resultTable: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //載入後抓取資料
        do {
            tasks = try context.fetch(Score.fetchRequest())
            
            //顯示成績
            for item in tasks {
                let a = item.answer
                let b = item.times
                resultTable.text? += "\n" + String(a) + " - " + String(b)
            }
        }
        catch {
            print("Fetching Failed")
        }
        
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
