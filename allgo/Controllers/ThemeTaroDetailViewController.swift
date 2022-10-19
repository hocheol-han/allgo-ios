//
//  ThemeTaroDetailViewController.swift
//  allgo
//
//  Created by 한호철 on 2022/07/19.
//

import UIKit

class ThemeTaroDetailViewController: UIViewController {
    
    var conId: String = ""
    var cardNum: Int = 0
    var selectedTab: String = ""
    var selectedTabName:String = ""
    var cardName: String = ""
    var cardAngle: String = ""
    var cardStar: String = ""
    var cardMean: String = ""
    var cardContent: String = ""
    var cardContentMean: String = ""
    var selectedContent: String = ""
    
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var closeImg: UIImageView!
    
    @IBOutlet var cardImg: UIImageView!
    @IBOutlet var cardNameLbl: UILabel!
    @IBOutlet var cardAngleLbl: UILabel!
    @IBOutlet var cardStarLbl: UILabel!
    @IBOutlet var cardMeanLbl: UILabel!
    
    @IBOutlet var cardContentLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        setInit()
    }
    
    func setInit(){
        
        var title: String = "재물운 타로카드"
        if selectedTab == "0"{
            title = "재물운 타로카드"
        }else if selectedTab == "1"{
            title = "연애운 타로카드"
        }else if selectedTab == "2"{
            title = "사업운 타로카드"
        }
        
        titleLbl.text = title
        
        let closeImgTab = UITapGestureRecognizer(target: self, action: #selector(closeImgClicked))
        closeImg.isUserInteractionEnabled = true
        closeImg.addGestureRecognizer(closeImgTab)
        
        cardImg.image = UIImage(named: Constants.CARD[self.cardNum])
        cardNameLbl.text = cardName
//        print("cardAngel : \(cardAngle)")
        cardAngleLbl.text = cardAngle
        cardStarLbl.text = cardStar
        cardMeanLbl.text = cardMean
        
        if cardAngle == Constants.REVERSE{
            cardImg.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }
        
        var content:String = cardContent
        cardContentLbl.text = content
        
        
    }
    
    @objc func closeImgClicked(){
        self.dismiss(animated: true, completion: nil)
    }

}
