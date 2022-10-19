//
//  AnimalViewController.swift
//  allgo
//
//  Created by 한호철 on 2022/07/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class AnimalViewController: UIViewController {

    @IBOutlet var closeImg: UIImageView!
    @IBOutlet var keywordLbl: UILabel!
    @IBOutlet var keywordBarImg: UIImageView!
    @IBOutlet var keywordContentLbl: UILabel!
    @IBOutlet var contentLbl: UILabel!
    
    var userInfo:UserInfo!
    
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
    
    var conId:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInit()
    }
    
    func setInit(){
        
        userInfo = UserInfo.shared
        
        keywordLbl.backgroundColor = Constants.BUTTON_GREEN
        keywordLbl.clipsToBounds = true
        keywordLbl.layer.cornerRadius = 10
        keywordLbl.textColor = Constants.WHITE
        
        keywordBarImg.backgroundColor = Constants.BUTTON_GREEN
        
        let closeImgTab = UITapGestureRecognizer(target: self, action: #selector(closeImgClicked))
        closeImg.isUserInteractionEnabled = true
        closeImg.addGestureRecognizer(closeImgTab)
        
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
            
            getAnimal(param: param)
            
        }else{
            
            param = [
                
                "birth_year" : userInfo.memberBirthYear ?? "",
                "birth_month" : userInfo.memberBirthMonth ?? "",
                "birth_day" : userInfo.memberBirthDay ?? "",
                "birth_type" : userInfo.memberBirthTypeGb ?? "",
                "language_code" : Util.getLanguage()
            
            ]
            
            getAnimal(param: param)
            
        }
    }
    
    @objc func closeImgClicked(){
        if from == "NEW"{
            let storyboard = UIStoryboard.init(name: "SajuInfoSavePop", bundle: nil)
            guard let sajuInfoSavePop = storyboard.instantiateViewController(identifier: "sajuInfoSavePop") as? SajuInfoSavePopViewController else{ return }
            sajuInfoSavePop.modalTransitionStyle = .coverVertical
            sajuInfoSavePop.modalPresentationStyle = .overCurrentContext
            sajuInfoSavePop.from = Constants.THEME_UNSE_NAME[4]
            
            sajuInfoSavePop.name = friend_name
            self.present(sajuInfoSavePop,animated: true,completion: nil)
        }else{
         
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    func getAnimal(param: Dictionary<String,String>){
        let url = Constants.urlPrefix + "/theme/getAnimal"
        
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
                        let animal = json["animal"].arrayValue[0]

                        self.conId = animal["id"].stringValue
//                        print("conId : \(self.conId)")
                        let title: String = animal["title"].stringValue
                        let contents: String = animal["contents"].stringValue
                        let keywords: String = animal["keyword"].stringValue
                        
                        self.keywordContentLbl.text = keywords
                        self.contentLbl.text = title + "\n\n" + contents
                        
                        
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
