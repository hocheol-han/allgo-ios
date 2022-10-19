//
//  UnseViewController.swift
//  allgo
//
//  Created by 한호철 on 2022/06/15.
//

import UIKit

class UnseViewController: UIViewController {

    @IBOutlet var preBtn: UIButton!
    @IBOutlet var nextBtn: UIButton!
    @IBOutlet var contentImage: UIImageView!
    @IBOutlet var unseName: UILabel!
    
    @IBOutlet var jeongtongLbl: UILabel!
    @IBOutlet var themeLbl: UILabel!
    @IBOutlet var jeongtongLineImg: UIImageView!
    @IBOutlet var themeLineImg: UIImageView!
    
    
    var underLines = Array<UIImageView>()
    var curTap: Int = 0
    
    var curPosition: Int = 0
    var themeCurPosition: Int = 0
    
    @IBOutlet var menuBtn: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInit()
    }
    
    func setInit(){
        
        underLines = [
                        jeongtongLineImg,
                        themeLineImg
                        ]
        Util.setAllUnderLinesHidden(underLines: underLines)
        underLines[0].isHidden = false
        
        if curPosition == 0{
            preBtn.isHidden = true
        }
        
        let menuBtnTap = UITapGestureRecognizer(target: self, action: #selector(menuBtnClicked))
        menuBtn.isUserInteractionEnabled = true
        menuBtn.addGestureRecognizer(menuBtnTap)
        
        let jeongtongTap = AllgoTapGestureRecognizer(target: self, action: #selector(tapClicked))
        jeongtongLbl.isUserInteractionEnabled = true
        jeongtongTap.tapGB = 0
        jeongtongLbl.addGestureRecognizer(jeongtongTap)
        
        let themeTap = AllgoTapGestureRecognizer(target: self, action: #selector(tapClicked))
        themeLbl.isUserInteractionEnabled = true
        themeTap.tapGB = 1
        themeLbl.addGestureRecognizer(themeTap)
        
        
        let contentBtnTap = UITapGestureRecognizer(target: self, action: #selector(contentBtnClicked))
        contentImage.isUserInteractionEnabled = true
        contentImage.addGestureRecognizer(contentBtnTap)
        
    }
    
    @objc func menuBtnClicked(){
        print("menuBtnClicked() called~!")
    
        self.hero.modalAnimationType = .selectBy(presenting: .pull(direction: .left), dismissing: .slide(direction: .right))
        self.dismiss(animated: true,completion: nil)
        
        
    }
    
    @objc func tapClicked(sender: AllgoTapGestureRecognizer){
        print("aaaaa")
        Util.setAllUnderLinesHidden(underLines: underLines)
        curTap = sender.tapGB
        underLines[curTap].isHidden = false
        preBtn.isHidden = true
        nextBtn.isHidden = false
        
        if curTap == 0{
            
            curPosition = 0

            contentImage.image = UIImage(named: Constants.JUNGTONG_UNSE[curPosition])
            unseName.text = Constants.JUNGTONG_UNSE_NAME[curPosition]
            
            
        }else if curTap == 1{
            
            themeCurPosition = 0
            
            contentImage.image = UIImage(named: Constants.THEME_UNSE[themeCurPosition])
            unseName.text = Constants.THEME_UNSE_NAME[themeCurPosition]
        }
    }
    
    @objc func contentBtnClicked(){
        print("contentBtnClicked() called~!")
        
        if curTap == 0{//정통운세
            print("curPosition : \(curPosition)")
            if curPosition != 2{//궁합이 아닐때
        
                let storyboard = UIStoryboard.init(name: "SajuInfoPop", bundle: nil)
                guard let sajuInfo = storyboard.instantiateViewController(identifier: "sajuInfoPop") as? SajuInfoPopViewController else{ return }


                sajuInfo.content = Constants.JUNGTONG_UNSE_NAME[curPosition]
                print("sajuInfo.content : \(sajuInfo.content)")

                sajuInfo.modalTransitionStyle = .coverVertical
                sajuInfo.modalPresentationStyle = .overCurrentContext

                self.present(sajuInfo,animated: true,completion: nil)
                
            }else{//궁합일때
                
                let storyboard = UIStoryboard.init(name: "SajuInfoInput", bundle: nil)
                guard let sajuInfoInput = storyboard.instantiateViewController(identifier: "sajuInfoInput") as? SajuInfoInputViewController else{ return }


                sajuInfoInput.content = Constants.JUNGTONG_UNSE_NAME[curPosition]
                print("sajuInfoInput.content : \(sajuInfoInput.content)")

                sajuInfoInput.modalTransitionStyle = .coverVertical
                sajuInfoInput.modalPresentationStyle = .overCurrentContext

                self.present(sajuInfoInput,animated: true,completion: nil)
                
            }
        }else if curTap == 1{
            
            if themeCurPosition == 0{//포춘쿠키
                
            }else if themeCurPosition == 1{//타로
                
                let storyboard = UIStoryboard.init(name: "ThemeTaro", bundle: nil)
                guard let themeTaroVC = storyboard.instantiateViewController(identifier: "themeTaro") as? ThemeTaroViewController else{ return }

                themeTaroVC.modalTransitionStyle = .coverVertical
                themeTaroVC.modalPresentationStyle = .fullScreen

                self.present(themeTaroVC,animated: true,completion: nil)
                
            }else if themeCurPosition == 2{//꿈해몽
                
            }else if themeCurPosition == 3{//작명/이름풀이
                
            }else if themeCurPosition == 7{//혈액형,연애
                
                let storyboard = UIStoryboard.init(name: "ParentBlood", bundle: nil)
                guard let parentBloodVC = storyboard.instantiateViewController(identifier: "parentBlood") as? ParentBloodViewController else{ return }

                parentBloodVC.modalTransitionStyle = .coverVertical
                parentBloodVC.modalPresentationStyle = .overCurrentContext

                self.present(parentBloodVC,animated: true,completion: nil)
                
            }else{
                
                let storyboard = UIStoryboard.init(name: "SajuInfoPop", bundle: nil)
                guard let sajuInfoPop = storyboard.instantiateViewController(identifier: "sajuInfoPop") as? SajuInfoPopViewController else{ return }


                sajuInfoPop.content = Constants.THEME_UNSE_NAME[themeCurPosition]
                print("sajuInfoPop.content : \(sajuInfoPop.content)")

                sajuInfoPop.modalTransitionStyle = .coverVertical
                sajuInfoPop.modalPresentationStyle = .overCurrentContext

                self.present(sajuInfoPop,animated: true,completion: nil)
                
            }
            
        }
    }

    @IBAction func nextBtnClicked(_ sender: UIButton) {
    
        print("nextBtnClicked curPosition : \(curPosition)")
        
        if curTap == 0{
        
            if curPosition < 2 {
                curPosition = curPosition + 1

                if curPosition > 0 {
                    preBtn.isHidden = false
                }

                if curPosition == 2{
                    nextBtn.isHidden = true
                }
            }
            
            print("curPosition : \(curPosition)")

            let fadeAnim:CABasicAnimation = CABasicAnimation(keyPath: "contents")

            fadeAnim.fromValue = UIImage(named: Constants.JUNGTONG_UNSE[curPosition-1])
            fadeAnim.toValue   = UIImage(named: Constants.JUNGTONG_UNSE[curPosition])
            fadeAnim.duration  = 0.8;         //smoothest value

            contentImage.layer.add(fadeAnim, forKey: "contents");
            contentImage.image = UIImage(named: Constants.JUNGTONG_UNSE[curPosition])
            unseName.text = Constants.JUNGTONG_UNSE_NAME[curPosition]
            
        }else if curTap == 1{
            
            if themeCurPosition < 10 {
                themeCurPosition = themeCurPosition + 1

                if themeCurPosition > 0 {
                    preBtn.isHidden = false
                }

                if themeCurPosition == 10{
                    nextBtn.isHidden = true
                }
            }
            
            print("themeCurPositon : \(themeCurPosition)")

            let fadeAnim:CABasicAnimation = CABasicAnimation(keyPath: "contents")
                                                                 
            fadeAnim.fromValue = UIImage(named: Constants.THEME_UNSE[themeCurPosition-1])
            fadeAnim.toValue   = UIImage(named: Constants.THEME_UNSE[themeCurPosition])
            fadeAnim.duration  = 0.8;         //smoothest value

            contentImage.layer.add(fadeAnim, forKey: "contents");
            contentImage.image = UIImage(named: Constants.THEME_UNSE[themeCurPosition])
            unseName.text = Constants.THEME_UNSE_NAME[themeCurPosition]
        }
    }
    
    @IBAction func preBtnClicked(_ sender: UIButton) {
    
        print("preBtnClicked curPosition : \(curPosition)")
        
        if curTap == 0{
            if curPosition > 0 {
                        
                curPosition = (curPosition - 1)
                        
                if curPosition < 2 {
                    nextBtn.isHidden = false
                }
                if curPosition == 0 {
                    preBtn.isHidden = true
                }
            }
            
            
            let fadeAnim:CABasicAnimation = CABasicAnimation(keyPath: "contents")
            
            fadeAnim.fromValue = UIImage(named: Constants.JUNGTONG_UNSE[curPosition+1])
            fadeAnim.toValue   = UIImage(named: Constants.JUNGTONG_UNSE[curPosition])
            fadeAnim.duration  = 0.8;         //smoothest value
            
            contentImage.layer.add(fadeAnim, forKey: "contents");
            contentImage.image = UIImage(named: Constants.JUNGTONG_UNSE[curPosition])
            unseName.text = Constants.JUNGTONG_UNSE_NAME[curPosition]
        }else if curTap == 1{
            if themeCurPosition > 0 {
                        
                themeCurPosition = (themeCurPosition - 1)
                        
                if themeCurPosition < 9 {
                    nextBtn.isHidden = false
                }
                if themeCurPosition == 0 {
                    preBtn.isHidden = true
                }
            }
            
            
            let fadeAnim:CABasicAnimation = CABasicAnimation(keyPath: "contents")
            
            fadeAnim.fromValue = UIImage(named: Constants.THEME_UNSE[themeCurPosition+1])
            fadeAnim.toValue   = UIImage(named: Constants.THEME_UNSE[themeCurPosition])
            fadeAnim.duration  = 0.8;         //smoothest value
            
            contentImage.layer.add(fadeAnim, forKey: "contents");
            contentImage.image = UIImage(named: Constants.THEME_UNSE[themeCurPosition])
            unseName.text = Constants.THEME_UNSE_NAME[themeCurPosition]
        }
        
        
    }

}
