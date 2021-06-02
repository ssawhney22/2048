//
//  ViewController.swift
//  2048
//
//  Created by Sumair Sawhney on 12/31/18.
//  Copyright © 2018 Sawhney. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController{
    var testString: String! = nil
    var scoreKeeper: Int! = 0
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
    @IBOutlet weak var Score: UILabel!
    @IBOutlet weak var BackgroundLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    @IBAction func resetGame(_ sender: Any) {
        self.newGame();
    }
    override func viewDidDisappear(_ animated: Bool) {
          // peripheralManager?.stopAdvertising()
          // self.peripheralManager = nil
          super.viewDidDisappear(animated)
          NotificationCenter.default.removeObserver(self)
          
      }
    //Begins the game with two new tiles
    func newGame() {
        arr2D = Array(repeating:Array(repeating: 0, count: 4), count: 4)
        setUp()
        updateBoard()
        randomPos()
        randomPos()
    }
    
    
    var arr2D = Array(repeating:Array(repeating: 0, count: 4), count: 4)
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        newGame()
        
        //pressureGesture(str:"")
    }
    //Generates a random position for a new tile
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
  //Creates all swipe gesture recognizers
    func setUp()  {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
        BackgroundLabel.layer.masksToBounds = true
        BackgroundLabel.layer.cornerRadius = 4
        resetButton.backgroundColor = UIColor.lightGray
        resetButton.setTitleColor(UIColor.white, for: .normal)
        resetButton.layer.masksToBounds = true
        resetButton.layer.cornerRadius = 4
        resetButton.titleLabel?.adjustsFontSizeToFitWidth = true
        Score.backgroundColor = UIColor.lightGray
        Score.textColor = UIColor.white
        Score.layer.masksToBounds = true
        Score.layer.cornerRadius = 4
        Score.text = "Score: " + String(0)
        Score.adjustsFontSizeToFitWidth = true
    }
    //Processes swipe gestures into game movements
    @objc  func swipeGesture(swipe : UISwipeGestureRecognizer) {
        let tempArr = arr2D
        switch swipe.direction{
        case .right:
            print("Right")
           for i in stride(from: 0, through: 3, by: 1){
            for j in stride(from: 3, through: 1, by: -1){
                for k in stride(from: j-1, through: 0, by: -1){
                        if( arr2D[i][k] != 0){
                            if(arr2D[i][j]==0){
                                arr2D[i][j]=arr2D[i][k]
                                arr2D[i][k]=0
                            }
                            else if(arr2D[i][j]==arr2D[i][k]){
                                arr2D[i][j]=2*arr2D[i][j]
                                arr2D[i][k]=0
                            }
                        }
                    
                    }
                }
            }
            case .left:
            print("Left")
           for i in stride(from: 0, through: 3, by: 1){
            for j in stride(from: 0, through: 2, by: 1){
                for k in stride(from: j+1, through: 3, by: 1){
                        if( arr2D[i][k] != 0){
                            if(arr2D[i][j]==0){
                                arr2D[i][j]=arr2D[i][k]
                                arr2D[i][k]=0
                            }
                            else if(arr2D[i][j]==arr2D[i][k]){
                                arr2D[i][j]=2*arr2D[i][j]
                                arr2D[i][k]=0
                                
                            }
                        }
                    
                    }
                }
            }
            case  .down:
            print("Down")
            for i in stride(from: 3, through: 1, by: -1){
            for j in stride(from: 0, through: 3, by: 1){
                for k in stride(from: i-1, through: 0, by: -1){
                        if( arr2D[k][j] != 0){
                            if(arr2D[i][j]==0){
                                arr2D[i][j]=arr2D[k][j]
                                arr2D[k][j]=0
                            }
                            else if(arr2D[i][j]==arr2D[k][j]){
                                arr2D[i][j]=2*arr2D[i][j]
                                arr2D[k][j]=0
                               
                            }
                        }
                    
                    }
                }
            }
            case .up:
            print("Up")
            for i in stride(from: 0, through: 2, by: 1){
            for j in stride(from: 0, through: 3, by: 1){
                for k in stride(from: i+1, through: 3, by: 1){
                        if( arr2D[k][j] != 0){
                            if(arr2D[i][j]==0){
                                arr2D[i][j]=arr2D[k][j]
                                arr2D[k][j]=0
                            }
                            else if(arr2D[i][j]==arr2D[k][j]){
                                arr2D[i][j]=2*arr2D[i][j]
                                arr2D[k][j]=0
                                
                            }
                        }
                    
                    }
                }
            }
        default:
            print("Break")
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
                let alertController = UIAlertController(title: "GAME OVER", message: "Press New Game", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
            else{
                print(arr2D)
                updateBoard()
            }
        }
        else{
            if(testString != "New Game"){
                print(arr2D)
                updateBoard()
                randomPos()
            }
            else{
                newGame()
            }
        }
    }
    
    
    //Updates board based on swipe move
    func updateBoard() {
        scoreKeeper = 0
        for i in 0...3 {
            for j in 0...3{
                   changeColor(i: arr2D[j][i], lab: setPosition(x: i, y: j))
            }
        }
        print(String(scoreKeeper))
        Score.text = String(scoreKeeper)
    }
    //Changes color of label depending on current value
    func changeColor(i: Int, lab: UILabel) {
        lab.text=String(i)
        lab.adjustsFontSizeToFitWidth=true
        
        switch i {
        case 2:
            lab.textColor = UIColor.black
            lab.backgroundColor = UIColor(red:CGFloat(200)/255, green: CGFloat(200)/255, blue: CGFloat(200)/255, alpha: 1)
        case 4:
            lab.textColor = UIColor.black
            lab.backgroundColor = UIColor(red:CGFloat(240)/255, green: CGFloat(26)/255, blue: CGFloat(64)/255, alpha: 1)
            scoreKeeper += 4*1
        case 8:
           lab.textColor = UIColor.black
            lab.backgroundColor = UIColor(red:CGFloat(253)/255, green: CGFloat(176)/255, blue: CGFloat(64)/255, alpha: 1)
            scoreKeeper += 8*2
        case 16:
            lab.textColor = UIColor.black
            lab.backgroundColor = UIColor(red:CGFloat(61)/255, green: CGFloat(220)/255, blue: CGFloat(158)/255, alpha: 1)
            scoreKeeper += 16*3
        case 32:
            lab.textColor = UIColor.black
            lab.backgroundColor = UIColor(red:CGFloat(178)/255, green: CGFloat(125)/255, blue: CGFloat(140)/255, alpha: 1)
            scoreKeeper += 32*4
        case 64:
           lab.textColor = UIColor.black
            lab.backgroundColor = UIColor(red:CGFloat(87)/255, green: CGFloat(156)/255, blue: CGFloat(65)/255, alpha: 1)
            scoreKeeper += 64*5
        case 128:
            lab.textColor = UIColor.black
            lab.backgroundColor = UIColor(red:CGFloat(50)/255, green: CGFloat(144)/255, blue: CGFloat(223)/255, alpha: 1)
            scoreKeeper += 128*6
        case 256:
            lab.textColor = UIColor.black
            lab.backgroundColor = UIColor(red:CGFloat(150)/255, green: CGFloat(144)/255, blue: CGFloat(223)/255, alpha: 1)
            scoreKeeper += 256*7
        case 512:
            lab.textColor = UIColor.black
            lab.backgroundColor = UIColor(red:CGFloat(50)/255, green: CGFloat(14)/255, blue: CGFloat(223)/255, alpha: 1)
            scoreKeeper += 512*8
        case 1024:
            lab.textColor = UIColor.black
            lab.backgroundColor = UIColor(red:CGFloat(110)/255, green: CGFloat(111)/255, blue: CGFloat(93)/255, alpha: 1)
            scoreKeeper += 1024*9
        case 2048:
            lab.textColor = UIColor.black
            lab.backgroundColor = UIColor(red:CGFloat(50)/255, green: CGFloat(61)/255, blue: CGFloat(23)/255, alpha: 1)
            scoreKeeper += 2048*10
        default:
            lab.textColor = UIColor(red:CGFloat(220)/255, green: CGFloat(215)/255, blue: CGFloat(184)/255, alpha: 1)
            lab.backgroundColor = UIColor(red:CGFloat(220)/255, green: CGFloat(215)/255, blue: CGFloat(184)/255, alpha: 1)
            lab.layer.masksToBounds = true
            lab.layer.cornerRadius = 4
        }
        
    }
    //Inputs array position and returns UILabel equivalent
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
extension String
{
    func substringToFirstChar(of char: Character) -> String
    {
        guard let pos = self.range(of: String(char))?.lowerBound else { return self }
        // or  guard let pos = self.index(of: char) else { return self }
        let subString = self[..<pos]
        return String(subString)
    }
}
//func pressureGesture(str: String){
//       let testString = str
//       let tempArr = arr2D
//           switch testString{
//           case "Swipe Right":
//               print("Right")
//               for i in 2...0{
//                   for j in 0...3{
//                       if(arr2D[j][i+1]==0){
//                           arr2D[j][i+1]=arr2D[j][i]
//                           arr2D[j][i]=0
//                       }
//                       else if(arr2D[j][i+1]==arr2D[j][i]){
//                           arr2D[j][i+1]=2*arr2D[j][i]
//                           arr2D[j][i]=0
//                       }
//                   }
//               }
//           case "Swipe Left":
//               print("Left")
//               for i in stride(from: 3, through: 1, by: -1){
//                   for j in stride(from: 3, through: 0, by: -1){
//                       if(arr2D[j][i-1]==0){
//                           arr2D[j][i-1]=arr2D[j][i]
//                           arr2D[j][i]=0
//                       }
//                       else if(arr2D[j][i-1]==arr2D[j][i]){
//                           arr2D[j][i-1]=2*arr2D[j][i-1]
//                           arr2D[j][i]=0
//                       }
//                   }
//               }
//           case "Swipe Down":
//               print("Down")
//               for i in 0...3{
//                   for j in 2...0{
//                       if(arr2D[j+1][i]==0){
//                           arr2D[j+1][i]=arr2D[j][i]
//                           arr2D[j][i]=0
//                       }
//                       else if(arr2D[j+1][i]==arr2D[j][i]){
//                           arr2D[j+1][i]=2*arr2D[j][i]
//                           arr2D[j][i]=0
//                       }
//                   }
//               }
//           case "Swipe Up":
//               print("Up")
//               for i in stride(from: 3, through: 0, by: -1){
//                   for j in stride(from: 3, through: 1, by: -1){
//                       if(arr2D[j-1][i]==0){
//                           arr2D[j-1][i]=arr2D[j][i]
//                           arr2D[j][i]=0
//                       }
//                       else if(arr2D[j-1][i]==arr2D[j][i]){
//                           arr2D[j-1][i]=2*arr2D[j][i]
//                           arr2D[j][i]=0
//                       }
//                   }
//               }
//           case "New Game":
//               newGame()
//           default:
//               print("Break")
//               break
//           }
//       if(tempArr == arr2D){
//       var gameOver = true
//       for i in 0...3{
//           for j in 0...3{
//               if(arr2D[j][i] == 0){
//                   gameOver=false
//               }
//           }
//       }
//       if(gameOver){
//           print("GAME OVER, Press New Game")
//           let alertController = UIAlertController(title: "GAME OVER", message: "Press New Game", preferredStyle: .alert)
//           alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//           self.present(alertController, animated: true, completion: nil)
//       }
//       else{
//           print(arr2D)
//           updateBoard()
//           }
//       }
//       else{
//           if(testString != "New Game"){
//               print(arr2D)
//               updateBoard()
//               randomPos()
//           }
//       }
//       }
//func modifyString(str: String) -> String {
//    let mySubstring: String
//    if str.count>2 {
//        let index = str.index(str.startIndex, offsetBy: str.count-1)
//        mySubstring = String(str.prefix(upTo: index))
//        print(mySubstring)
//    }
//    else{
//        print("Too Small")
//        mySubstring = "No Swipe"
//    }
//    return mySubstring
//}
