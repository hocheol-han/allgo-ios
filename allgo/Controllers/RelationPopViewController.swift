//
//  RelationPopViewController.swift
//  allgo
//
//  Created by 한호철 on 2022/06/28.
//

import UIKit

class RelationPopViewController: UIViewController {

    
    @IBOutlet var parentView: UIView!
    
    @IBOutlet var parentTab: UIView!
    @IBOutlet var friendTab: UIView!
    @IBOutlet var famillyTab: UIView!
    @IBOutlet var etcTab: UIView!
    
    @IBOutlet var closeBtn: UIImageView!
    @IBOutlet var confrimBtn: UIButton!
    
    @IBOutlet var parentCheckBtn: UIImageView!
    @IBOutlet var friendCheckBtn: UIImageView!
    @IBOutlet var famillyCheckBtn: UIImageView!
    @IBOutlet var etcCheckBtn: UIImageView!
    
    var friendCD: String = Constants.PARENT
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setInit()
    }
    
    func setInit(){
        
        parentView.layer.cornerRadius = 20
        
        let closeTab = UITapGestureRecognizer(target: self, action: #selector(closeBtnClicked))
        closeBtn.isUserInteractionEnabled = true
        closeBtn.addGestureRecognizer(closeTab)
        
        confrimBtn.backgroundColor = Constants.GRAY
        confrimBtn.layer.cornerRadius = 18
        
        parentCheckBtn.isHidden = false
        friendCheckBtn.isHidden = true
        famillyCheckBtn.isHidden = true
        etcCheckBtn.isHidden = true
        
        let parentTabFunc = UITapGestureRecognizer(target: self, action: #selector(parentTabClicked))
        parentTab.isUserInteractionEnabled = true
        parentTab.addGestureRecognizer(parentTabFunc)
        
        let friendTabFunc = UITapGestureRecognizer(target: self, action: #selector(friendTabClicked))
        friendTab.isUserInteractionEnabled = true
        friendTab.addGestureRecognizer(friendTabFunc)
        
        let famillyTabFunc = UITapGestureRecognizer(target: self, action: #selector(famillyTabClicked))
        famillyTab.isUserInteractionEnabled = true
        famillyTab.addGestureRecognizer(famillyTabFunc)
        
        let etcTabFunc = UITapGestureRecognizer(target: self, action: #selector(etcTabClicked))
        etcTab.isUserInteractionEnabled = true
        etcTab.addGestureRecognizer(etcTabFunc)
        
    }
    
    @objc func parentTabClicked(){
        
        print("parentTabClicked called")
        friendCD = Constants.PARENT
        parentCheckBtn.isHidden = false
        friendCheckBtn.isHidden = true
        famillyCheckBtn.isHidden = true
        etcCheckBtn.isHidden = true
    }
    
    @objc func friendTabClicked(){
        
        print("friendTabClicked called")
        friendCD = Constants.FRIEND
        parentCheckBtn.isHidden = true
        friendCheckBtn.isHidden = false
        famillyCheckBtn.isHidden = true
        etcCheckBtn.isHidden = true
        
    }
    
    @objc func famillyTabClicked(){
        
        print("famillyTabClicked called")
        friendCD = Constants.FAMILY
        parentCheckBtn.isHidden = true
        friendCheckBtn.isHidden = true
        famillyCheckBtn.isHidden = false
        etcCheckBtn.isHidden = true
    }
    
    @objc func etcTabClicked(){
        
        print("etcTabClicked called")
        friendCD = Constants.ETC
        parentCheckBtn.isHidden = true
        friendCheckBtn.isHidden = true
        famillyCheckBtn.isHidden = true
        etcCheckBtn.isHidden = false
    }
    
    @objc func closeBtnClicked(){
        
        self.dismiss(animated: true, completion: nil)
        
    }

    @IBAction func confirmBtnClicked(_ sender: UIButton) {
        
        let preVC = self.presentingViewController
        
        guard let vc = preVC as? SajuInfoInputViewController else{
            return
        }
        
        vc.setRelation(cd: friendCD)
        self.dismiss(animated: true, completion: nil)
    }
    
}
