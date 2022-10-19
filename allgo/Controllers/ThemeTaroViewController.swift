//
//  ThemeTaroViewController.swift
//  allgo
//
//  Created by 한호철 on 2022/07/18.
//

import UIKit
import Alamofire
import SwiftyJSON

class ThemeTaroViewController: UIViewController {

    @IBOutlet var moneyUnderLine: UIImageView!
    @IBOutlet var loveUnderLine: UIImageView!
    @IBOutlet var businessUnderLine: UIImageView!
    @IBOutlet var closeImg: UIImageView!
    
    @IBOutlet var moneyTabLbl: UILabel!
    @IBOutlet var loveTabLbl: UILabel!
    @IBOutlet var businessTabLbl: UILabel!
    
    @IBOutlet var lock1Img: UIImageView!
    @IBOutlet var lock2Img: UIImageView!
    @IBOutlet var lock3Img: UIImageView!
    @IBOutlet var lock4Img: UIImageView!
    
    @IBOutlet var card1Img: UIImageView!
    @IBOutlet var card2Img: UIImageView!
    @IBOutlet var card3Img: UIImageView!
    @IBOutlet var card4Img: UIImageView!
    
    var totalTabNum: Int = 3
    var curTabNum: Int = 0
    var selectedTab: String = Constants.MONEY
    var selectedTabName: String = Constants.MONEY_NAME
    
    var clickedCardNum: Int = 0
    var isCardClicked: Bool = false
    
    var conId: String = ""
    var cardNum: Int = 0
    var cardName: String = ""
    var cardAngle: String = ""
    var cardStar: String = ""
    var cardMean: String = ""
    var cardContent: String = ""
    var cardContentMean: String = ""
    var moneyContent: String = ""
    var loveContent: String = ""
    var businessContent: String = ""
    
    var underLines = Array<UIImageView>()
    var locks = Array<UIImageView>()
    var cards = Array<UIImageView>()
    
