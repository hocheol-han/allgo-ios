//
//  PrivacyPopupViewController.swift
//  allgo
//
//  Created by 한호철 on 2022/05/10.
//

import UIKit
import WebKit

class PrivacyPopupViewController: UIViewController {

    @IBOutlet var webview: WKWebView!
    @IBOutlet var popupTitleLabel: UILabel!
    
    
    var fromVC: String      = ""
    var isPrivacy: Bool     = true
    var strTitle: String    = "이용약관 동의"
    var strUrl: String      = "http://allgom.sirioh.com/policy/ko"
    var strUrl2: String     = "http://allgom.sirioh.com/privacy/ko"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popupTitleLabel.text = strTitle
        
        guard let url = URL(string: strUrl) else { return }
        let request = URLRequest(url: url)
        webview?.load(request)
    
        
    }

    @IBAction func closePopup(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func agree(_ sender: UIButton) {
        
//        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)//PrivacyPopup : 파일명
//        let registerView = storyboard.instantiateViewController(identifier: "registerView") //privacyPopup : storyboard id
//
//        let temp = registerView as? RegisterViewController
//        temp?.checkPrivacyBtn(isCheck: true)
//        self.dismiss(animated: true, completion: nil)
        let preVC = self.presentingViewController
        
        if fromVC == "POPUP"{
            
            guard let vc = preVC as? PolicyAgreeViewController else{
                return
            }
            if isPrivacy == true{
                vc.isPrivacyUseAgreeChecked = true
            }else{
                vc.isUsePolicyAgreeChecked = true
            }
            vc.checkAgree()
            
        }else if fromVC == "REGISTERVC"{
            guard let vc = preVC as? RegisterViewController else{
                return
            }
            if isPrivacy == true{
                vc.isPrivacyBtnClicked = true
            }else{
                vc.isUseBtnClicked = true
            }
            vc.checkPrivacyBtn(isCheck: true)
            
        }
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
}
