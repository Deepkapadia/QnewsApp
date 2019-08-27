//
//  WebViewController.swift
//  QnewZie
//
//  Created by DeEp KapaDia on 12/08/19.
//  Copyright © 2019 DeEp KapaDia. All rights reserved.
//

import UIKit
import WebKit


class WebViewController: UIViewController{

    var webView: WKWebView!
    
    @IBOutlet weak var webviewElement: WKWebView!
    
    var urldata = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ShowOfficialSite()
        
        // Do any additional setup after loading the view.
    }
    
    func ShowOfficialSite(){
        
        print("Url data : \(urldata)")
        
        let url = URL (string: urldata)
        
        webviewElement.load(URLRequest.init(url:url!))
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
