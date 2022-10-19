//
//  SajuInfoPopViewController.swift
//  allgo
//
//  Created by 한호철 on 2022/06/16.
//

import UIKit

class SajuInfoPopViewController: UIViewController {

    var content: String = ""
    @IBOutlet var parentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
    }
    

    @IBAction func closeBtnClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func goMySaju(_ sender: UIButton) {
        print("goMySaju() called~!")
        
        print("content : \(self.content)")
        guard let pvc = self.presentingViewController else { return }

//        self.isHeroEnabled = true
//        self.hero.modalAnimationType = .selectBy(presenting: .pull(direction: .left), dismissing: .slide(direction: .right))
        
        self.dismiss(animated: true) {
            
            if self.content == Constants.JUNGTONG_UNSE_NAME[0] { //토정비결
                
                let storyboard = UIStoryboard.init(name: "Tojeong", bundle: nil)
                let unsePage = storyboard.instantiateViewController(identifier: "tojeong")
                unsePage.modalTransitionStyle = .coverVertical
                unsePage.modalPresentationStyle = .fullScreen
                pvc.present(unsePage, animated: true, completion: nil)
                
            }else if self.content == Constants.JUNGTONG_UNSE_NAME[1] {//사주
                
                let storyboard = UIStoryboard.init(name: "Saju", bundle: nil)
                let sajuVC = storyboard.instantiateViewController(identifier: "saju")
                sajuVC.modalTransitionStyle = .coverVertical
                sajuVC.modalPresentationStyle = .fullScreen
                pvc.present(sajuVC, animated: true, completion: nil)
                
            }else if self.content == Constants.JUNGTONG_UNSE_NAME[2] {//궁합
            
                let storyboard = UIStoryboard.init(name: "Gunghap", bundle: nil)
                let gunghapVC = storyboard.instantiateViewController(identifier: "gunghap")
                gunghapVC.modalTransitionStyle = .coverVertical
                gunghapVC.modalPresentationStyle = .fullScreen
                pvc.present(gunghapVC, animated: true, completion: nil)
                
            }else if self.content == Constants.THEME_UNSE_NAME[4] {//동물점
                
                let storyboard = UIStoryboard.init(name: "Animal", bundle: nil)
                let animalVC = storyboard.instantiateViewController(identifier: "animal")
                animalVC.modalTransitionStyle = .coverVertical
                animalVC.modalPresentationStyle = .fullScreen
                pvc.present(animalVC, animated: true, completion: nil)
            
            }else if self.content == Constants.THEME_UNSE_NAME[5]{//탄생화점 꽃점
                
                let storyboard = UIStoryboard.init(name: "Flower", bundle: nil)
                let flowerVC = storyboard.instantiateViewController(identifier: "flower")
                flowerVC.modalTransitionStyle = .coverVertical
                flowerVC.modalPresentationStyle = .fullScreen
                pvc.present(flowerVC, animated: true, completion: nil)
                
            }else if self.content == Constants.THEME_UNSE_NAME[6]{
                
                let storyboard = UIStoryboard.init(name: "CatchMind", bundle: nil)
                let flowerVC = storyboard.instantiateViewController(identifier: "catchMind")
                flowerVC.modalTransitionStyle = .coverVertical
                flowerVC.modalPresentationStyle = .fullScreen
                pvc.present(flowerVC, animated: true, completion: nil)
            }else if self.content == Constants.THEME_UNSE_NAME[8]{
                
                let storyboard = UIStoryboard.init(name: "BloodNStar", bundle: nil)
                let bloodNStarVC = storyboard.instantiateViewController(identifier: "bloodNStar")
                bloodNStarVC.modalTransitionStyle = .coverVertical
                bloodNStarVC.modalPresentationStyle = .fullScreen
                pvc.present(bloodNStarVC, animated: true, completion: nil)
                
            }else if self.content == Constants.THEME_UNSE_NAME[9]{
                
                let storyboard = UIStoryboard.init(name: "StarStory", bundle: nil)
                let starStoryVC = storyboard.instantiateViewController(identifier: "starStory")
                starStoryVC.modalTransitionStyle = .coverVertical
                starStoryVC.modalPresentationStyle = .fullScreen
                pvc.present(starStoryVC, animated: true, completion: nil)
                
            }else if self.content == Constants.THEME_UNSE_NAME[10]{
                
                let storyboard = UIStoryboard.init(name: "StarNDdi", bundle: nil)
                let starNDdiVC = storyboard.instantiateViewController(identifier: "starNDdi")
                starNDdiVC.modalTransitionStyle = .coverVertical
                starNDdiVC.modalPresentationStyle = .fullScreen
                pvc.present(starNDdiVC, animated: true, completion: nil)
                
            }
        }
        
    }
    
    @IBAction func goFriendSaju(_ sender: UIButton) {
        
        guard let pvc = self.presentingViewController else { return }
        
        self.dismiss(animated: true) {
            
            let storyboard = UIStoryboard.init(name: "FriendList", bundle: nil)
//            let friendListPage = storyboard.instantiateViewController(identifier: "friendList")
            guard let friendListPage = storyboard.instantiateViewController(identifier: "friendList") as? FriendListViewController else{ return }
            friendListPage.content = self.content
            print("content : \(self.content)")
            friendListPage.modalTransitionStyle = .coverVertical
            friendListPage.modalPresentationStyle = .fullScreen
            pvc.present(friendListPage, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func insertNewSaju(_ sender: UIButton) {
        
        guard let pvc = self.presentingViewController else { return }

//        self.isHeroEnabled = true
//        self.hero.modalAnimationType = .selectBy(presenting: .pull(direction: .left), dismissing: .slide(direction: .right))
        
        self.dismiss(animated: true) {
            
            let storyboard = UIStoryboard.init(name: "SajuInfoInput", bundle: nil)
//            let sajuInfoInput = storyboard.instantiateViewController(identifier: "sajuInfoInput")
            guard let sajuInfoInput = storyboard.instantiateViewController(identifier: "sajuInfoInput") as? SajuInfoInputViewController else{ return }
            sajuInfoInput.content = self.content
            
            sajuInfoInput.modalTransitionStyle = .coverVertical
            sajuInfoInput.modalPresentationStyle = .fullScreen
            pvc.present(sajuInfoInput, animated: true, completion: nil)
        }
    }
}
