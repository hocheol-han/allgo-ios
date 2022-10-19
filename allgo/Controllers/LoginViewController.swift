//
//  ViewController.swift
//  allgo
//
//  Created by 한호철 on 2022/04/19.
//

import UIKit
import Alamofire
import SwiftyJSON
import UserNotifications


class LoginViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    var commercialPopUp: PopUp!

    @IBOutlet var idField: UITextField!
    @IBOutlet var popupBtn: UIButton!
    
    var mId: String = ""
    var userInfo: UserInfo!
    var todayUnse: TodayUnse!
//    let const: Constants = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        userInfo    = UserInfo.shared
        todayUnse   = TodayUnse.shared
        
//        self.popupBtn.layer.cornerRadius = 10
//        상단 네비게이션 바 부븐을 숨김처리한다
        self.navigationController?.isNavigationBarHidden = true
//        checkToken()
        requestPermission()
        
    }
    
    func checkToken(){
        
        let memberId: String = UserDefaults.standard.string(forKey: "member_id") ?? ""
        print("memberId : \(memberId)")
        let token: String = UserDefaults.standard.string(forKey: memberId + "token") ?? ""
        print("\(memberId + "token")")
        print("token :\(token)")
        
        
        let url = Constants.urlPrefix + "/member/checkToken"
        
        //in_member_id
        //in_password
        
        let param : [String: Any] = [
            "token" : token
        ]
                AF.request(url,
                           method: .post,
                           parameters: param,
                           encoding: JSONEncoding.default,
                           headers: ["Content-Type":"application/json", "Accept":"application/json"])
//                    .validate(statusCode: 200..<300)
                    .responseJSON { (response) in
                        //여기서 가져온 데이터를 자유롭게 활용하세요.
                        print(response.result)
                        
                        switch response.result{
                            
                        case .success(let value):
                            let json = JSON(value)
                            print(json["error_number"].stringValue)
                            
                            let errorNumber = json["error_number"].stringValue
                            if errorNumber == Constants.SEARCH_OK{
                                
                                self.getTodayUnse()
                                
                            }
                                
                        default:
                            return
                            
                            
                        }
                        
                }
    }


    @IBAction func PopupBtnTapped(_ sender: Any) {
        
        self.commercialPopUp = PopUp(frame: self.view.frame)
        self.commercialPopUp.closeBtn.addTarget(self, action: #selector(closeBtnTapped), for: .touchUpInside)
        self.commercialPopUp.completeBtn.addTarget(self, action: #selector(closeBtnTapped), for: .touchUpInside)
        self.view.addSubview(commercialPopUp)
        
    }
    
    @objc func closeBtnTapped(){
        self.commercialPopUp.removeFromSuperview()
    }
    
    
    @IBAction func loginBtnClicked(_ sender: UIButton) {
        print("loginBtnClicked() called~!")
//        if let id = idField.text{
//            print("\(id)")
//            mId = id
//        }
    
    
        //wow00wow@me.com sirio2020

        
        let url = Constants.urlPrefix + "/member/login"
        
        //in_member_id
        //in_password
//        let tempPwd = "images!234"
        
//        print(tempPwd.sha256())
//        print("eb5927a0a62f32a824f80e6d8a1357f853c1ede2f637a2f47b9a568da0f9f521")
        //
        
        let param : [String: Any] = [
            "in_offset" : "32400000",
            "in_timezone" : "Asia/Seoul",
            "in_join_cd" : "M03001",
            "in_social_id" : "",
            "in_member_id" : "hyeongrok@gmail.com",
            "in_password" : "eb5927a0a62f32a824f80e6d8a1357f853c1ede2f637a2f47b9a568da0f9f521",
            "in_access_token" : ""
        ]
                AF.request(url,
                           method: .post,
                           parameters: param,
                           encoding: JSONEncoding.default,
                           headers: ["Content-Type":"application/json", "Accept":"application/json"])
//                    .validate(statusCode: 200..<300)
                    .responseJSON { (response) in
                        //여기서 가져온 데이터를 자유롭게 활용하세요.
                        print(response.result)
                        
                        switch response.result{
                            
                        case .success(let value):
                            let json = JSON(value)
                            print(json["error_number"].stringValue)
                            
                            let errorNumber = json["error_number"].stringValue
                            if errorNumber == Constants.SEARCH_OK{
//                                print(type(of:json["memberInfo"]["country_cd"]))
//                                print(json["memberInfo"]["country_cd"])
                                
                                self.userInfo.isLogin = true
                                print("member_id : \(json["member_id"].stringValue)")
                                self.userInfo.memberId = json["member_id"].stringValue
                                UserDefaults.standard.setValue(json["member_id"].stringValue,forKey : "member_id")
////                                print(UserDefaults.standard.string(forKey: "member_id") ?? "")
                                UserDefaults.standard.setValue(json["member_id"].stringValue, forKey: "last_login_id")
                                self.userInfo.memberCountryPhoneNo = json["memberInfo"]["country_phone_no"].stringValue
                                self.userInfo.memberPhoneNo = json["memberInfo"]["phone_no"].stringValue
                                self.userInfo.memberEmail = json["memberInfo"]["email"].stringValue
                                
                                UserDefaults.standard.setValue((json["jwt_token"].stringValue),forKey: (self.userInfo.memberId ?? "") + "token")
                                
                                print((self.userInfo.memberId ?? "") + "token")
                                UserDefaults.standard.string(forKey: self.userInfo.memberId ?? "" + "token")
                                
                                let memberBirthYMD : String = json["member_birth_ymd"].stringValue
                                print("memberBirthYMD : \(memberBirthYMD)")
                                
                                let yearIndex = memberBirthYMD.index(memberBirthYMD.startIndex, offsetBy: 3)
                                
                                self.userInfo.memberBirthYear = String(memberBirthYMD[memberBirthYMD.startIndex ... yearIndex])
//                                print("memberBirthYear : \(self.userInfo.memberBirthYear ?? "") ")
                                
                                let monthStartIndex = memberBirthYMD.index(memberBirthYMD.startIndex,offsetBy: 4)
                                let monthEndIndex = memberBirthYMD.index(monthStartIndex,offsetBy: 1)
                                self.userInfo.memberBirthMonth = String(memberBirthYMD[monthStartIndex ... monthEndIndex])
                                
                                let dayStartIndex = memberBirthYMD.index(memberBirthYMD.startIndex,offsetBy: 6)
                                let dayEndIndex = memberBirthYMD.index(memberBirthYMD.startIndex,offsetBy: 7)
                                
                                self.userInfo.memberBirthDay = String(memberBirthYMD[dayStartIndex ... dayEndIndex])
                                
                                self.userInfo.memberName = json["member_name"].stringValue
                                self.userInfo.memberBirthTime = json["member_birth_time"].stringValue
                                self.userInfo.memberSexGb = json["member_sex_gb"].stringValue
                                self.userInfo.memberBlood = json["memberInfo"]["member_blood"].stringValue
                                
                                self.userInfo.memberBirthTypeGb = json["member_birthtype_gb"].stringValue
                                self.userInfo.memberGabja = json["member_gabja"].stringValue
                                
                                
                                let policy      = json["memberInfo"]["policy"].stringValue
                                let policyId    = json["memberInfo"]["policyid"].stringValue
                                let privacy     = json["memberInfo"]["privacy"].stringValue
                                let privacyId   = json["memberInfo"]["privacyid"].stringValue
                                
                                print("policy : \(policy) \(policyId) \(privacy) \(privacyId)")
                                
                                if policy == "0" || privacy == "" {
                                    
                                    let policyParam : [String: Any] = [
                                        
                                        "policy" : policy,
                                        "policyId" : policyId,
                                        "privacy" : privacy,
                                        "privacyId" : privacyId
        
                                    ]
                                    self.makePolicyAgreePopup(param : policyParam)
                                }else{
                                
                                    self.getTodayUnse()
    //                                print(self.userInfo.memberBlood)
                                    
    //                                print(self.userInfo.memberBirthYear)
    //                                print(self.userInfo.memberBirthMonth)
    //                                print(self.userInfo.memberBirthDay)
                                    
    //                                let endIndex = memberBirthYMD.index(memberBirthYMD.startIndex,offsetBy: 4)
                                }
                            
                            } else if errorNumber == Constants.PWD_WRONG{
                                
                                self.makeUserInfoConfirmPopup(isSocial: false)
                                
                            } else if errorNumber == Constants.NO_MEMBERID{
                                
                                self.makeUserInfoConfirmPopup(isSocial: false)
                                
                            }else if errorNumber == Constants.SOCIALID_DUP{
                                
                                self.makeUserInfoConfirmPopup(isSocial: true)
                            }
                            
                        default:
                            return
                            
                            
                        }
                        
                }
        
    }
    
    func getTodayUnse(){
        
        print("getTodayUnse() called~!")
        
        let formatter_year = DateFormatter()
        let formatter_month = DateFormatter()
        let formatter_day = DateFormatter()
        
        formatter_year.dateFormat   = "yyyy"
        formatter_month.dateFormat  = "MM"
        formatter_day.dateFormat    = "dd"
        
        let year    = formatter_year.string(from: Date())
        let month   = formatter_month.string(from: Date())
        let day     = formatter_day.string(from: Date())
        
//        print("year \(year) \(month) \(day)")
//        print(userInfo.memberId ?? "")
        let langStr = Locale.current.languageCode
//        print("\(langStr)")
        
        
        let param : [String: Any] = [
            "member_id" : userInfo.memberId ?? "",
            "seek_year" : year,
            "seek_month" : month,
            "seek_day" : day,
            "birth_year" : userInfo.memberBirthYear ?? "",
            "birth_month" : userInfo.memberBirthMonth ?? "",
            "birth_day" : userInfo.memberBirthDay ?? "",
            "birth_type" : userInfo.memberBirthTypeGb ?? "",
            "user_sex" : userInfo.memberSexGb ?? "",
            "user_language" : langStr ?? ""
        ]
        
        let url = Constants.urlPrefix + "/unse/today_unse"
        
        AF.request(url,
                   method: .post,
                   parameters: param,
                   encoding: JSONEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
//                    .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                //여기서 가져온 데이터를 자유롭게 활용하세요.
                print(response.result)
                
                switch response.result{
                    
                case .success(let value):
                    let json = JSON(value)
                    print(json["error_number"].stringValue)
                    let errorNumber = json["error_number"].stringValue
                    
                    if errorNumber == Constants.SEARCH_OK{
                        
                        let unseId: String = json["unse_id"].stringValue
                        self.todayUnse.unseId = unseId
                        self.todayUnse.todayDirection = json["direction"].stringValue
                        print("\(json["direction"].stringValue)")
                        self.todayUnse.todayColor = json["color"].stringValue
                        self.todayUnse.todayNumber = json["number"].stringValue
                        
                        let scoreString = json["score"].stringValue
                        self.todayUnse.todayUnseScoreString = scoreString
                        
                        let scores = scoreString.components(separatedBy: ".")
                        print("\(scores.count)")
                        var realScore: String = ""
                        for (index,score) in scores.enumerated() {
//                            print("index : \(index) score : \(score)")
                            if index == 0 || index == 3 {
                                continue
                            }
                            if index == (scores.count - 1){
                                realScore = realScore + scores[index]
                            }else{
                                realScore = realScore + scores[index] + "."
                            }
                            
                        }
                        
//                        print("realScore : \(realScore)")
                        self.todayUnse.todayRealScore = realScore
                        
//                        print(scores[1])
                        
                        var wishJisu: Int = Int(scores[1]) ?? 0
                        var promotionJisu: Int = Int(scores[2]) ?? 0
                        var luckJisu: Int = Int(scores[4]) ?? 0
                        var businessJisu: Int = Int(scores[5]) ?? 0
                        var loveJisu: Int = Int(scores[6]) ?? 0
                        
                        self.todayUnse.todayRealScoreTotal = wishJisu + promotionJisu + luckJisu + businessJisu + loveJisu
                        
                        print("\(self.userInfo.memberId ?? "")bujuk_stored_title")
                        if UserDefaults.standard.string(forKey: self.userInfo.memberId ?? "" + "bujuk_stored_title") == "소망"{
                            
                            wishJisu = wishJisu + (Int(UserDefaults.standard.string(forKey: self.userInfo.memberId ?? "" + "bujuk_stored_level") ?? "") ?? 0)
                            
                        }else if UserDefaults.standard.string(forKey: self.userInfo.memberId ?? "" + "bujuk_stored_title") == "승진"{
                            
                            promotionJisu = promotionJisu + (Int(UserDefaults.standard.string(forKey: self.userInfo.memberId ?? "" + "bujuk_stored_level") ?? "") ?? 0)
                            
                        }else if UserDefaults.standard.string(forKey: self.userInfo.memberId ?? "" + "bujuk_stored_title") == "행운"{
                            
                            luckJisu = luckJisu + (Int(UserDefaults.standard.string(forKey: self.userInfo.memberId ?? "" + "bujuk_stored_level") ?? "") ?? 0)
                            
                        }else if UserDefaults.standard.string(forKey: self.userInfo.memberId ?? "" + "bujuk_stored_title") == "사업"{
                            
                            businessJisu = businessJisu + (Int(UserDefaults.standard.string(forKey: self.userInfo.memberId ?? "" + "bujuk_stored_level") ?? "") ?? 0)
                            
                        }else if UserDefaults.standard.string(forKey: self.userInfo.memberId ?? "" + "bujuk_stored_title") == "연애"{
                            
                            loveJisu = loveJisu + (Int(UserDefaults.standard.string(forKey: self.userInfo.memberId ?? "" + "bujuk_stored_level") ?? "") ?? 0)
                            
                        }
                        
                        let todayUnseTotal = wishJisu + promotionJisu + luckJisu + businessJisu + loveJisu
                        
                        self.todayUnse.todayUnseScore = todayUnseTotal
                        self.todayUnse.todayTotalJisu = Int(scores[0]) ?? 0
                        self.todayUnse.todayTodalContents = json["contents"].stringValue
                        self.todayUnse.todayWishJisu = wishJisu
                        self.todayUnse.todayWishContents = json["contents1"].stringValue
                        self.todayUnse.todayPromotionJisu = promotionJisu
                        self.todayUnse.todayPromotionContents = json["contents2"].stringValue
                        self.todayUnse.todayJobJisu = Int(scores[3]) ?? 0
                        self.todayUnse.todayJobContents = json["contents3"].stringValue
                        self.todayUnse.todayLuckJisu = luckJisu
                        self.todayUnse.todayLuckContents = json["contents4"].stringValue
                        self.todayUnse.todayLoveJisu = loveJisu
                        self.todayUnse.todayLoveContents = json["contents5"].stringValue
                        
                        
//                        guard let mainPageViewController = self.storyboard?.instantiateViewController(withIdentifier: "mainPage") as? MainPageViewController else { return }
//                                // 화면 전환 애니메이션 설정
//                                mainPageViewController.modalTransitionStyle = .coverVertical
//                                // 전환된 화면이 보여지는 방법 설정 (fullScreen)
//                                mainPageViewController.modalPresentationStyle = .fullScreen
//                                self.present(mainPageViewController, animated: true, completion: nil)
                        
//                        self.dismiss(animated: true, completion: nil)
//
//                        let storyboard = UIStoryboard.init(name: "MainPage", bundle: nil)
//                        let mainPage = storyboard.instantiateViewController(identifier: "mainPage")
//                        mainPage.modalTransitionStyle = .coverVertical
//                        mainPage.modalPresentationStyle = .fullScreen
//                        let page = mainPage as? MainPageViewController
////                        page?.param = param
//
//                        self.present(mainPage,animated: true,completion: nil)
                        

//                        self.isHeroEnabled = true
//                        self.hero.modalAnimationType = .selectBy(presenting: .pull(direction: .left), dismissing: .slide(direction: .right))
                       
                        self.dismiss(animated: true) {
                            
                            let storyboard = UIStoryboard.init(name: "MainPage", bundle: nil)
                            let mainPage = storyboard.instantiateViewController(identifier: "mainPage")
                            mainPage.modalTransitionStyle = .coverVertical
                            mainPage.modalPresentationStyle = .fullScreen
                            let page = mainPage as? MainPageViewController
                            self.present(mainPage, animated: true, completion: nil)
                        }
                        
                    }
                default:
                    return
                    
                     
                }
            }
    }
    
    
    @IBAction func registerBtnClicked(_ sender: UIButton) {
        print("registerBtnClicked() called~!")
        
        guard let registerViewController = self.storyboard?.instantiateViewController(withIdentifier: "registerView") as? RegisterViewController else { return }
                // 화면 전환 애니메이션 설정
                registerViewController.modalTransitionStyle = .coverVertical
                // 전환된 화면이 보여지는 방법 설정 (fullScreen)
                registerViewController.modalPresentationStyle = .fullScreen
                self.present(registerViewController, animated: true, completion: nil)
    }
    
    func makePolicyAgreePopup(param: Dictionary<String,Any>) {
        
        print("makePolicyAgreePopup() called")
        
        let storyboard = UIStoryboard.init(name: "PolicyAgreePopup", bundle: nil)//PrivacyPopup : 파일명
        let policyAgreePopup = storyboard.instantiateViewController(identifier: "policyAgreePopup") //policyAgreePopup : storyboard id
        let temp = policyAgreePopup as? PolicyAgreeViewController
        temp?.param = param
    
        self.present(policyAgreePopup,animated: true,completion: nil)
    }
    
    func makeUserInfoConfirmPopup(isSocial: Bool){
        
        print("makeUserInfoConfirmPopup() called")
        let storyboard = UIStoryboard.init(name: "UserInfoConfirm", bundle: nil)//PrivacyPopup : 파일명
        let userInfoConfrimPopup = storyboard.instantiateViewController(withIdentifier: "userInfoConfirm")
        let popup = userInfoConfrimPopup as? UserInfoConfirmViewController
        popup?.isSocial = isSocial
        
        
        self.present(userInfoConfrimPopup,animated: true,completion: nil)
        
    }
    
    func requestPermission(){
        
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert,.badge,.sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions){
            didAllow,error in
            print(didAllow)
        }
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    
    @IBAction func pushClicked(_ sender: UIButton) {
      
        let push =  UNMutableNotificationContent()
                
        push.title = "test Title"
        push.subtitle = "test subTitle"
        push.body = "test body"
        push.badge = 1
                
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let request = UNNotificationRequest(identifier: "test", content: push, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
}

