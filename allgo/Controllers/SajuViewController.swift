//
//  SajuViewController.swift
//  allgo
//
//  Created by 한호철 on 2022/07/08.
//

import UIKit
import Alamofire
import SwiftyJSON

class SajuViewController: UIViewController {

    @IBOutlet var closeImg: UIImageView!
    
    @IBOutlet var chongUnderLine: UIImageView!
    @IBOutlet var choUnderLine: UIImageView!
    @IBOutlet var jungUnderLine: UIImageView!
    @IBOutlet var malUnderLine: UIImageView!
    @IBOutlet var jeonUnderLine: UIImageView!
    
    @IBOutlet var chongView: UIView!
    @IBOutlet var choView: UIView!
    @IBOutlet var jungView: UIView!
    @IBOutlet var malView: UIView!
    @IBOutlet var jeonView: UIView!
    @IBOutlet var keywordLbl: UILabel!
    @IBOutlet var keywordBarImg: UIImageView!
    @IBOutlet var keywordContentLbl: UILabel!
    @IBOutlet var contentsLbl: UILabel!
    
    var totalTabNum:Int = 5
    var curTab: Int = 0
    var underLines = Array<UIImageView>()
    
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
    
    var userInfo: UserInfo!
    
    var stars = Array<String>()
    var keywords = Array<String>()
    var contents = Array<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setInit()
    }

    func setInit(){
        
        userInfo = UserInfo.shared
        
        underLines = [
                        chongUnderLine,
                        choUnderLine,
                        jungUnderLine,
                        malUnderLine,
                        jeonUnderLine
                    ]
        
        setAllUnderLinesHidden()
        underLines[curTab].isHidden = false
        
        let closeImgTab = UITapGestureRecognizer(target: self, action: #selector(closeImgClicked))
        closeImg.isUserInteractionEnabled = true
        closeImg.addGestureRecognizer(closeImgTab)
        
        let chongTab = TapGestureRecognizer(target: self, action: #selector(tabClicked(sender:)))
        chongView.isUserInteractionEnabled = true
        chongTab.tapGB = 0
        chongView.addGestureRecognizer(chongTab)
        
        let choTab = TapGestureRecognizer(target: self, action: #selector(tabClicked))
        choView.isUserInteractionEnabled = true
        choTab.tapGB = 1
        choView.addGestureRecognizer(choTab)

        let jungTab = TapGestureRecognizer(target: self, action: #selector(tabClicked))
        jungView.isUserInteractionEnabled = true
        jungTab.tapGB = 2
        jungView.addGestureRecognizer(jungTab)

        let malTab = TapGestureRecognizer(target: self, action: #selector(tabClicked))
        malView.isUserInteractionEnabled = true
        malTab.tapGB = 3
        malView.addGestureRecognizer(malTab)

        let jeonTab = TapGestureRecognizer(target: self, action: #selector(tabClicked))
        jeonView.isUserInteractionEnabled = true
        jeonTab.tapGB = 4
        jeonView.addGestureRecognizer(jeonTab)
        
        keywordLbl.backgroundColor = Constants.BUTTON_GREEN
        keywordLbl.clipsToBounds = true
        keywordLbl.layer.cornerRadius = 10
        keywordLbl.textColor = Constants.WHITE
        
        keywordBarImg.backgroundColor = Constants.BUTTON_GREEN
        
        var param : [String: String] = [String:String]()
        
        let formatter_year = DateFormatter()
        
        formatter_year.dateFormat   = "yyyy"
        let year    = formatter_year.string(from: Date())

        
        if from == "NEW" || from == "SAVED"{
            print("friend_birth_ymd : \(friend_birth_ymd)")
            param = [
                "birth_year" : friend_birth_year,
                "birth_month" : friend_birth_month,
                "birth_day" : friend_birth_day,
                "birth_type" : friend_birth_gb,
                "birth_time" : friend_birth_time,
                "language_code" : Util.getLanguage()
            ]
            
        }else{
            
            param = [
                "birth_year" : userInfo.memberBirthYear ?? "",
                "birth_month" : userInfo.memberBirthMonth ?? "",
                "birth_day" : userInfo.memberBirthDay ?? "",
                "birth_type" : userInfo.memberBirthTypeGb ?? "",
                "birth_time" : userInfo.memberBirthTime ?? "",
                "language_code" : Util.getLanguage()
            ]
            
            print("language_code : \(Util.getLanguage())")
        }
        
        
        getSaju(param: param)
    }
    
    func getSaju(param: Dictionary<String,String>){
        
        
        let url = Constants.urlPrefix + "/unse/getSaju"
        
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
                        let sajus = json["saju"].arrayValue[0]
                        
                            
                        self.stars.append(sajus["total_title"].stringValue)
                        self.stars.append(sajus["first_title"].stringValue)
                        self.stars.append(sajus["middle_title"].stringValue)
                        self.stars.append(sajus["last_title"].stringValue)
                        self.stars.append(sajus["before_title"].stringValue)
                        
                        self.keywords.append(sajus["total_keyword"].stringValue)
                        self.keywords.append(sajus["first_keyword"].stringValue)
                        self.keywords.append(sajus["middle_keyword"].stringValue)
                        self.keywords.append(sajus["last_keyword"].stringValue)
                        self.keywords.append(sajus["before_keyword"].stringValue)
                        
                        self.contents.append(sajus["total_unse"].stringValue)
                        self.contents.append(sajus["first_unse"].stringValue)
                        self.contents.append(sajus["middle_unse"].stringValue)
                        self.contents.append(sajus["last_unse"].stringValue)
                        self.contents.append(sajus["before_unse"].stringValue)
                            
//                        print("keywords : \(self.keywords)")
                        self.keywordContentLbl.text = self.keywords[0]
                        self.contentsLbl.text = self.contents[0]
                        
                    }
                default:
                    return


                }
            }
    }
    
    @objc func closeImgClicked(){
        if from == "NEW"{
            let storyboard = UIStoryboard.init(name: "SajuInfoSavePop", bundle: nil)
            guard let sajuInfoSavePop = storyboard.instantiateViewController(identifier: "sajuInfoSavePop") as? SajuInfoSavePopViewController else{ return }
            sajuInfoSavePop.modalTransitionStyle = .coverVertical
            sajuInfoSavePop.modalPresentationStyle = .overCurrentContext
            sajuInfoSavePop.from = Constants.JUNGTONG_UNSE_NAME[1]
            
            sajuInfoSavePop.name = friend_name
            self.present(sajuInfoSavePop,animated: true,completion: nil)
        }else{
         
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func tabClicked(sender: TapGestureRecognizer){
        print("chongTabClicked")
        
        curTab = sender.tapGB
        setAllUnderLinesHidden()
        underLines[curTab].isHidden = false
        
        keywordContentLbl.text = keywords[curTab]
        contentsLbl.text = contents[curTab]
        
    }
    
    func setAllUnderLinesHidden(){
        var i = 0
        while i < totalTabNum{
            underLines[i].isHidden = true
            i += 1
        }
    }
    
    func saveFriendInfo(){
        print("saveFriendInfo called~!")
        
        
//        print("abcdef~!!")
//        let formatter_year = DateFormatter()
//        formatter_year.dateFormat   = "yyyy"
//        let year    = formatter_year.string(from: Date())
        
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

class TapGestureRecognizer: UITapGestureRecognizer{
    var tapGB: Int = 0
}
