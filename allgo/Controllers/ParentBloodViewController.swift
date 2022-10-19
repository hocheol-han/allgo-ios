//
//  ParentBloodViewController.swift
//  allgo
//
//  Created by 한호철 on 2022/07/29.
//

import UIKit

class ParentBloodViewController: UIViewController {
    @IBOutlet var superView: UIView!
    @IBOutlet var closeImg: UIImageView!
    
    @IBOutlet var fAtypeBtn: UIButton!
    @IBOutlet var fBtypeBtn: UIButton!
    @IBOutlet var fOtypeBtn: UIButton!
    @IBOutlet var fABtypeBtn: UIButton!
    
    @IBOutlet var mAtypeBtn: UIButton!
    @IBOutlet var mBtypeBtn: UIButton!
    @IBOutlet var mOtypeBtn: UIButton!
    @IBOutlet var mABtypeBtn: UIButton!
    
    @IBOutlet var resultBtn: UIButton!
    
    var fBloods = Array<UIButton>()
    var mBloods = Array<UIButton>()
    
    var selectedFbPos:Int = -1
    var selectedMbPos:Int = -1
    
    var myBloodType:String = ""
    var fBloodType:String = ""
    var mBloodType:String = ""
    
    var bloodTypes:[String] = ["A","B","O","AB"]
    
    var userInfo: UserInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setInit()
    }
    
    func setInit(){
        
        superView.layer.cornerRadius = 30
        
        userInfo = UserInfo.shared
        myBloodType = userInfo.memberBlood ?? ""
        print("myBloodType : \(myBloodType)")
        
        let closeImgTab = UITapGestureRecognizer(target: self, action: #selector(closeImgClicked))
        closeImg.isUserInteractionEnabled = true
        closeImg.addGestureRecognizer(closeImgTab)
        
        fBloods = [
                    fAtypeBtn,
                    fBtypeBtn,
                    fOtypeBtn,
                    fABtypeBtn
                ]
        
        mBloods = [
                    mAtypeBtn,
                    mBtypeBtn,
                    mOtypeBtn,
                    mABtypeBtn
                ]
        
        var i = 0
        while i < fBloods.count{
            
            fBloods[i].layer.borderWidth = 1
            fBloods[i].layer.borderColor = Constants.BUTTON_GREEN?.cgColor
            fBloods[i].layer.cornerRadius = 15
            
            mBloods[i].layer.borderWidth = 1
            mBloods[i].layer.borderColor = Constants.BUTTON_GREEN?.cgColor
            mBloods[i].layer.cornerRadius = 15
            
            i += 1
            
        }
        
        let selectFATab = AllgoTapGestureRecognizer(target: self, action: #selector(selectFBlood(sender: )))
        fBloods[0].isUserInteractionEnabled = true
        selectFATab.tapGB = 0
        fBloods[0].addGestureRecognizer(selectFATab)
        
        let selectFBTab = AllgoTapGestureRecognizer(target: self, action: #selector(selectFBlood(sender: )))
        fBloods[1].isUserInteractionEnabled = true
        selectFBTab.tapGB = 1
        fBloods[1].addGestureRecognizer(selectFBTab)
        
        let selectFOTab = AllgoTapGestureRecognizer(target: self, action: #selector(selectFBlood(sender: )))
        fBloods[2].isUserInteractionEnabled = true
        selectFOTab.tapGB = 2
        fBloods[2].addGestureRecognizer(selectFOTab)
        
        let selectFABTab = AllgoTapGestureRecognizer(target: self, action: #selector(selectFBlood(sender: )))
        fBloods[3].isUserInteractionEnabled = true
        selectFABTab.tapGB = 3
        fBloods[3].addGestureRecognizer(selectFABTab)
        
        let selectMATab = AllgoTapGestureRecognizer(target: self, action: #selector(selectMBlood(sender: )))
        mBloods[0].isUserInteractionEnabled = true
        selectMATab.tapGB = 0
        mBloods[0].addGestureRecognizer(selectMATab)
        
        let selectMBTab = AllgoTapGestureRecognizer(target: self, action: #selector(selectMBlood(sender: )))
        mBloods[1].isUserInteractionEnabled = true
        selectMBTab.tapGB = 1
        mBloods[1].addGestureRecognizer(selectMBTab)
        
        let selectMOTab = AllgoTapGestureRecognizer(target: self, action: #selector(selectMBlood(sender: )))
        mBloods[2].isUserInteractionEnabled = true
        selectMOTab.tapGB = 2
        mBloods[2].addGestureRecognizer(selectMOTab)
        
        let selectMABTab = AllgoTapGestureRecognizer(target: self, action: #selector(selectMBlood(sender: )))
        mBloods[3].isUserInteractionEnabled = true
        selectMABTab.tapGB = 3
        mBloods[3].addGestureRecognizer(selectMABTab)
        
        
        resultBtn.layer.borderWidth = 1
        resultBtn.layer.borderColor = Constants.GRAY?.cgColor
        resultBtn.layer.cornerRadius = 20
        
    }
    
    @objc func closeImgClicked(){
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func selectFBlood(sender: AllgoTapGestureRecognizer){
        selectedFbPos = sender.tapGB
        fBloodType = bloodTypes[selectedFbPos]
        resetBtn(buttons: fBloods)
        
        fBloods[selectedFbPos].backgroundColor = Constants.BUTTON_GREEN
        fBloods[selectedFbPos].layer.borderWidth = 1
        fBloods[selectedFbPos].layer.borderColor = Constants.BUTTON_GREEN?.cgColor
        
    }
    
    @objc func selectMBlood(sender: AllgoTapGestureRecognizer){
        selectedMbPos = sender.tapGB
        
        if selectedFbPos == -1{
            Util.showToast(message: "아버지 혈액형을 먼저 선택하세요", controller: self)
            return
        }
        mBloodType = bloodTypes[selectedMbPos]
        var isEnable = Util.checkBlood(myBlood: myBloodType, fBlood: fBloodType, mBlood: mBloodType)
        if isEnable == false{
            mBloodType = ""
            Util.showToast(message: "선택 할 수 없는 혈액형 입니다.", controller: self)
            return
        }
        
        resetBtn(buttons: mBloods)
        
        mBloods[selectedMbPos].backgroundColor = Constants.BUTTON_GREEN
        mBloods[selectedMbPos].layer.borderWidth = 1
        mBloods[selectedMbPos].layer.borderColor = Constants.BUTTON_GREEN?.cgColor
        
        
    }
    
    func resetBtn(buttons: Array<UIButton>){
        
        var i:Int = 0
        while i < buttons.count{
            
            buttons[i].backgroundColor = Constants.WHITE
            buttons[i].layer.borderWidth = 1
            buttons[i].layer.borderColor = Constants.BUTTON_GREEN?.cgColor
            i += 1
        }
    }
    @IBAction func seeResult(_ sender: UIButton) {
    
        guard let pvc = self.presentingViewController else { return }
        
        self.dismiss(animated: true) {
            
            let storyboard = UIStoryboard.init(name: "BloodNLove", bundle: nil)

            guard let bloodNLoveVC = storyboard.instantiateViewController(identifier: "bloodNLove") as? BloodNLoveViewController else{ return }
            bloodNLoveVC.fBloodType = self.fBloodType
            bloodNLoveVC.mBloodType = self.mBloodType
            bloodNLoveVC.modalTransitionStyle = .coverVertical
            bloodNLoveVC.modalPresentationStyle = .fullScreen
            pvc.present(bloodNLoveVC, animated: true, completion: nil)
        }
        
    }
}
