//
//  ViewController.swift
//  Demo
//
//  Created by 沈鹏 on 2016/9/29.
//  Copyright © 2016年 沈鹏. All rights reserved.
//

import UIKit
import XXCircularProgressView

class ViewController: UIViewController {

    @IBOutlet weak var progressView: XXCircularProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func changeProgress(sender: UISlider) {
        
        progressView.progress = CGFloat(sender.value);
        
    }
    
    @IBAction func changeIconStyle(sender: UISegmentedControl) {
        
        var style: XXCircularProgressView.XXIconStyle = .Empty;
        
        switch sender.selectedSegmentIndex {
        case 0:
            style = .Empty;
        case 1:
            style = .Play
        case 2:
            style = .Pause
        case 3:
            style = .Stop;
        case 4:
            style = .Download;
        case 5:
            style = .Upload;
        default:
            break;
        }
        
        progressView.iconStyle = style;
        
    }

}
