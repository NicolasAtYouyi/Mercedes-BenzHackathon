//
//  BGGitViewController.swift
//  BenzGame
//
//  Created by wangyangyang on 16/9/4.
//  Copyright © 2016年 AndyVan. All rights reserved.
//

import UIKit

class BGGitViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bounds = UIScreen.mainScreen().bounds
        view.backgroundColor = UIColor.clearColor()
        
        webView.scalesPageToFit = true
        webView.backgroundColor = UIColor.clearColor()
        webView.userInteractionEnabled = false
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.onBkgTap))
        view.addGestureRecognizer(tap)
        
        if let gif = NSData.init(contentsOfFile: NSBundle.mainBundle().pathForResource("contrast", ofType: "gif")!) {
            webView.loadData(gif, MIMEType: "image/gif", textEncodingName: "", baseURL: NSURL.init(string: "www.baidu.com")!)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func onBkgTap() {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
