//
//  PolicyAgreeViewController.swift
//  allgo
//
//  Created by 한호철 on 2022/05/25.
//

import UIKit
import Alamofire
import SwiftyJSON

class PolicyAgreeViewController: UIViewController {

    var isPrivacyUseAgreeChecked: Bool = false
    var isUsePolicyAgreeChecked: Bool = false
    
    var param : [String: Any] = [ : ]
    
    @IBOutlet var privacyUseAgreeChk: UIImageView!
    @IBOutlet var usePolicyAgreeChk: UIImageView!
    
    @IBOutlet var closeBtn: UIButton!
    let const: Constants = .init()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear() called")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear called")
    }
    

    @IBAction func closeBtnClicked(_ sender: UIButton) {
        
        print("closeBtnClicked() called~!")
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func privacyUseAgreeClicked(_ sender: UIButton) {
        isPrivacyUseAgreeChecked = !isPrivacyUseAgreeChecked
        if isPrivacyUseAgreeChecked == true {

            privacyUseAgreeChk.image = UIImage(named: "ic_check_chk_s")
        }else{
            privacyUseAgreeChk.image = UIImage(named: "ic_check_nor_s")
        }
    
    }
    
    @IBAction func usePolicyAgreeClicked(_ sender: UIButton) {
        
        print("usePolicyAgreeClicked() called~!")
        isUsePolicyAgreeChecked = !isUsePolicyAgreeChecked
        if isUsePolicyAgreeChecked == true {

            usePolicyAgreeChk.image = UIImage(named: "ic_check_chk_s")
        }else{
            usePolicyAgreeChk.image = UIImage(named: "ic_check_nor_s")
        }
    }
    
    @IBAction func makePrivacyPopup(_ sender: UIButton) {
        let storyboard = UIStoryboard.init(name: "PrivacyPopup", bundle: nil)//PrivacyPopup : 파일명
        
        let privacyPopup = storyboard.instantiateViewController(identifier: "privacyPopup") //privacyPopup : storyboard id
        
        let temp = privacyPopup as? PrivacyPopupViewController
        temp?.strTitle = "이용약관 동의"
        temp?.isPrivacy = true
        temp?.fromVC = "POPUP"
        
        self.present(privacyPopup,animated: true,completion: nil)
    }
    
    @IBAction func makeUseTermPopup(_ sender: UIButton) {
        let storyboard = UIStoryboard.init(name: "PrivacyPopup", bundle: nil)//PrivacyPopup : 파일명
        
        let privacyPopup = storyboard.instantiateViewController(identifier: "privacyPopup") //privacyPopup : storyboard id
        
        let temp = privacyPopup as? PrivacyPopupViewController
        temp?.strTitle = "개인정보 수집및 이용 동의"
        temp?.isPrivacy = false
        temp?.fromVC = "POPUP"
        
        self.present(privacyPopup,animated: true,completion: nil)
    }
    
    func checkAgree(){
        print("checkAgree() called")
        
//        var isPrivacyUseAgreeChecked: Bool = false
//        var isUsePolicyAgreeChecked: Bool = false
        
        if isPrivacyUseAgreeChecked == true{
            privacyUseAgreeChk.image = UIImage(named: "ic_check_chk_s")
        }
        
        if isUsePolicyAgreeChecked == true{
            usePolicyAgreeChk.image = UIImage(named: "ic_check_chk_s")
        }
        
    }
    
    
    @IBAction func confirmBtnClicked(_ sender: UIButton) {
//        let util: Util = .init()
        
        if isPrivacyUseAgreeChecked != true{
            
            Util.showToast(message: "개인정보 수집 및 이용 동의는 필수 입니다.", controller: self)
            return
            
        }else if isUsePolicyAgreeChecked != true{
            
            Util.showToast(message: "이용 약관 동의는 필수 입니다.", controller: self)
            return
            
        }
        
        print("param : \(param)")
        
        
        
        let url = Constants.urlPrefix + "/policy/policyAgree"
        
        AF.request(url,
                   method: .post,
                   parameters: param,
                   encoding: JSONEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
//                    .validate(statusCode: 200..<300)
            .response { (response) in
                //여기서 가져온 데이터를 자유롭게 활용하세요.
                print(response.result)
                
                switch response.result{
                    
                case .success(let value):
                    let json = JSON(value)
                    print(json["error_number"].stringValue)
                    
                    if json["error_number"].stringValue == Constants.SEARCH_OK{
                        
                        let preVC = self.presentingViewController
                        guard let vc = preVC as? LoginViewController else{
                            return
                        }
                        
                        vc.getTodayUnse()
                        self.dismiss(animated: true, completion: nil)
                    
                    }
                default:
                    return
                    
                    
                }
            }
        
    }
    
    @IBAction func cancelBtnClicked(_ sender: UIButton) {
        print("cancelBtnClicked() called~!")
        self.dismiss(animated: true, completion: nil)
    }
    
}
