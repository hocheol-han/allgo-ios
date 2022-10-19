//
//  GunghapViewController.swift
//  allgo
//
//  Created by 한호철 on 2022/07/12.
//

import UIKit
import Alamofire
import SwiftyJSON

class GunghapViewController: UIViewController {

    @IBOutlet var closeImg: UIImageView!
    @IBOutlet var jungtongUnderLine: UIImageView!
    @IBOutlet var bloodUnderLine: UIImageView!
    @IBOutlet var starUnderLine: UIImageView!
    
    @IBOutlet var jungtongTabLbl: UILabel!
    @IBOutlet var bloodTabLbl: UILabel!
    @IBOutlet var starTabLbl: UILabel!
    
    @IBOutlet var keywordBarImg: UIImageView!
//    @IBOutlet var keywordContentLbl: UILabel!
    @IBOutlet var keywordLbl: UILabel!
    @IBOutlet var keywordContentLbl: UILabel!
    @IBOutlet var contentLbl: UILabel!
    
    var gungHapKeyword: String = ""
    var gungHapContent: String = ""
    var gungHapConId: String = ""
    
    var bloodKeyword: String = ""
    var bloodContent: String = ""
    var bloodConId: String = ""
    
    var starKeyword: String = ""
    var starContent: String = ""
    var starConId: String = ""
    
    var totalTabNum: Int = 3
    var curTabNum: Int = 0
    var underLines = Array<UIImageView>()
    
    var userInfo: UserInfo!
    
