//
//  AccountManagerViewController.swift
//  allgo
//
//  Created by 한호철 on 2022/09/01.
//

import UIKit

class AccountManagerViewController: UIViewController {
    
    var userInfo:UserInfo!
    
    @IBOutlet var menuImg: UIImageView!
    @IBOutlet var upperView: UIView!
    @IBOutlet var phoneNoLbl: UILabel!
    @IBOutlet var gibunCheckImg: UIImageView!
    @IBOutlet var unseCheckImg: UIImageView!
    
    
    var isGibunCheck:String = "Y"
    var isUnseCheck:String = "Y"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setInit()
    }
    
    func setInit(){
        
        userInfo = UserInfo.shared
        
        if userInfo.isLogin == true{
            
            upperView.isHidden = true
            phoneNoLbl.text = userInfo.memberPhoneNo
            isGibunCheck = UserDefaults.standard.string(forKey: userInfo.memberId ?? "" + Constants.GIBUN_CHECK_ALRIM) ?? "Y"
            
//            print("isGibunCheck : \(isGibunCheck)")
            
        }else if userInfo.isLogin == false{
            
            isGibunCheck = "Y"
            isUnseCheck = "Y"
            
        }
        
        let menuTap = UITapGestureRecognizer(target: self, action: #selector(menuClicked))
        menuImg.isUserInteractionEnabled = true
        menuImg.addGestureRecognizer(menuTap)
        
        let gibunCheckTap = UITapGestureRecognizer(target: self, action: #selector(gibunCheckClicked))
        gibunCheckImg.isUserInteractionEnabled = true
        gibunCheckImg.addGestureRecognizer(gibunCheckTap)
        
        let unseCheckTap = UITapGestureRecognizer(target: self, action: #selector(unseCheckClicked))
        unseCheckImg.isUserInteractionEnabled = true
        unseCheckImg.addGestureRecognizer(unseCheckTap)
        
        let phoneNoTap = UITapGestureRecognizer(target: self, action: #selector(phoneNoClicked))
        phoneNoLbl.isUserInteractionEnabled = true
        phoneNoLbl.addGestureRecognizer(phoneNoTap)
        
    }
    
    @objc func menuClicked(){
        
        guard let pvc = self.presentingViewController else { return }

        self.isHeroEnabled = true
        self.hero.modalAnimationType = .selectBy(presenting: .pull(direction: .left), dismissing: .slide(direction: .right))

        self.dismiss(animated: true) {

            let storyboard = UIStoryboard.init(name: "Navigation", bundle: nil)
            let navigationVC = storyboard.instantiateViewController(identifier: "navigation")
            navigationVC.modalTransitionStyle = .coverVertical
            navigationVC.modalPresentationStyle = .fullScreen
            pvc.present(navigationVC, animated: true, completion: nil)
        }
    }
    
    @objc func gibunCheckClicked(){
        print("isGibunCheck : \(isGibunCheck)")
        if isGibunCheck == "N"{
            
            isGibunCheck = "Y"
            gibunCheckImg.image = UIImage(named: Constants.CHECK_ON)
            
        }else if isGibunCheck == "Y"{
            
            isGibunCheck = "N"
            gibunCheckImg.image = UIImage(named: Constants.CHECK_OFF)
            
        }
        
        UserDefaults.standard.setValue(isGibunCheck, forKey: userInfo.memberId ?? "" + Constants.GIBUN_CHECK_ALRIM)
    }
    
    @objc func unseCheckClicked(){
        print("isUnseCheck : \(isUnseCheck)")
        if isUnseCheck == "N"{
            
            isUnseCheck = "Y"
            unseCheckImg.image = UIImage(named: Constants.CHECK_ON)
            
        }else if isUnseCheck == "Y"{
            
            isUnseCheck = "N"
            unseCheckImg.image = UIImage(named: Constants.CHECK_OFF)
            
        }
        
        UserDefaults.standard.setValue(isUnseCheck, forKey: userInfo.memberId ?? "" + Constants.UNSE_CHECK_ALRIM)
    }
    
    @objc func phoneNoClicked(){
        print("phoneNoClicked ~~")
        
        let storyboard = UIStoryboard.init(name: "PhoneNo", bundle: nil)
        let phoneNoVC = storyboard.instantiateViewController(identifier: "phoneNo")
        phoneNoVC.modalTransitionStyle = .coverVertical
        phoneNoVC.modalPresentationStyle = .overCurrentContext
        
        self.present(phoneNoVC,animated: true,completion: nil)
        
    }

}
