//
//  SajuInfoSavePopViewController.swift
//  allgo
//
//  Created by 한호철 on 2022/07/04.
//

import UIKit

class SajuInfoSavePopViewController: UIViewController {

    var from: String = ""
    var name:String = ""
    @IBOutlet var parentView: UIView!
    @IBOutlet var closeImg: UIImageView!
    @IBOutlet var conentLbl: UILabel!
    
    @IBOutlet var saveBtn: UIButton!
    @IBOutlet var cancelBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setInit()
    }
    
    func setInit(){
        
//        femaleBtn.layer.borderWidth = 1
//        femaleBtn.layer.borderColor = Constants.BUTTON_GREEN?.cgColor
//        femaleBtn.layer.cornerRadius = 15
        
        parentView.layer.cornerRadius = 20
        conentLbl.text = name + "님의 사주정보를 \n저장 하시겠습니까?"
        
        saveBtn.layer.borderWidth = 1
        saveBtn.layer.cornerRadius = 15
        saveBtn.layer.borderColor = Constants.BUTTON_GRAY_BORDER?.cgColor
        saveBtn.backgroundColor = Constants.BUTTON_GRAY
        
        cancelBtn.layer.borderWidth = 1
        cancelBtn.layer.cornerRadius = 15
        cancelBtn.layer.borderColor = Constants.BUTTON_GRAY_BORDER?.cgColor
        cancelBtn.backgroundColor = Constants.WHITE
        
        let closeImgTab = UITapGestureRecognizer(target: self, action: #selector(closeImgClicked))
        closeImg.isUserInteractionEnabled = true
        closeImg.addGestureRecognizer(closeImgTab)
    }
    
    @objc func closeImgClicked(){
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func saveBtnClicked(_ sender: UIButton) {
        
        if from == Constants.JUNGTONG_UNSE_NAME[0]{
            guard let pvc = self.presentingViewController as? TojeongViewController else { return }
            
            self.dismiss(animated: true) {
                pvc.saveFriendInfo()
            }
        }else if from == Constants.JUNGTONG_UNSE_NAME[1]{
            guard let pvc = self.presentingViewController as? SajuViewController else { return }
            
            self.dismiss(animated: true) {
                pvc.saveFriendInfo()
            }
        }else if from == Constants.JUNGTONG_UNSE_NAME[2]{
            guard let pvc = self.presentingViewController as? GunghapViewController else { return }
            
            self.dismiss(animated: true) {
                pvc.saveFriendInfo()
            }
        }else if from == Constants.THEME_UNSE_NAME[4]{//동물점
            guard let pvc = self.presentingViewController as? AnimalViewController else { return }
            
            self.dismiss(animated: true) {
                pvc.saveFriendInfo()
            }
        }else if from  == Constants.THEME_UNSE_NAME[5]{//탄생화점,꽃점
            guard let pvc = self.presentingViewController as? FlowerViewController else { return }
            
            self.dismiss(animated: true) {
                pvc.saveFriendInfo()
            }
        }else if from  == Constants.THEME_UNSE_NAME[6]{//마음사로잡기
            guard let pvc = self.presentingViewController as? CatchMindViewController else { return }
            
            self.dismiss(animated: true) {
                pvc.saveFriendInfo()
            }
        }else if from  == Constants.THEME_UNSE_NAME[8]{//혈액형&별
            guard let pvc = self.presentingViewController as? BloodNStarViewController else { return }
            
            self.dismiss(animated: true) {
                pvc.saveFriendInfo()
            }
        }else if from  == Constants.THEME_UNSE_NAME[9]{//별 이야기
            guard let pvc = self.presentingViewController as? StarStoryViewController else { return }
            
            self.dismiss(animated: true) {
                pvc.saveFriendInfo()
            }
        }else if from  == Constants.THEME_UNSE_NAME[10]{//별자리 띠성격
            guard let pvc = self.presentingViewController as? StarNDdiViewController else { return }
            
            self.dismiss(animated: true) {
                pvc.saveFriendInfo()
            }
        }
    }
    @IBAction func cancelBtnClicked(_ sender: UIButton) {
        guard let pvc = self.presentingViewController else { return }
        
        self.dismiss(animated: true) {
            
            pvc.dismiss(animated: true, completion: nil)
        }
    }
    
}
