//
//  NewsFeeds_Controller.swift
//  QnewZie
//
//  Created by DeEp KapaDia on 10/08/19.
//  Copyright © 2019 DeEp KapaDia. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher
import Reachability

struct System {
    static func clearNavigationBar(forBar navBar: UINavigationBar) {
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
        navBar.isTranslucent = true
    }
}

class NewsFeeds_Controller: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {

    //Modedel variable For Data Fetching
    var ArtData = [Articles_Model]()
    
    var url1 = ""

    var name = ""
    
    @IBOutlet weak var collectiion_View: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.backgroundColor = Theme.current.Mainbackground
        
        if let navController = navigationController {
            System.clearNavigationBar(forBar: navController.navigationBar)
            navController.view.backgroundColor = .clear
            navController.view.tintColor = .clear
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        //Function Calling
        jsonParsing()
        self.navigationItem.title = name
        
        //Swipe to Pop ViewController
        let Swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeact))
        Swipe.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(Swipe)

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.collectiion_View.reloadData()
        
        if let navController = navigationController {
            System.clearNavigationBar(forBar: navController.navigationBar)
            navController.view.backgroundColor = .clear
            navController.view.tintColor = .clear
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        view.backgroundColor = Theme.current.Mainbackground
        
        if let navController = navigationController {
            System.clearNavigationBar(forBar: navController.navigationBar)
            navController.view.backgroundColor = .clear
            navController.view.tintColor = .clear
        }
        
        self.collectiion_View.reloadData()
        
    }
    
    func getHeaderImageHeightForCurrentDevice() -> CGFloat {
        switch UIScreen.main.nativeBounds.height {
        case 2436: // iPhone X
            return 175
        default: // Every other iPhone
            return 145
        }
    }
    
    //Json Parsing Function
    func jsonParsing(){
        let url = URL(string: url1)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { return }
            do{
                let json = try JSON(data:data)
                let results = json["articles"]
                for arr in results.arrayValue{
                    self.ArtData.append(Articles_Model(json: arr))
                    print(self.ArtData)
                }
                DispatchQueue.main.async {
                    self.collectiion_View.reloadData()
                }
            }catch{
                print(error.localizedDescription)
            }
            }.resume()
    }
    
    @objc func swipeact(){
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func handle(){
        
        self.navigationController?.popViewController(animated: true)
        
    }

    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return ArtData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewFeedsCell", for: indexPath) as! NewsFeedsCell
     
        //Cell Display Text Data Code
        cell.FeedsTitle.text = ArtData[indexPath.row].title
        cell.FeedsTitle.textColor = Theme.current.textcolor
        
        cell.FeedsAuthor.text = ArtData[indexPath.row].author
        //Cell Display Image Data Code
        cell.FeedsImg.kf.setImage(with: URL(string: ArtData[indexPath.row].urlToImage))
        
        
        cell.BG.layer.cornerRadius = 15
        cell.BG.backgroundColor = Theme.current.UIViewBG
        //cell Background Shadow Effect Code
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.cornerRadius = 15
        cell.contentView.layer.masksToBounds = true
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width:0,height: 0)
        cell.layer.shadowRadius = 10.0
        cell.layer.shadowOpacity = 0.2
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        
        return cell
    
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //Navigation Code
        let NewsDesc = self.storyboard?.instantiateViewController(withIdentifier: "Show_News") as! News_Desc_Display
        
        
        //Send Data to another vatiable (Another View Controller)
        NewsDesc.ModelData = ArtData[indexPath.row]
        
        self.navigationController?.pushViewController(NewsDesc, animated: false)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5) {
            if let cell = collectionView.cellForItem(at: indexPath) as? NewsFeedsCell {
                cell.contentView.transform = .init(scaleX: 0.95, y: 0.95)
                cell.contentView.backgroundColor = .clear
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5) {
            if let cell = collectionView.cellForItem(at: indexPath) as? NewsFeedsCell {
                cell.contentView.transform = .identity
                cell.contentView.backgroundColor = .clear
            }
        }
    }
    
    
    
}

