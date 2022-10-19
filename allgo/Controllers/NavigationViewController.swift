//
//  NavigationViewController.swift
//  allgo
//
//  Created by 한호철 on 2022/06/13.
//

import UIKit

class NavigationViewController: UIViewController {

    
    @IBOutlet var closeBtn: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var userSex: UILabel!
    @IBOutlet var userBirth: UILabel!
    @IBOutlet var userBirthType: UILabel!
    @IBOutlet var userBirthTime: UILabel!
    @IBOutlet var unseMenu: UILabel!
    @IBOutlet var sajuInfoMenu: UILabel!
    @IBOutlet var rankingMenu: UILabel!
    @IBOutlet var gongjiMenu: UILabel!
    @IBOutlet var accountMenu: UILabel!
    
    var userInfo: UserInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let closeBtnTap = UITapGestureRecognizer(target: self, action: #selector(closeBtnClicked))
        closeBtn.isUserInteractionEnabled = true
        closeBtn.addGestureRecognizer(closeBtnTap)
        
        let unseMenuTap = UITapGestureRecognizer(target: self, action: #selector(unseMenuClicked))
        unseMenu.isUserInteractionEnabled = true
        unseMenu.addGestureRecognizer(unseMenuTap)
        
        let sajuInfoMenuTap = UITapGestureRecognizer(target: self, action: #selector(sajuInfoMenuClicked))
        sajuInfoMenu.isUserInteractionEnabled = true
        sajuInfoMenu.addGestureRecognizer(sajuInfoMenuTap)
        
        let rankingMenuTap = UITapGestureRecognizer(target: self, action: #selector(rankingMenuClicked))
        rankingMenu.isUserInteractionEnabled = true
        rankingMenu.addGestureRecognizer(rankingMenuTap)
        
        let gongjiMenuTap = UITapGestureRecognizer(target: self, action: #selector(gongjiMenuClicked))
        gongjiMenu.isUserInteractionEnabled = true
        gongjiMenu.addGestureRecognizer(gongjiMenuTap)
        
        let accountMenuTap = UITapGestureRecognizer(target: self, action: #selector(accountMenuClicked))
        accountMenu.isUserInteractionEnabled = true
        accountMenu.addGestureRecognizer(accountMenuTap)
        
        
        userInfo    = UserInfo.shared
        
        setData()
    }
    
    @objc func closeBtnClicked(){
        print("closeBtnClicked() called~!")
    
        self.hero.modalAnimationType = .selectBy(presenting: .pull(direction: .left), dismissing: .slide(direction: .right))
        self.dismiss(animated: true,completion: nil)
        
        
    }
    
    @objc func unseMenuClicked(){
        print("unseMenuClicked() called~!")
        
        guard let pvc = self.presentingViewController else { return }

        self.isHeroEnabled = true
        self.hero.modalAnimationType = .selectBy(presenting: .pull(direction: .left), dismissing: .slide(direction: .right))
        
        self.dismiss(animated: true) {
            
            let storyboard = UIStoryboard.init(name: "Unse", bundle: nil)
            let unsePage = storyboard.instantiateViewController(identifier: "unse")
            unsePage.modalTransitionStyle = .coverVertical
            unsePage.modalPresentationStyle = .fullScreen
            pvc.present(unsePage, animated: true, completion: nil)
        }
        
    }
    
    @objc func rankingMenuClicked(){
        print("rankingMenuClicked() called~!")
        
        guard let pvc = self.presentingViewController else { return }

        self.isHeroEnabled = true
        self.hero.modalAnimationType = .selectBy(presenting: .pull(direction: .left), dismissing: .slide(direction: .right))
        
        self.dismiss(animated: true) {
            
            let storyboard = UIStoryboard.init(name: "Ranking", bundle: nil)
            let rankingVC = storyboard.instantiateViewController(identifier: "ranking")
            rankingVC.modalTransitionStyle = .coverVertical
            rankingVC.modalPresentationStyle = .fullScreen
            pvc.present(rankingVC, animated: true, completion: nil)
        }
        
    }
    
    @objc func sajuInfoMenuClicked(){
        
        print("sajuInfoMenuClicked() called~!")
        
        guard let pvc = self.presentingViewController else { return }

        self.isHeroEnabled = true
        self.hero.modalAnimationType = .selectBy(presenting: .pull(direction: .left), dismissing: .slide(direction: .right))
        
        self.dismiss(animated: true) {
            
            let storyboard = UIStoryboard.init(name: "SajuInfo", bundle: nil)
            let sajuInfoVC = storyboard.instantiateViewController(identifier: "sajuInfo")
            sajuInfoVC.modalTransitionStyle = .coverVertical
            sajuInfoVC.modalPresentationStyle = .fullScreen
            pvc.present(sajuInfoVC, animated: true, completion: nil)
        }
    }
    
    @objc func gongjiMenuClicked(){
        
        print("gongjiMenuClicked() called~!")
        
        guard let pvc = self.presentingViewController else { return }

        self.isHeroEnabled = true
        self.hero.modalAnimationType = .selectBy(presenting: .pull(direction: .left), dismissing: .slide(direction: .right))
        
        self.dismiss(animated: true) {
            
            let storyboard = UIStoryboard.init(name: "Gongji", bundle: nil)
            let gongjiVC = storyboard.instantiateViewController(identifier: "gongji")
            gongjiVC.modalTransitionStyle = .coverVertical
            gongjiVC.modalPresentationStyle = .fullScreen
            pvc.present(gongjiVC, animated: true, completion: nil)
        }
    }
    
    @objc func accountMenuClicked(){
        
        print("accountMenuClicked() called~!")
        
        guard let pvc = self.presentingViewController else { return }

        self.isHeroEnabled = true
        self.hero.modalAnimationType = .selectBy(presenting: .pull(direction: .left), dismissing: .slide(direction: .right))

        self.dismiss(animated: true) {

            let storyboard = UIStoryboard.init(name: "AccountManager", bundle: nil)
            let accountManagerVC = storyboard.instantiateViewController(identifier: "accountManager")
            accountManagerVC.modalTransitionStyle = .coverVertical
            accountManagerVC.modalPresentationStyle = .fullScreen
            pvc.present(accountManagerVC, animated: true, completion: nil)
        }
    }
    
    func setData(){
        
        userName.text = userInfo.memberName ?? ""
        let sexName = Util.getSexName(sex: userInfo.memberSexGb ?? "")
        userSex.text = sexName
        
        let year = userInfo.memberBirthYear ?? ""
        let month = userInfo.memberBirthMonth ?? ""
        let day = userInfo.memberBirthDay ?? ""
        
        
        userBirth.text = year + "." + month + "." + day
        
        userBirthType.text = Util.getBirthType(type:userInfo.memberBirthTypeGb ?? "")
        
        print(userInfo.memberBirthTime ?? "")
        print(Util.getOrientalTime(time: userInfo.memberBirthTime ?? ""))
        userBirthTime.text = Util.getOrientalTime(time: userInfo.memberBirthTime ?? "")
//        userBirthTime.text = userInfo.
    }
    
    
}
