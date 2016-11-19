//
//  QuizViewController.swift
//  Quiz
//
//  Created by Lilico Isomata on 2016/11/05.
//  Copyright © 2016年 Lilico Isomata. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    //問題文を格納する配列
    var quizArray = [AnyObject]()
    
    //正解数
    var correctAnswer: Int = 0
    
    //クイズを表示するTextView
    @IBOutlet var quizTextView: UITextView!
    
    //選択肢のボタン
    @IBOutlet var choiceButton1: UIButton!
    @IBOutlet var choiceButton2: UIButton!
    @IBOutlet var choiceButton3: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //一時的にクイズを格納しておく配列
        var tmpArray = [AnyObject]()
        
        //tmpアラートに問題文と３つの答えの番号の入った配列を追加していく
        tmpArray.append(["真田家","sanada.png","simazu.png","kuroda.png",1])
        tmpArray.append(["毛利家","mouri.png","kuroda.png","simazu.png",1])
        tmpArray.append(["豊臣家","takeda.png","toyotomi.png","oda.png",2])
        tmpArray.append(["徳川家","toyotomi.png","tokugawa.png","oda.png",2])
        tmpArray.append(["立花家","sanada.png","aketi.png","tatibana.png",3])
        tmpArray.append(["明智家","oda.png","kuroda.png","aketi.png",3])
        
        //問題をシャッフルしてquizArrayに格納する
        srand(UInt32(time(nil)))
        while (tmpArray.count > 0) {
            let index = Int(rand()) % tmpArray.count
            quizArray.append(tmpArray[index])
            tmpArray.removeAtIndex(index)
            
        }
        choiceQuiz()
    }
    
    func choiceQuiz() {
        
        //問題文のテキストを表示
        quizTextView.text = quizArray[0][0] as! String
        
        //選択肢のボタンにそれぞれ選択肢のテキストをセットする
//        choiceButton1.setTitle(quizArray[0][1] as? String, forState: .Normal)
//        choiceButton2.setTitle(quizArray[0][2] as? String, forState: .Normal)
//        choiceButton3.setTitle(quizArray[0][3] as? String, forState: .Normal)
        choiceButton1.setBackgroundImage(UIImage(named: (quizArray[0][1] as? String)!), forState: .Normal)
        choiceButton2.setBackgroundImage(UIImage(named: (quizArray[0][2] as? String)!), forState: .Normal)
        choiceButton3.setBackgroundImage(UIImage(named: (quizArray[0][3] as? String)!), forState: .Normal)
    
    
    }
    
    @IBAction func choiceAnswer(sender: UIButton) {
        if quizArray[0][4] as! Int == sender.tag {
            
            //正解数を増やす
            correctAnswer = correctAnswer + 1
        }
        
        //解いた問題をquizArrayから取り除く
//        quizArray.removeAtIndex(0)
        
        //alertを出す
        let alert = UIAlertController(title: "答えは\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", message: "",
                                      preferredStyle: UIAlertControllerStyle.Alert)
        let alertHeight:NSLayoutConstraint =
            NSLayoutConstraint(
                item: alert.view,
                attribute: NSLayoutAttribute.Height,
                relatedBy: NSLayoutRelation.Equal,
                toItem: nil,
                attribute: NSLayoutAttribute.NotAnAttribute,
                multiplier: 1,
                constant: self.view.frame.height * 0.50)
        alert.view.addConstraint(alertHeight)
        
        let correctNumber = quizArray[0][4] as! Int
        let image = UIImageView(image :UIImage(named: (quizArray[0][correctNumber] as? String)!)!)
        let rect = CGRectMake(75,50,120,150)
        image.frame = rect
        alert.view.addSubview(image)
        
        //解いた問題をquizArrayから取り除く
        quizArray.removeAtIndex(0)

        alert.addAction(
                UIAlertAction(
                    title: "次の問題",
                    style:  UIAlertActionStyle.Default,
                    handler:  { action in
                        //ボタンが押された時の動作
                        //quizArrayに残っている問題数を設定して問題数を決め、それに達したら結果画面へ
                        if self.quizArray.count == 3 {
                            self.performSegueToResult()
                        } else {
                            self.choiceQuiz()
                        }
                    })
        )
        
        presentViewController(alert,animated: true, completion: nil)

        
    }
    
    func performSegueToResult() {
        performSegueWithIdentifier("toResultView", sender: nil)
        
    }
    //セグエを準備する時に呼ばれるメソッド
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toResultView" {
            let resultViewController = segue.destinationViewController as! ResultViewController
            resultViewController.correctAnswer = self.correctAnswer
        }
    
    }
    
        
        
        

        // Do any additional setup after loading the view.
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
