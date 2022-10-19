//
//  FlowerViewController.swift
//  allgo
//
//  Created by 한호철 on 2022/07/28.
//

import UIKit
import Alamofire
import SwiftyJSON

class FlowerViewController: UIViewController {
    @IBOutlet var closeImg: UIImageView!
    
    @IBOutlet var birthFLbl: UILabel!
    @IBOutlet var flowerLbl: UILabel!
    @IBOutlet var keywordLbl: UILabel!
    @IBOutlet var keywordBarImg: UIImageView!
    @IBOutlet var keywordContentLbl: UILabel!
    @IBOutlet var contentLbl: UILabel!
    
    
    var totalTabNum:Int = 2
    var curTab: Int = 0
    var underLines = Array<UIImageView>()
    @IBOutlet var bUnderLine: UIImageView!
    @IBOutlet var fUnderLine: UIImageView!
    
    var from: String = ""
    var friend_name: String = ""
    var friend_sex_gb: String = ""
    var friend_cd: String = ""
    var friend_birth_gb: String = ""
    var friend_birth_ymd: String = ""
    var friend_birth_year:String = ""
    var friend_birth_month: String = ""
    var friend_birth_day: String = ""
    var friend_birth_time: String = ""
    var friend_blood_type: String = ""
    
    var userInfo: UserInfo!
    
    var conIds: [String] = ["",""]
    var keywords: [String] = ["",""]
    var contents: [String] = ["",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setInit()
    }
    
