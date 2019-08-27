//
//  ViewController.swift
//  QnewZie
//
//  Created by DeEp KapaDia on 10/08/19.
//  Copyright © 2019 DeEp KapaDia. All rights reserved.
//

import UIKit
import Reachability
//Structure For data model for Search Bar
struct DataModel{
    
    var name:String = ""
    var Img:UIImage
    
}

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var collectionViewOl: UICollectionView!
    var urlval = Api()
    
    var arrData = [DataModel]()
    
    let reachability = Reachability()!

    let theme = Theme()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        self.collectionViewOl.reloadData()
        
        if let navController = navigationController {
            System.clearNavigationBar(forBar: navController.navigationBar)
            navController.view.backgroundColor = .clear
            navController.view.tintColor = .clear
        }
        
        DataModelSetup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        view.backgroundColor = Theme.current.Mainbackground
        
        if let navController = navigationController {
            System.clearNavigationBar(forBar: navController.navigationBar)
            navController.view.backgroundColor = .clear
            navController.view.tintColor = .clear
        }
        
        self.collectionViewOl.reloadData()
    }
    //Collection View Data Display Array
    
    private func DataModelSetup(){
        
        arrData =  [
            DataModel(name: "ABC News", Img: #imageLiteral(resourceName: "ABC News")),
            DataModel(name: "Associated Press", Img: #imageLiteral(resourceName: "Associated Press")),
            DataModel(name: "Australian Financial Review", Img: #imageLiteral(resourceName: "Australian Financial Review")),
            DataModel(name: "Blasting News", Img: #imageLiteral(resourceName: "Blasting News")),
            DataModel(name: "Business Insider", Img: #imageLiteral(resourceName: "Business Insider")),
            DataModel(name: "Buzzfeed", Img: #imageLiteral(resourceName: "Buzzfeed")),
            DataModel(name: "CBC News", Img: #imageLiteral(resourceName: "CBC News")),
            DataModel(name: "CNBC News", Img: #imageLiteral(resourceName: "CNBC News")),
            DataModel(name: "CNN News", Img: #imageLiteral(resourceName: "CNN News")),
            DataModel(name: "Daily Mail", Img: #imageLiteral(resourceName: "Dail Mail")),
            DataModel(name: "ESPN Sports", Img: #imageLiteral(resourceName: "ESPN Sports")),
            DataModel(name: "ESPN", Img: #imageLiteral(resourceName: "ESPN")),
            DataModel(name: "Fox News", Img: #imageLiteral(resourceName: "Fox News")),
            DataModel(name: "Fox Sports", Img: #imageLiteral(resourceName: "Fox Sports")),
            DataModel(name: "Google News", Img: #imageLiteral(resourceName: "Google News")),
            DataModel(name: "Hackers News", Img: #imageLiteral(resourceName: "Hackers News")),
            DataModel(name: "MTV News", Img: #imageLiteral(resourceName: "MTV News")),
            DataModel(name: "National Geographic", Img: #imageLiteral(resourceName: "National Geographic")),
            DataModel(name: "NBC News", Img: #imageLiteral(resourceName: "NBC News")),
            DataModel(name: "News24", Img: #imageLiteral(resourceName: "News24")),
            DataModel(name: "NFL News", Img: #imageLiteral(resourceName: "NFL News")),
            DataModel(name: "Times Of India News", Img: #imageLiteral(resourceName: "Times Of India News"))
            
            
        ]
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //Cell Code
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsChanelLogoCell", for: indexPath) as! NewsChenelLogoCell
        
        //Display Contents on Cell Code
        cell.Chanel_Name_Lbl.text = self.arrData[indexPath.item].name
        
        cell.Chenel_Logo_Img.image = self.arrData[indexPath.item].Img
        
        //Cell Shadow Code
        cell.layer.shadowColor = UIColor.darkGray.cgColor
        
        cell.layer.shadowRadius = 3
        cell.layer.shadowOffset = CGSize(width: 0 , height: 0)
        cell.layer.shouldRasterize = true
        
        //Cell Image CornerRadius Code
        cell.Chenel_Logo_Img.layer.cornerRadius = 10
        cell.ViewBG.layer.cornerRadius = 10
        
        //Theme changing things settings.
        cell.Chanel_Name_Lbl.textColor = Theme.current.textcolor
        cell.ViewBG.backgroundColor = Theme.current.UIViewBG
        
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.masksToBounds = true
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width:0,height: 0)
        cell.layer.shadowRadius = 10.0
        cell.layer.shadowOpacity = 0.2
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        
        return cell
    }
   
    //Cell Did Select Code
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //array name Count
        let val = self.arrData[indexPath.item].name
        
        //Navigation to perticular Api Access code
        let nxt = self.storyboard?.instantiateViewController(withIdentifier: "NewsFeeds") as! NewsFeeds_Controller
        
        if val == "ABC News"{
            nxt.url1 = urlval.ABC_News
            nxt.name = arrData[indexPath.row].name
        }
        else if val == "Associated Press"{
            nxt.url1 = urlval.Associated_Press
            nxt.name = arrData[indexPath.row].name
        }
        else if val == "Australian Financial Review"{
            nxt.url1 = urlval.Australian_Financial_Review
            nxt.name = arrData[indexPath.row].name
        }
        else if val == "Blasting News"{
            nxt.url1 = urlval.Blasting_News
            nxt.name = arrData[indexPath.row].name
        }
        else if val == "Business Insider"{
            nxt.url1 = urlval.Business_Insider
            nxt.name = arrData[indexPath.row].name
        }
        else if val == "Buzzfeed"{
            nxt.url1 = urlval.Buzzfeed
            nxt.name = arrData[indexPath.row].name
        }
        else if val == "CBC News"{
            nxt.url1 = urlval.CBC_News
            nxt.name = arrData[indexPath.row].name
        }
        else if val == "CNBC News"{
            nxt.url1 = urlval.CNBC_News
            nxt.name = arrData[indexPath.row].name
        }
        else if val == "CNN News"{
            nxt.url1 = urlval.CNN_News
            nxt.name = arrData[indexPath.row].name
        }
        else if val == "Daily Mail"{
            nxt.url1 = urlval.Daily_Mail
            nxt.name = arrData[indexPath.row].name
        }
        else if val == "ESPN Sports"{
            nxt.url1 = urlval.ESPN_Sports
            nxt.name = arrData[indexPath.row].name
        }
        else if val == "ESPN"{
            nxt.url1 = urlval.ESPN
            nxt.name = arrData[indexPath.row].name
        }
        else if val == "Fox News"{
            nxt.url1 = urlval.Fox_News
            nxt.name = arrData[indexPath.row].name
        }
        else if val == "Fox Sports"{
            nxt.url1 = urlval.Fox_Sports
            nxt.name = arrData[indexPath.row].name
        }
        else if val == "Google News"{
            nxt.url1 = urlval.GoogleNews
            nxt.name = arrData[indexPath.row].name
        }
        else if val == "Hackers News"{
            nxt.url1 = urlval.Hackers_News
            nxt.name = arrData[indexPath.row].name
        }
        else if val == "MTV News"{
            nxt.url1 = urlval.MTV_News
            nxt.name = arrData[indexPath.row].name
        }
        else if val == "National Geographic"{
            nxt.url1 = urlval.National_Geographic
            nxt.name = arrData[indexPath.row].name
        }
        else if val == "NBC News"{
            nxt.url1 = urlval.NBC_News
            nxt.name = arrData[indexPath.row].name
        }
        else if val == "News24"{
            nxt.url1 = urlval.News24
            nxt.name = arrData[indexPath.row].name
        }
        else if val == "NFL News"{
            nxt.url1 = urlval.NFL_News
            nxt.name = arrData[indexPath.row].name
        }
        else if val == "Times Of India News"{
            nxt.url1 = urlval.Times_Of_India_News
            nxt.name = arrData[indexPath.row].name
        }
        
        self.navigationController?.pushViewController(nxt, animated: true)
        
    }
    //--------------------------- Collection View Code End -----------------------------

    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5) {
            if let cell = collectionView.cellForItem(at: indexPath) as? NewsChenelLogoCell {
                cell.contentView.transform = .init(scaleX: 0.95, y: 0.95)
                cell.contentView.backgroundColor = .clear
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5) {
            if let cell = collectionView.cellForItem(at: indexPath) as? NewsChenelLogoCell {
                cell.contentView.transform = .identity
                cell.contentView.backgroundColor = .clear
            }
        }
    }
    
}

