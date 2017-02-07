//
//  ViewController.swift
//  Swift-Switch
//
//  Created by Meng Fan on 17/2/7.
//  Copyright © 2017年 Meng Fan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //1. create a property of type UISwicth
    var mainSwitch:UISwitch!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //2. create switch
        mainSwitch = UISwitch(frame: CGRect(x: 100, y: 100, width: 0, height: 0))
        view.addSubview(self.mainSwitch)
        
        //缩小或者放大switch的size
        mainSwitch.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        mainSwitch.layer.anchorPoint = CGPoint(x:0, y:0.3)

        
        mainSwitch.onImage = UIImage(named:"on.png")   //无效
        mainSwitch.offImage = UIImage(named:"off.png") //无效
        
//        mainSwitch.backgroundColor = UIColor.yellow     //设置背景颜色之后才发现原来它是矩形的
        
        // 设置开关状态(默认是 关)
//        self.mainSwitch.isOn = true;
        mainSwitch.setOn(true, animated: true) // animated
        
        //判断switch的开关状态
        if mainSwitch.isOn {
            print("switch is on")
        } else {
            print("switch is off")
        }
        
        //添加监听事件
        mainSwitch.addTarget(self, action: #selector(switchAction), for: .valueChanged)
        
        //定制开关颜色UI
        //tintColor 关状态下的背景颜色
        mainSwitch.tintColor = UIColor.red;
        //onTintColor 开状态下的背景颜色
        mainSwitch.onTintColor = UIColor.yellow;
        //thumbTintColor 滑块的背景颜色
        mainSwitch.thumbTintColor = UIColor.blue;
 
    }
    
    func switchAction(sender: UISwitch) {
        print("switch value changed")
        
        if sender.isOn {
            print("switch is on")
        } else {
            print("switch is off")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

