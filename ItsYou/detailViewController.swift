//
//  detailViewController.swift
//  ItsYou
//
//  Created by YenShao on 2017/1/8.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit
import AudioToolbox

class detailViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var detailImage: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var decideImg: UIImageView!
    
    
    
    
    var message = [UIImage]()
    var targetIndex:Int = 0
    var timer:Timer?
    var timeLeft = 10
    var case1 = 0
    var case2 = 0
    var case3 = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        //scrollView.contentSize = (detailImage.image?.size)!
        
        startTimer()
        
        let scaleTransform = CGAffineTransform.init(scaleX: 0, y: 0)
        let translateTransform = CGAffineTransform.init(translationX: 0, y: -1000)
        let combineTransform = scaleTransform.concatenating(translateTransform)
        containerView.transform = combineTransform
        
        let layer = decideImg.layer
        layer.cornerRadius = 40.0
        layer.masksToBounds = true
        
        let layer1 = detailImage.layer
        layer1.cornerRadius = 125.0
        layer1.masksToBounds = true
        
        
        
        switch message.count {
        case 1...3:
            timeLeft = 15
        case 4...6:
            timeLeft = 25
        case 7...10:
            timeLeft = 40
        default:
            timeLeft = 45
        }
        
        case1 = timeLeft - 1
        case2 = timeLeft - 2
        case3 = timeLeft - 3
        
        
    }
    
    
    // Start Timer
    func startTimer()
    {
        let timeInterval = TimeInterval(0.5)
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(toLeft), userInfo: nil, repeats: true)
    }
    
    
    
    // Stop Timer
    func stopTimer()
    {
        if timer != nil
        {
            timer?.invalidate()
            timer = nil
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        stopTimer()
    }
    
    // 圖片向左轉的動畫
    func toLeft() {
        
        timeLeft -= 1
        
        switch timeLeft {
        case 0:
            stopTimer()
            // Timer停止，彈出決定視窗
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: .curveEaseInOut, animations: {
                
                let random = Int(arc4random()) % self.message.count
                self.decideImg.image = self.message[random]
                self.containerView.transform = CGAffineTransform.identity
                AudioServicesPlaySystemSound(1010)
                }, completion: nil)

        case case1, case2:
            let transition = CATransition()
            transition.duration = 0.5
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            
            if(targetIndex>=(message.count))
            {
                targetIndex=0
            }
            
            detailImage.image = message[targetIndex]
            targetIndex += 1
            detailImage.layer.add(transition, forKey: nil)
        case case3:
            stopTimer()
            timer = Timer.scheduledTimer(timeInterval: 0.15, target: self, selector: #selector(toLeft), userInfo: nil, repeats: true)
        default:
            
            let transition = CATransition()
            transition.duration = 0.5
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            
            if(targetIndex>=(message.count))
            {
                targetIndex=0
            }
            
            detailImage.image = message[targetIndex]
            targetIndex += 1
            detailImage.layer.add(transition, forKey: nil)
        }
        
    }
    
    @IBAction func closeBtn(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
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