    func setInit(){
     
        userInfo = UserInfo.shared
        underLines = [
                        bUnderLine,
                        fUnderLine
                        ]
        Util.setAllUnderLinesHidden(underLines: underLines)
        underLines[0].isHidden = false
        
        let closeImgTab = UITapGestureRecognizer(target: self, action: #selector(closeImgClicked))
        closeImg.isUserInteractionEnabled = true
        closeImg.addGestureRecognizer(closeImgTab)
        
        let birthTab = AllgoTapGestureRecognizer(target: self, action: #selector(tabClicked(sender:)))
        birthFLbl.isUserInteractionEnabled = true
        birthTab.tapGB = 0
        birthFLbl.addGestureRecognizer(birthTab)
        
        let flowerTab = AllgoTapGestureRecognizer(target: self, action: #selector(tabClicked(sender:)))
        flowerLbl.isUserInteractionEnabled = true
        flowerTab.tapGB = 1
        flowerLbl.addGestureRecognizer(flowerTab)
        
        keywordLbl.backgroundColor = Constants.BUTTON_GREEN
        keywordLbl.clipsToBounds = true
        keywordLbl.layer.cornerRadius = 10
        keywordLbl.textColor = Constants.WHITE
        
        keywordBarImg.backgroundColor = Constants.BUTTON_GREEN
        
        var param:[String:String] = [String:String]()
        let formatter_year = DateFormatter()
        
        formatter_year.dateFormat   = "yyyy"
        let year    = formatter_year.string(from: Date())
        
        if from == "NEW" || from == "SAVED"{
            
            param = [
                
                "birth_year" : friend_birth_year,
                "birth_month" : friend_birth_month,
                "birth_day" : friend_birth_day,
                "birth_type" : friend_birth_gb,
                "language_code" : Util.getLanguage()
            
            ]
            
            getBirthFlower(param: param)
            getFlower(param: param)
            
        }else{
            
            param = [
                
                "birth_year" : userInfo.memberBirthYear ?? "",
                "birth_month" : userInfo.memberBirthMonth ?? "",
                "birth_day" : userInfo.memberBirthDay ?? "",
                "birth_type" : userInfo.memberBirthTypeGb ?? "",
                "language_code" : Util.getLanguage()
            
            ]
            
            getBirthFlower(param: param)
            getFlower(param: param)
            
        }
        
    }
    
    @objc func closeImgClicked(){
        
        if from == "NEW"{
            let storyboard = UIStoryboard.init(name: "SajuInfoSavePop", bundle: nil)
            guard let sajuInfoSavePop = storyboard.instantiateViewController(identifier: "sajuInfoSavePop") as? SajuInfoSavePopViewController else{ return }
            sajuInfoSavePop.modalTransitionStyle = .coverVertical
            sajuInfoSavePop.modalPresentationStyle = .overCurrentContext
            sajuInfoSavePop.from = Constants.THEME_UNSE_NAME[5]
            
            sajuInfoSavePop.name = friend_name
            self.present(sajuInfoSavePop,animated: true,completion: nil)
        }else{
         
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func tabClicked(sender: AllgoTapGestureRecognizer){
//        print("chongTabClicked")
        
        curTab = sender.tapGB
        Util.setAllUnderLinesHidden(underLines: underLines)
        underLines[curTab].isHidden = false
        
        keywordContentLbl.text = keywords[curTab]
        contentLbl.text = contents[curTab]
        
    }
    
    func getBirthFlower(param: Dictionary<String,String>){
        
        
        let url = Constants.urlPrefix + "/theme/getBirthFlower"
        
        AF.request(url,
                   method: .post,
                   parameters: param,
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
                        
                        let bflower = json["flower"].arrayValue[0]
                        self.conIds[0] = bflower["id"].stringValue
                        let title:String = bflower["title"].stringValue
                        let contents = bflower["contents"].stringValue
                        let contents1 = bflower["contents1"].stringValue
                        let contents2 = bflower["contents2"].stringValue
                        self.keywords[0] = bflower["keyword"].stringValue
                        
                        print("self.conIds[0] : \(self.conIds[0])")
                        print("title : \(title)")
                        print("contents  : \(contents)")
                        print("contents1 : \(contents1)")
                        print("contents2 : \(contents2)")
                        print("self.bkeyword : \(self.keywords[0])")
                        
                        self.contents[0] = title + "\n\n" + contents + "\n" + contents1 + "\n" + contents2
                        
                        self.keywordContentLbl.text = self.keywords[0]
                        self.contentLbl.text = self.contents[0]
                            
                       
                    }
                default:
                    return


                }
            }
    }
    
    
    func getFlower(param: Dictionary<String,String>){
        
        
        let url = Constants.urlPrefix + "/theme/getFlower"
        
        AF.request(url,
                   method: .post,
                   parameters: param,
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
                        
                        let flower = json["flowerJum"].arrayValue[0]
                        self.conIds[1] = flower["id"].stringValue
                        
                        let period:String = flower["period"].stringValue
                        let title:String = flower["title"].stringValue
                        let contents = flower["contents"].stringValue
                        let contents1 = flower["contents1"].stringValue
                        let contents2 = flower["contents2"].stringValue
                        self.keywords[1] = (flower["keyword"].stringValue)
                        
                        print("conIds[1]  : \(self.conIds[1])")
                        print("period : \(period)")
                        print("title : \(title)")
                        print("contents  : \(contents)")
                        print("contents1 : \(contents1)")
                        print("contents2 : \(contents2)")
                        print("self.keywords[1] : \(self.keywords[1])")
                        
                        self.contents[1] = (self.conIds[1] + "\n\n" + period + "\n" + title + "\n\n" + contents + "\n" + contents1 + "\n" + contents2)
                            
                       
                    }
                default:
                    return


                }
            }
    }
    
    func saveFriendInfo(){
        
        let param : [String: String] = [
            "member_id" : userInfo.memberId ?? "",
            "friend_name" : friend_name,
            "friend_sex_gb" : friend_sex_gb,
            "friend_cd" : friend_cd,
            "friend_birth_gb" : friend_birth_gb,
            "friend_birth_ymd" : friend_birth_ymd,
            "friend_birth_time" : friend_birth_time,
            "friend_blood_type" : friend_blood_type,
            "friend_id" : ""
        ]
        
        let url = Constants.urlPrefix + "/friend/insert"
        
        AF.request(url,
                   method: .post,
                   parameters: param,
                   encoding: JSONEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
//                    .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                //여기서 가져온 데이터를 자유롭게 활용하세요.
                print("saveFriendInfo result : \(response.result)")

                switch response.result{

                case .success(let value):
                    let json = JSON(value)
                    print(json["error_number"].stringValue)
                    let errorNumber = json["error_number"].stringValue

                    if errorNumber == Constants.SEARCH_OK{

                        Util.showToast(message: "저장 되었습니다.", controller: self)
                        
                    }
                default:
                    return


                }
            }
        self.dismiss(animated: true, completion: nil)
    }
}