    var userInfo: UserInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setInit()
    }
    
    func setInit(){
        
        userInfo = UserInfo.shared
        
        underLines = [
                        moneyUnderLine,
                        loveUnderLine,
                        businessUnderLine
                    ]
        
        locks = [
                    lock1Img,
                    lock2Img,
                    lock3Img,
                    lock4Img
                ]
        
        cards = [
                    card1Img,
                    card2Img,
                    card3Img,
                    card4Img
                ]
        
        Util.setAllUnderLinesHidden(underLines: underLines)
        underLines[0].isHidden = false
        
        Util.setAllUnderLinesHidden(underLines: locks)
        
        let closeImgTab = UITapGestureRecognizer(target: self, action: #selector(closeImgClicked))
        closeImg.isUserInteractionEnabled = true
        closeImg.addGestureRecognizer(closeImgTab)
        
        let moneyTab = AllgoTapGestureRecognizer(target: self, action: #selector(tabClicked(sender:)))
        moneyTabLbl.isUserInteractionEnabled = true
        moneyTab.tapGB = 0
        moneyTabLbl.addGestureRecognizer(moneyTab)
        
        let loveTab = AllgoTapGestureRecognizer(target: self, action: #selector(tabClicked(sender:)))
        loveTabLbl.isUserInteractionEnabled = true
        loveTab.tapGB = 1
        loveTabLbl.addGestureRecognizer(loveTab)
        
        let businessTab = AllgoTapGestureRecognizer(target: self, action: #selector(tabClicked(sender:)))
        businessTabLbl.isUserInteractionEnabled = true
        businessTab.tapGB = 2
        businessTabLbl.addGestureRecognizer(businessTab)
        
        let card1Tab = AllgoTapGestureRecognizer(target: self, action: #selector(cardClicked(sender:)))
        card1Img.isUserInteractionEnabled = true
        card1Tab.cardGB = 0
        card1Img.addGestureRecognizer(card1Tab)
        
        let card2Tab = AllgoTapGestureRecognizer(target: self, action: #selector(cardClicked(sender:)))
        card2Img.isUserInteractionEnabled = true
        card2Tab.cardGB = 1
        card2Img.addGestureRecognizer(card2Tab)
        
        let card3Tab = AllgoTapGestureRecognizer(target: self, action: #selector(cardClicked(sender:)))
        card3Img.isUserInteractionEnabled = true
        card3Tab.cardGB = 2
        card3Img.addGestureRecognizer(card3Tab)
        
        let card4Tab = AllgoTapGestureRecognizer(target: self, action: #selector(cardClicked(sender:)))
        card4Img.isUserInteractionEnabled = true
        card4Tab.cardGB = 3
        card4Img.addGestureRecognizer(card4Tab)
        
        
    }
    
    @objc func closeImgClicked(){
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func tabClicked(sender: AllgoTapGestureRecognizer){
        
        if curTabNum == sender.tapGB{
            return
        }
        
        curTabNum = sender.tapGB
        Util.setAllUnderLinesHidden(underLines: underLines)
        underLines[curTabNum].isHidden = false
        
        if isCardClicked == true{
            
            Util.setAllUnderLinesHidden(underLines: locks)
            var i = 0
            while i < cards.count{
                cards[i].image = UIImage(named: Constants.CARD_BACK)
                i += 1
            }
            isCardClicked = false
            
        }
        

        if curTabNum == 0{
            
            selectedTab = Constants.MONEY
            selectedTabName = Constants.MONEY_NAME
            
            
        }else if curTabNum == 1{
            
            selectedTab = Constants.LOVE
            selectedTabName = Constants.LOVE_NAME
            
        }else if curTabNum == 2{
            
            selectedTab = Constants.BUSINESS
            selectedTabName = Constants.BUSINESS_NAME
            
        }
        
    }
    
    @objc func cardClicked(sender: AllgoTapGestureRecognizer){
        
        if isCardClicked == false{
            clickedCardNum = sender.cardGB
                
            var i:Int = 0
            while i < locks.count{
                    
                if clickedCardNum == i{
                    i += 1
                    continue
                }else{
                    locks[i].isHidden = false
                }
                i += 1
    //            print("i : \(i)")
            }
            getTodayTaro()
            
        }else if clickedCardNum == sender.cardGB{
            print("go detail page~!!")
            
            let storyboard = UIStoryboard.init(name: "ThemeTaroDetail", bundle: nil)
            guard let themeTaroDetailVC = storyboard.instantiateViewController(identifier: "themeTaroDetail") as? ThemeTaroDetailViewController else{ return }
            themeTaroDetailVC.modalTransitionStyle = .coverVertical
            themeTaroDetailVC.modalPresentationStyle = .fullScreen
            themeTaroDetailVC.conId = conId
            themeTaroDetailVC.cardNum = cardNum
            themeTaroDetailVC.selectedTab = selectedTab
            themeTaroDetailVC.selectedTabName = selectedTabName
            themeTaroDetailVC.cardName = cardName
            themeTaroDetailVC.cardAngle = cardAngle
            themeTaroDetailVC.cardStar = cardStar
            themeTaroDetailVC.cardMean = cardMean
            themeTaroDetailVC.cardContent = cardContent
            themeTaroDetailVC.cardContentMean = cardContentMean
            
            if selectedTab == Constants.MONEY_NAME{
                themeTaroDetailVC.selectedContent = moneyContent
            }else if selectedTab == Constants.LOVE{
                themeTaroDetailVC.selectedContent = loveContent
            }else if selectedTab == Constants.BUSINESS{
                themeTaroDetailVC.selectedContent = businessContent
            }
            
            self.present(themeTaroDetailVC,animated: true,completion: nil)
            
            
        }
        
        
    }
    
    func getTodayTaro(){
        
        print("getTodayTaro() called~!")
        print("language : \(Util.getLanguage())")
        let taroParam : [String : String] = [
        
            "tarot_type" : "",
            "language_code" : Util.getLanguage()
            
        ]
        
        let url = Constants.urlPrefix + "/taro/"
        
        AF.request(url,
                   method: .post,
                   parameters: taroParam,
                   encoding: JSONEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
//                    .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                //여기서 가져온 데이터를 자유롭게 활용하세요.
                print("kkkkkkkkkkk : \(response)")

                switch response.result{

                case .success(let value):
                    let json = JSON(value)
                    print(json["error_number"].stringValue)
                    let errorNumber = json["error_number"].stringValue

                    if errorNumber == Constants.SEARCH_OK{
                        
                        self.isCardClicked = true
                        
                        self.conId = json["taro"]["id"].stringValue
                        print("conId : \(self.conId)")
                        self.cardNum = Int(Util.substringWithRange(target: self.conId, start: 0, range: 2)) ?? 0
                        self.cards[self.clickedCardNum].image = UIImage(named: Constants.CARD[self.cardNum])
                        
                        self.cardName = json["taro"]["name"].stringValue
                        self.cardAngle = json["taro"]["angle"].stringValue
//                        print("angle : \(self.cardAngle)")
                        if self.cardAngle == Constants.REVERSE{
                            self.cards[self.clickedCardNum].transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                        }
                        
                        self.cardStar = json["taro"]["star"].stringValue
                        self.cardMean = json["taro"]["mean2"].stringValue
                        self.cardContent = json["taro"]["card"].stringValue
                        self.cardContentMean = json["taro"]["mean"].stringValue
                        
                        self.moneyContent = json["taro"]["money"].stringValue
                        self.loveContent = json["taro"]["love"].stringValue
                        self.businessContent = json["taro"]["business"].stringValue
                        
                    }
                default:
                    return


                }
            }
        
        
    }

}
