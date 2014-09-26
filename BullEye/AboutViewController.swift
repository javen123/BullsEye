//
//  AboutViewController.swift
//  BullEye
//
//  Created by user on 9/22/14.
//  Copyright (c) 2014 Neva. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    
    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let htmlFile = NSBundle.mainBundle().pathForResource("BullsEye", ofType:"html") {
            let htmlData = NSData(contentsOfFile: htmlFile)
            let baseURL = NSURL.fileURLWithPath(NSBundle.mainBundle().bundlePath)
            webView.loadData(htmlData, MIMEType: "text/html",
                textEncodingName:"UTF-8", baseURL:baseURL)
            
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeButton() {
        dismissViewControllerAnimated(true, completion: nil)
    }

    }
