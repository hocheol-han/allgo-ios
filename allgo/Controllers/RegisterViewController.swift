//
//  RegisterViewController.swift
//  allgo
//
//  Created by 한호철 on 2022/04/29.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController {

    var isPrivacyBtnClicked: Bool = false
    var isUseBtnClicked: Bool = false
    
    @IBOutlet var privacyBtn: UIButton!
    @IBOutlet var useBtn: UIButton!
    @IBOutlet var cancelBtn: UIButton!
    
    var isPrivacyAgree: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //상단 네비게이션 바 부분을 숨김처리한다
        self.navigationController?.isNavigationBarHidden = true
        print("viewDidLoad called")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
      print("viewWillAppear called")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear called")
    }
    
    @IBAction func cancelBtnClicked(_ sender: UIButton) {
        
//        print("RegisterViewController :: cancelBtnClicked")
        //네비게이션 뷰 콘트롤러를 팝 한다.
        self.dismiss(animated: true)
    }
    
    @IBAction func privacyBtnClicked(_ sender: UIButton) {
        
        isPrivacyBtnClicked = !isPrivacyBtnClicked
        if isPrivacyBtnClicked == true {
            privacyBtn.setImage(UIImage(named: "ic_check_chk"),for: .normal)
        }else{
            privacyBtn.setImage(UIImage(named: "ic_check_nor"),for: .normal)
        }
    }
    
    
    @IBAction func useBtnClicked(_ sender: UIButton) {
        
        isUseBtnClicked = !isUseBtnClicked
        if isUseBtnClicked == true {
            useBtn.setImage(UIImage(named: "ic_check_chk"), for: .normal)
        }else{
            useBtn.setImage(UIImage(named: "ic_check_nor"), for: .normal)
        }
    }
    
    @IBAction func makePrivacyPopup(_ sender: Any) {
        
        let storyboard = UIStoryboard.init(name: "PrivacyPopup", bundle: nil)//PrivacyPopup : 파일명
        let privacyPopup = storyboard.instantiateViewController(identifier: "privacyPopup") //privacyPopup : storyboard id
        
        let temp = privacyPopup as? PrivacyPopupViewController
        temp?.strTitle = "이용약관 동의"
        temp?.isPrivacy = true
        temp?.fromVC = "REGISTERVC"
        
        self.present(privacyPopup,animated: true,completion: nil)
    }
    
    @IBAction func makeUseTermPopup(_ sender: UIButton) {
        
        let storyboard = UIStoryboard.init(name: "PrivacyPopup", bundle: nil)//PrivacyPopup : 파일명
        
        let privacyPopup = storyboard.instantiateViewController(identifier: "privacyPopup") //privacyPopup : storyboard id
        
        let temp = privacyPopup as? PrivacyPopupViewController
        temp?.strTitle = "개인정보 수집및 이용 동의"
        temp?.isPrivacy = false
        temp?.fromVC = "REGISTERVC"
        
        self.present(privacyPopup,animated: true,completion: nil)
    }
    
    func checkPrivacyBtn(isCheck : Bool){
        print("checkPrivacyBtn called \(isCheck)")
        
        if isPrivacyBtnClicked == true{
            privacyBtn.setImage(UIImage(named: "ic_check_chk"),for: .normal)
        }
        if isUseBtnClicked == true{
            useBtn.setImage(UIImage(named: "ic_check_chk"),for: .normal)
        }

//        privacyBtn.setImage(UIImage(named: "ic_check_chk"),for: .normal)
        
        
    }
}
