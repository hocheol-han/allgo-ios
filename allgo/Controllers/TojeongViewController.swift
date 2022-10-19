//
//  TojeongViewController.swift
//  allgo
//
//  Created by 한호철 on 2022/06/20.
//

import UIKit
import Alamofire
import SwiftyJSON

class TojeongViewController: UIViewController {

    @IBOutlet var closeImg: UIImageView!
    @IBOutlet var titleBackground: UIView!
    @IBOutlet var yearTab: UILabel!
    @IBOutlet var yearUnderLine: UIImageView!
    
    @IBOutlet var monthTab: UILabel!
    @IBOutlet var monthUnderLine: UIImageView!
    
    @IBOutlet var keywordYear: UILabel!
    var keywordYearString: String = ""
    var keywordMonthString: String = ""
    
    @IBOutlet var contents: UILabel!
    var yearContents: String = ""
    var monthContents: String = ""
    
    var userInfo: UserInfo!
    var curTab: Int = 0
    
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
        
        userInfo    = UserInfo.shared
//        let titleBackgroundColor = UIColor(hex: Constants.TITLE_BACKGROUND)
        
//        titleBackground.backgroundColor = titleBackgroundColor
        let closeImgTab = UITapGestureRecognizer(target: self, action: #selector(closeImgClicked))
        closeImg.isUserInteractionEnabled = true
        closeImg.addGestureRecognizer(closeImgTab)
        
        yearTab.textColor = Constants.TEXTCOLOR_SELECTED
        monthTab.textColor = Constants.TEXTCOLOR_UNSELECTED
        yearUnderLine.isHidden = false
        monthUnderLine.isHidden = true
        
        let yearMainTab = UITapGestureRecognizer(target: self, action: #selector(yearTabClicked))
        yearTab.isUserInteractionEnabled = true
        yearTab.addGestureRecognizer(yearMainTab)
        
        let monthMainTab = UITapGestureRecognizer(target: self, action: #selector(monthTabClicked))
        monthTab.isUserInteractionEnabled = true
        monthTab.addGestureRecognizer(monthMainTab)
        
        print("from : \(from)")
        
        let formatter_year = DateFormatter()
        
        formatter_year.dateFormat   = "yyyy"
        let year    = formatter_year.string(from: Date())

        var param : [String: String] = [String:String]()
        
        if from == "NEW" || from == "SAVED"{
            print("friend_birth_ymd : \(friend_birth_ymd)")
            param = [
                "seek_year" : year,
                "birth_year" : friend_birth_year,
                "birth_month" : friend_birth_month,
                "birth_day" : friend_birth_day,
                "birth_type" : friend_birth_gb,
                "language_code" : Util.getLanguage()
            ]
            
        }else{
            param = [
                "seek_year" : year,
                "birth_year" : userInfo.memberBirthYear ?? "",
                "birth_month" : userInfo.memberBirthMonth ?? "",
                "birth_day" : userInfo.memberBirthDay ?? "",
                "birth_type" : userInfo.memberBirthTypeGb ?? "",
                "language_code" : Util.getLanguage()
            ]
        }
        
        getInitData(param: param)
    }
    
    @objc func closeImgClicked(){
        if from == "NEW"{
            let storyboard = UIStoryboard.init(name: "SajuInfoSavePop", bundle: nil)
            guard let sajuInfoSavePop = storyboard.instantiateViewController(identifier: "sajuInfoSavePop") as? SajuInfoSavePopViewController else{ return }
            sajuInfoSavePop.modalTransitionStyle = .coverVertical
            sajuInfoSavePop.modalPresentationStyle = .overCurrentContext
            
            sajuInfoSavePop.from = Constants.JUNGTONG_UNSE_NAME[0]
            sajuInfoSavePop.name = friend_name
            self.present(sajuInfoSavePop,animated: true,completion: nil)
        }else{
         
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func getInitData(param: Dictionary<String,String>){
        
        let url = Constants.urlPrefix + "/unse/getTojung"
        
        AF.request(url,
                   method: .post,
                   parameters: param,
                   encoding: JSONEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
//                    .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                //여기서 가져온 데이터를 자유롭게 활용하세요.
                print("kkkkkkkkkkk : \(response.result)")

                switch response.result{

                case .success(let value):
                    let json = JSON(value)
                    print(json["error_number"].stringValue)
                    let errorNumber = json["error_number"].stringValue

                    if errorNumber == Constants.SEARCH_OK{
                        let tojungs = json["tojung"].arrayValue
                        for tojung in tojungs {
                            print("keyword : \(tojung["total_mean"].stringValue)")
                            self.keywordYearString = tojung["keyword"].stringValue
                            self.keywordMonthString = tojung["total_mean"].stringValue
                            self.keywordYear.text = self.keywordYearString
                            
                            self.yearContents = tojung["total"].stringValue
                            self.monthContents = "1월 : " + tojung["monthdata1"].stringValue + "\n\n"
                            + "2월 : " + tojung["monthdata2"].stringValue + "\n\n"
                            + "3월 : " + tojung["monthdata3"].stringValue + "\n\n"
                            + "4월 : " + tojung["monthdata4"].stringValue + "\n\n"
                            + "5월 : " + tojung["monthdata5"].stringValue + "\n\n"
                            + "6월 : " + tojung["monthdata6"].stringValue + "\n\n"
                            + "7월 : " + tojung["monthdata7"].stringValue + "\n\n"
                            + "8월 : " + tojung["monthdata8"].stringValue + "\n\n"
                            + "9월 : " + tojung["monthdata9"].stringValue + "\n\n"
                            + "10월 : " + tojung["monthdata10"].stringValue + "\n\n"
                            + "11월 : " + tojung["monthdata11"].stringValue + "\n\n"
                            + "12월 : " + tojung["monthdata12"].stringValue + "\n\n"
                            
                            
                            self.contents.text = self.yearContents
                            
                            print("yearContents : \(self.yearContents)")
                            print("monthContents : \(self.monthContents)")
                        }
                        
                    }
                default:
                    return


                }
            }
    }

    @objc func yearTabClicked(){
        curTab = 0
//        print("aaaaaaaaaaa")
        yearTab.textColor = Constants.TEXTCOLOR_SELECTED
        monthTab.textColor = Constants.TEXTCOLOR_UNSELECTED
        
        yearUnderLine.isHidden = false
        monthUnderLine.isHidden = true
        
        keywordYear.text = keywordYearString
        contents.text = yearContents
    }
    
    @objc func monthTabClicked(){
        curTab = 1
//        print("bbbbbbbbbbbb")
        monthTab.textColor = Constants.TEXTCOLOR_SELECTED
        yearTab.textColor = Constants.TEXTCOLOR_UNSELECTED
        
        yearUnderLine.isHidden = true
        monthUnderLine.isHidden = false
        
        keywordYear.text = keywordMonthString
        contents.text = monthContents
    }
    
//    @IBAction func closeBtnClicked(_ sender: UIButton) {
//
//
//    }
    
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
