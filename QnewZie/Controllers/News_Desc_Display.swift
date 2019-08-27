//
//  Show_News_TableView.swift
//  NetGlob_News
//
//  Created by DeEp KapaDia on 24/12/18.
//  Copyright © 2018 DeEp KapaDia. All rights reserved.
//

import UIKit

class News_Desc_Display: UITableViewController {

    
    //Pass Website URL To Next View
    var passurl = ""

    
    @IBOutlet var TableViewOL: UITableView!
    //Connections Outlet
    @IBOutlet weak var News_Image: UIImageView!
    @IBOutlet weak var TitleLBL: UILabel!
    @IBOutlet weak var DescLBL: UILabel!
    @IBOutlet weak var ContentLBL: UILabel!
    @IBOutlet weak var AuthorLBL: UILabel!
    
    //Data Models fatch Previous Controllers Data and Store it.
    var ModelData = Articles_Model()
    
    //Tableview view Header Connections with Variable
    var Headerview : UIView!
    var NewHeaderLayer : CAShapeLayer!

    //Set fix Height and cut(Slanted Effect for cell)
    private let Headerheight : CGFloat = 480
    private let Headercut : CGFloat = 00
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Navigation Controller Hide Code
        self.navigationController?.setNavigationBarHidden(true, animated: true)

        //Display Data from previous View Controller
        TitleLBL.text = ModelData.title
        AuthorLBL.text = ModelData.author
        DescLBL.text = ModelData.description
        News_Image.kf.setImage(with: URL(string: ModelData.urlToImage))
        ContentLBL.text = ModelData.content
        passurl = ModelData.url
        
        view.backgroundColor = Theme.current.Mainbackground
        TitleLBL.textColor = Theme.current.textcolor
        AuthorLBL.textColor = Theme.current.textcolor
        DescLBL.textColor = Theme.current.textcolor
        ContentLBL.textColor = Theme.current.textcolor
        self.TableViewOL.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //Display Data from previous View Controller
        TitleLBL.text = ModelData.title
        AuthorLBL.text = ModelData.author
        DescLBL.text = ModelData.description
        News_Image.kf.setImage(with: URL(string: ModelData.urlToImage))
        ContentLBL.text = ModelData.content
        passurl = ModelData.url
        
        view.backgroundColor = Theme.current.Mainbackground
        TitleLBL.textColor = Theme.current.textcolor
        AuthorLBL.textColor = Theme.current.textcolor
        DescLBL.textColor = Theme.current.textcolor
        ContentLBL.textColor = Theme.current.textcolor
        self.TableViewOL.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        //Hide navigationBar Code
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Disable Selection of Cell
        self.tableView.allowsSelection = false
        
        
        //TableViewCell Extra line Hide Code.
        self.tableView.tableFooterView = UIView()
        
        //Theme chenager
        view.backgroundColor = Theme.current.Mainbackground
        TitleLBL.textColor = Theme.current.textcolor
        AuthorLBL.textColor = Theme.current.textcolor
        DescLBL.textColor = Theme.current.textcolor
        ContentLBL.textColor = Theme.current.textcolor
        
        //Functions Callings
        self.UpdateView()
        
        //Swipe right to Pop VideController
        let Swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeact))
        Swipe.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(Swipe)
        
    }
    
    //Pop View Controller Code in Func
    @objc func swipeact(){
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    //Update View For Sticky Header
    func UpdateView() {
        
        Headerview = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        tableView.rowHeight = UITableView.automaticDimension
        tableView.addSubview(Headerview)

        NewHeaderLayer = CAShapeLayer()
        NewHeaderLayer.fillColor = UIColor.black.cgColor
        Headerview.layer.mask = NewHeaderLayer

        let newheight = Headerheight - Headercut / 2
        tableView.contentInset = UIEdgeInsets(top: newheight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -newheight)

        self.Setupnewview()
    }
    
    //Setup View For Sticky Header
    
    func Setupnewview() {
        let newheight = Headerheight - Headercut / 2
        var getheaderframe = CGRect(x: 0, y: -newheight, width: tableView.bounds.width, height: Headerheight)
        if tableView.contentOffset.y < newheight
        {
            getheaderframe.origin.y = tableView.contentOffset.y
            getheaderframe.size.height = -tableView.contentOffset.y + Headercut / 2
        }

        Headerview.frame = getheaderframe
        let cutdirection = UIBezierPath()
        cutdirection.move(to: CGPoint(x: 0, y: 0))
        cutdirection.addLine(to: CGPoint(x: getheaderframe.width, y: 0))
        cutdirection.addLine(to: CGPoint(x: getheaderframe.width, y: getheaderframe.height))
        cutdirection.addLine(to: CGPoint(x: 0, y: getheaderframe.height - Headercut))
        NewHeaderLayer.path = cutdirection.cgPath
    }
    
    //Movement of Scrolling Code
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.tableView.decelerationRate = UIScrollView.DecelerationRate.fast
    }
    
    //Scroll permissions
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.Setupnewview()
    }
    
    //Autometic set Height for all Cell
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                return UITableView.automaticDimension
        
    }
    
    //Footer Height
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
//Share Button Code
    @IBAction func shareBtn(_ sender: Any) {
        
        let Author = "Author: \(ModelData.author)"
        let Title = "Title: \(ModelData.title)"
        let Description = "Discription \(ModelData.description)"
        let URL:NSURL = NSURL(string: ModelData.url)!
        let Image = UIImage(named: ModelData.urlToImage)
        
        
        let VC = UIActivityViewController(activityItems: [Author,Title,Description,URL,Image as Any], applicationActivities: [])
        
        if let popcontroller = VC.popoverPresentationController{
            
            popcontroller.sourceView = self.view
            popcontroller.sourceRect = self.view.bounds
            
        }
        self.present(VC, animated: true, completion: nil)
        
    }
    
   
    @IBAction func seecontentsMoreBtn(_ sender: UIButton) {
                guard let url = URL(string: ModelData.url) else { return }
                UIApplication.shared.open(url)
    }
    
    @IBAction func BackBTN(_ sender: Any) {
    //POP Navigation
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
}


