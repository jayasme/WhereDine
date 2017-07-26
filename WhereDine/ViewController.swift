//
//  ViewController.swift
//  WhereDine
//
//  Created by Scott Rong on 2017/7/26.
//  Copyright © 2017年 jayasme. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var btnRoll: UIButton!
    @IBOutlet weak var leftArrow: UIButton!
    @IBOutlet weak var rightArrow: UIButton!
    @IBOutlet weak var upArrow: UIButton!
    @IBOutlet weak var downArrow: UIButton!
    
    private var arrows: [UIButton]!
    
    private var timer: Timer? = nil
    private var index: Int = 0
    private var stack: Int = 0
    private var step: Int = 0
    
    private var leftEnabled: Bool = true
    private var rightEnabled: Bool = true
    private var upEnabled: Bool = true
    private var downEnabled: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapLeft(_ sender: Any) {
        guard timer == nil else {
            return
        }
        
        leftEnabled = !leftEnabled
        leftArrow.alpha = leftEnabled ? 1 : 0.3
    }
    
    @IBAction func didTapUp(_ sender: Any) {
        guard timer == nil else {
            return
        }
        
        upEnabled = !upEnabled
        upArrow.alpha = upEnabled ? 1 : 0.3
    }
    
    @IBAction func didTapRight(_ sender: Any) {
        guard timer == nil else {
            return
        }
        
        rightEnabled = !rightEnabled
        rightArrow.alpha = rightEnabled ? 1 : 0.3
    }
    
    @IBAction func didTapDown(_ sender: Any) {
        guard timer == nil else {
            return
        }
        
        downEnabled = !downEnabled
        downArrow.alpha = downEnabled ? 1 : 0.3
    }
    
    
    
    
    @IBAction func btnRollTapped(_ sender: Any) {
        guard timer == nil else {
            return
        }
        
        arrows = []
        if (upEnabled) {
            arrows.append(upArrow)
        }
        if (rightEnabled) {
            arrows.append(rightArrow)
        }
        if (downEnabled) {
            arrows.append(downArrow)
        }
        if (leftEnabled) {
            arrows.append(leftArrow)
        }
        
        guard (arrows.count >= 2) else {
            let alert = UIAlertController(title: "选项太少", message: "至少选择两个方向", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            alert.addAction(UIAlertAction(title: "确定", style: .cancel, handler: nil))
            return
        }
        
        leftArrow.isSelected = false
        upArrow.isSelected = false
        rightArrow.isSelected = false
        downArrow.isSelected = false
        
        index = 0
        step = Int(arc4random()) % (25 * arrows.count) + 100
        stack = 0
        timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(poll), userInfo: nil, repeats: true)
    }
    
    @objc private func poll() {
        for i in 0..<arrows.count {
            arrows[i].isSelected = (i == index)
        }
        stack += step
        if (stack >= 100) {
            if (index < arrows.count - 1) {
                index += 1
            } else {
                index = 0
            }
            stack -= 100
            step -= 2
        }
        
        if (step <= 5) {
            stopPolling()
        }
    }
    
    private func stopPolling() {
        timer?.invalidate()
        timer = nil
    }
}

