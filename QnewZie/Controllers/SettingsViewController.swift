//
//  SettingsViewController.swift
//  QnewZie
//
//  Created by DeEp KapaDia on 11/08/19.
//  Copyright © 2019 DeEp KapaDia. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var Sw: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ApplyTheme()
        if let navController = navigationController {
            System.clearNavigationBar(forBar: navController.navigationBar)
            navController.view.backgroundColor = .clear
            navController.view.tintColor = .clear
        }
        
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        
        if (defaults.object(forKey: "lightTheme") != nil) {
            Sw.isOn = defaults.bool(forKey: "lightTheme")
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func ThemeChanged(_ sender: UISwitch) {
        
        if sender.isOn == true {
            label.text = "Dark Mode"
        }else if sender.isOn == false {
            label.text = "Light Mode"
        }
        
        Theme.current = sender.isOn ? LightTheme() : DarkTheme()
        
        UserDefaults.standard.set(sender.isOn, forKey: "lightTheme")
        
        ApplyTheme()
    }
    
    fileprivate func ApplyTheme() {
        view.backgroundColor = Theme.current.Mainbackground
        label.textColor = Theme.current.textcolor
    }
    
    
}
