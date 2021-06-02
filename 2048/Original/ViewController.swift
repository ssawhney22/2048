//
//  ViewController.swift
//  2048
//
//  Created by Sumair Sawhney on 12/31/18.
//  Copyright © 2018 Sawhney. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var Label00: UILabel!
    @IBOutlet weak var Label10: UILabel!
    @IBOutlet weak var Label20: UILabel!
    @IBOutlet weak var Label30: UILabel!
    @IBOutlet weak var Label01: UILabel!
    @IBOutlet weak var Label11: UILabel!
    @IBOutlet weak var Label21: UILabel!
    @IBOutlet weak var Label02: UILabel!
    @IBOutlet weak var Label31: UILabel!
    @IBOutlet weak var Label12: UILabel!
    @IBOutlet weak var Label22: UILabel!
    @IBOutlet weak var Label32: UILabel!
    @IBOutlet weak var Label03: UILabel!
    @IBOutlet weak var Label13: UILabel!
    @IBOutlet weak var Label23: UILabel!
    @IBOutlet weak var Label33: UILabel!
    @IBOutlet weak var BackgroundLabel: UILabel!
    @IBAction func newGame(_ sender: UIButton) {
        arr2D = Array(repeating:Array(repeating: 0, count: 4), count: 4)
        updateBoard()
        randomPos()
        randomPos()
    }
    
    var arr2D = Array(repeating:Array(repeating: 0, count: 4), count: 4)
    override func viewDidLoad() {
        super.viewDidLoad()
        arr2D[0][1]=2
        arr2D[0][2]=4
        arr2D[0][3]=8
        arr2D[1][0]=16
        arr2D[1][1]=32
        arr2D[1][2]=64
        arr2D[1][3]=128
        arr2D[2][0]=256
        arr2D[2][1]=512
        arr2D[2][2]=1024
        arr2D[2][3]=1024
        arr2D[3][0]=512
        arr2D[3][1]=512
        arr2D[3][2]=512
        arr2D[3][3]=512
        updateBoard()
        swipes()
    }
    func swipes()  {
        let tempArr = arr2D
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture))
        swipeRight.direction=UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture))
        swipeLeft.direction=UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture))
        swipeDown.direction=UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(swipeDown)
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture))
        swipeUp.direction=UISwipeGestureRecognizerDirection.up
        self.view.addGestureRecognizer(swipeUp)
        
    }
    @objc  func swipeGesture(gesture : UISwipeGestureRecognizer) {
        let tempArr = arr2D
        switch gesture.direction {
        case UISwipeGestureRecognizerDirection.right:
            print("Right")
            for i in 0...2{
                for j in 0...3{
                    if(arr2D[j][i+1]==0){
                        arr2D[j][i+1]=arr2D[j][i]
                        arr2D[j][i]=0
                    }
                    else if(arr2D[j][i+1]==arr2D[j][i]){
                        arr2D[j][i+1]=2*arr2D[j][i]
                        arr2D[j][i]=0
                    }
                }
            }
        case UISwipeGestureRecognizerDirection.left:
            print("Left")
            for i in stride(from: 3, through: 1, by: -1){
                for j in stride(from: 3, through: 0, by: -1){
                    if(arr2D[j][i-1]==0){
                        arr2D[j][i-1]=arr2D[j][i]
                        arr2D[j][i]=0
                    }
                    else if(arr2D[j][i-1]==arr2D[j][i]){
                        arr2D[j][i-1]=2*arr2D[j][i-1]
                        arr2D[j][i]=0
                    }
                }
            }
        case UISwipeGestureRecognizerDirection.down:
            print("Down")
            for i in 0...3{
                for j in 0...2{
                    if(arr2D[j+1][i]==0){
                        arr2D[j+1][i]=arr2D[j][i]
                        arr2D[j][i]=0
                    }
                    else if(arr2D[j+1][i]==arr2D[j][i]){
                        arr2D[j+1][i]=2*arr2D[j][i]
                        arr2D[j][i]=0
                    }
                }
            }
        case UISwipeGestureRecognizerDirection.up:
            print("Up")
            for i in stride(from: 3, through: 0, by: -1){
                for j in stride(from: 3, through: 1, by: -1){
                    if(arr2D[j-1][i]==0){
                        arr2D[j-1][i]=arr2D[j][i]
                        arr2D[j][i]=0
                    }
                    else if(arr2D[j-1][i]==arr2D[j][i]){
                        arr2D[j-1][i]=2*arr2D[j][i]
                        arr2D[j][i]=0
                    }
                }
            }
        default:
            break
        }
        if(tempArr == arr2D){
        var gameOver = true
        for i in 0...3{
            for j in 0...3{
                if(arr2D[j][i] == 0){
                    gameOver=false
                }
            }
        }
        if(gameOver){
            print("GAME OVER, Press New Game")
            let alertController = UIAlertController(title: "GAME OVER", message: "Press New Game", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            print(arr2D)
            updateBoard()
            }
        }
        else{
            print(arr2D)
            updateBoard()
            randomPos()
        }
        }
    func randomPos() {
        var startX1=Int(arc4random() % 4)
        var startY1=Int(arc4random() % 4)
        while(arr2D[startY1][startX1] != 0){
            startX1=Int(arc4random() % 4)
            startY1=Int(arc4random() % 4)
        }
        print(startX1,startY1)
        arr2D[startY1][startX1]=2
        updateBoard()
    }
    func updateBoard() {
        for i in 0...3 {
            for j in 0...3{
                   changeColor(i: arr2D[j][i], lab: setPosition(x: i, y: j))
            }
        }
    }
    func changeColor(i: Int, lab: UILabel) {
        lab.text=String(i)
        lab.adjustsFontSizeToFitWidth=true
        switch i {
        case 2:
            lab.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            lab.backgroundColor = UIColor(red:CGFloat(200)/255, green: CGFloat(200)/255, blue: CGFloat(200)/255, alpha: 1)
        case 4:
            lab.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            lab.backgroundColor = UIColor(red:CGFloat(240)/255, green: CGFloat(26)/255, blue: CGFloat(64)/255, alpha: 1)
        case 8:
            lab.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            lab.backgroundColor = UIColor(red:CGFloat(253)/255, green: CGFloat(176)/255, blue: CGFloat(64)/255, alpha: 1)
        case 16:
            lab.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            lab.backgroundColor = UIColor(red:CGFloat(61)/255, green: CGFloat(220)/255, blue: CGFloat(158)/255, alpha: 1)
        case 32:
            lab.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            lab.backgroundColor = UIColor(red:CGFloat(178)/255, green: CGFloat(125)/255, blue: CGFloat(140)/255, alpha: 1)
        case 64:
            lab.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            lab.backgroundColor = UIColor(red:CGFloat(87)/255, green: CGFloat(156)/255, blue: CGFloat(65)/255, alpha: 1)
        case 128:
            lab.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            lab.backgroundColor = UIColor(red:CGFloat(50)/255, green: CGFloat(144)/255, blue: CGFloat(223)/255, alpha: 1)
        case 256:
            lab.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            lab.backgroundColor = UIColor(red:CGFloat(150)/255, green: CGFloat(144)/255, blue: CGFloat(223)/255, alpha: 1)
        case 512:
            lab.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            lab.backgroundColor = UIColor(red:CGFloat(50)/255, green: CGFloat(14)/255, blue: CGFloat(223)/255, alpha: 1)
        case 1024:
            lab.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            lab.backgroundColor = UIColor(red:CGFloat(110)/255, green: CGFloat(111)/255, blue: CGFloat(93)/255, alpha: 1)
        case 2048:
            lab.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            lab.backgroundColor = UIColor(red:CGFloat(50)/255, green: CGFloat(61)/255, blue: CGFloat(23)/255, alpha: 1)
        default:
            lab.textColor = UIColor(red:CGFloat(220)/255, green: CGFloat(215)/255, blue: CGFloat(184)/255, alpha: 1)
            lab.backgroundColor = UIColor(red:CGFloat(220)/255, green: CGFloat(215)/255, blue: CGFloat(184)/255, alpha: 1)
        }
        
    }
    func setPosition(x: Int,y: Int)->UILabel{
        if(x==0 && y==0){
            return Label00
        }
        else if(x==1 && y==0){
            return Label10
        }
        else if(x==2 && y==0){
            return Label20
        }
        else if(x==3 && y==0){
            return Label30
        }
        else if(x==0 && y==1){
            return Label01
        }
        else if(x==1 && y==1){
            return Label11
        }
        else if(x==2 && y==1){
            return Label21
        }
        else if(x==3 && y==1){
            return Label31
        }
        else if(x==0 && y==2){
            return Label02
        }
        else if(x==1 && y==2){
            return Label12
        }
        else if(x==2 && y==2){
            return Label22
        }
        else if(x==3 && y==2){
            return Label32
        }
        else if(x==0 && y==3){
            return Label03
        }
        else if(x==1 && y==3){
            return Label13
        }
        else if(x==2 && y==3){
            return Label23
        }
        else{
             return Label33
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