    //새로운 사주 입력으로 부터
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setInit()
    }

    func setInit(){
        
        userInfo = UserInfo.shared
        
        underLines = [
                        jungtongUnderLine,
                        bloodUnderLine,
                        starUnderLine
                        ]
        Util.setAllUnderLinesHidden(underLines: underLines)
        underLines[0].isHidden = false
        
        let closeImgTab = UITapGestureRecognizer(target: self, action: #selector(closeImgClicked))
        closeImg.isUserInteractionEnabled = true
        closeImg.addGestureRecognizer(closeImgTab)
        
        keywordLbl.backgroundColor = Constants.BUTTON_GREEN
        keywordLbl.clipsToBounds = true
        keywordLbl.layer.cornerRadius = 10
        keywordLbl.textColor = Constants.WHITE
        
        keywordBarImg.backgroundColor = Constants.BUTTON_GREEN
        
        let jungtongTab = GunghapTapGestureRecognizer(target: self, action: #selector(tabClicked(sender:)))
        jungtongTabLbl.isUserInteractionEnabled = true
        jungtongTab.tapGB = 0
        jungtongTabLbl.addGestureRecognizer(jungtongTab)
        
        let bloodTab = GunghapTapGestureRecognizer(target: self, action: #selector(tabClicked))
        bloodTabLbl.isUserInteractionEnabled = true
        bloodTab.tapGB = 1
        bloodTabLbl.addGestureRecognizer(bloodTab)

        let starTab = GunghapTapGestureRecognizer(target: self, action: #selector(tabClicked))
        starTabLbl.isUserInteractionEnabled = true
        starTab.tapGB = 2
        starTabLbl.addGestureRecognizer(starTab)
        
        
        let gunghapParam : [String: String] = [
            
            "birth_year" : userInfo.memberBirthYear ?? "",
            "birth_month" : userInfo.memberBirthMonth ?? "",
            "birth_day" : userInfo.memberBirthDay ?? "",
            "birth_type" : userInfo.memberBirthTypeGb ?? "",
            "my_sex" : userInfo.memberSexGb ?? "",
            "user_birth_year" : friend_birth_year,
            "user_birth_month" : friend_birth_month,
            "user_birth_day" : friend_birth_day,
            "user_birth_type" : friend_birth_gb,
            "language_code" : Util.getLanguage()
            
        ]
        
        getGunghap(param: gunghapParam)
        
        let bloodGunghapParam : [String : String] = [
            
            "my_blood" : userInfo.memberBlood ?? "",
            "my_sex" : userInfo.memberSexGb ?? "",
            "user_blood" : friend_blood_type,
            "language_code" : Util.getLanguage()
        
        ]
        
        getBloodGunghap(param: bloodGunghapParam)
        
        let starGunghapParam : [String : String] = [
        
            "birth_year" : userInfo.memberBirthYear ?? "",
            "birth_month" : userInfo.memberBirthMonth ?? "",
            "birth_day" : userInfo.memberBirthDay ?? "",
            "birth_type" : userInfo.memberBirthTypeGb ?? "",
            "my_sex" : userInfo.memberSexGb ?? "",
            "user_birth_year" : friend_birth_year,
            "user_birth_month" : friend_birth_month,
            "user_birth_day" : friend_birth_day,
            "user_birth_type" : friend_birth_gb,
            "language_code" : Util.getLanguage()
            
        ]
        
        getStarGunghap(param: starGunghapParam)
        
    }
    
    func getGunghap(param: Dictionary<String,String>){
        
        let url = Constants.urlPrefix + "/gunghap/getGunghap"
        
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
                        let gunghap = json["gunghap"].arrayValue[0]
                        
                        self.gungHapKeyword =  gunghap["keyword"].stringValue
                        self.keywordContentLbl.text = self.gungHapKeyword
                        self.gungHapContent = (gunghap["title"].stringValue + "(" + gunghap["contents"].stringValue + ")\n\n" + gunghap["contents1"].stringValue + "\n\n" +
                        gunghap["contents2"].stringValue + "(" + gunghap["contents3"].stringValue + ")\n\n" + gunghap["contents4"].stringValue)
                        
                        self.contentLbl.text = self.gungHapContent
                        
                        self.gungHapConId = gunghap["id"].stringValue
                        
                    }
                default:
                    return


                }
            }
    }
    
    func getBloodGunghap(param : Dictionary<String,String>){
        let url = Constants.urlPrefix + "/gunghap/getBloodGunghap"
        
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
                        let blood = json["bloodGunghap"].arrayValue[0]

                        self.bloodKeyword = blood["keyword"].stringValue
                        self.bloodConId = blood["id"].stringValue
                        self.bloodContent = blood["title"].stringValue + "\n\n" + blood["contents"].stringValue
                        
                    }
                default:
                    return


                }
            }
    }
    
    
    func getStarGunghap(param: Dictionary<String,String>){
        
        let url = Constants.urlPrefix + "/gunghap/getStarGunghap"
        
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
                        
                        let star = json["starGunghap"].arrayValue[0]

                        self.starKeyword = star["keyword"].stringValue
                        self.starConId = star["id"].stringValue
                        self.starContent = star["man"].stringValue + "\n\n" + star["woman"].stringValue
                        
                    }
                default:
                    return


                }
            }
    }
    
    
    @objc func closeImgClicked(){
        
        let storyboard = UIStoryboard.init(name: "SajuInfoSavePop", bundle: nil)
        guard let sajuInfoSavePop = storyboard.instantiateViewController(identifier: "sajuInfoSavePop") as? SajuInfoSavePopViewController else{ return }
        sajuInfoSavePop.modalTransitionStyle = .coverVertical
        sajuInfoSavePop.modalPresentationStyle = .overCurrentContext
        sajuInfoSavePop.from = Constants.JUNGTONG_UNSE_NAME[2]
        
        sajuInfoSavePop.name = friend_name
        self.present(sajuInfoSavePop,animated: true,completion: nil)
//        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func tabClicked(sender: GunghapTapGestureRecognizer){
        
        curTabNum = sender.tapGB
        Util.setAllUnderLinesHidden(underLines: underLines)
        underLines[curTabNum].isHidden = false
        
        if curTabNum == 0{
            
            keywordContentLbl.text = gungHapKeyword
            contentLbl.text = gungHapContent
            
        }else if curTabNum == 1{
            
            keywordContentLbl.text = bloodKeyword
            contentLbl.text = bloodContent
            
        }else if curTabNum == 2{
            
            keywordContentLbl.text = starKeyword
            contentLbl.text = starContent
            
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

class GunghapTapGestureRecognizer: UITapGestureRecognizer{
    var tapGB: Int = 0
}
