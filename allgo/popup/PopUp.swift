//
//  PopUp.swift
//  allgo
//
//  Created by 한호철 on 2022/04/21.
//

import UIKit

class PopUp: UIView {
    
    
    var currentPage: Int = 0
    var images = ["img_coachmark_step_01_ko.png"
                  ,"img_coachmark_step_02_ko.png"
                  ,"img_coachmark_step_03_ko.png"
                  ,"img_coachmark_step_04_ko.png"
                  ,"img_coachmark_step_05_ko.png"
                  ,"img_coachmark_step_06_ko.png"]
    
    var titles = ["무료운세","기분체크","공감하기","통계","운세랭킹"]
    var texts = ["기본 운세는 회원가입 없이 무료 제공해요"
                    ,"오늘 나의 기분을 체크 해 보아요"
                    ,"현재 나와 비슷한 사람들과 공감하기"
                    ,"일별통계,월별통계,연별통계 보기"
                    ,"올해 전체랭킹,연도별랭킹 알아보기"]
    @IBOutlet var closeBtn: UIButton!
    @IBOutlet var nextBtn: UIButton!
    @IBOutlet var skipBtn: UIButton!
    @IBOutlet var completeBtn: UIButton!
    
    @IBOutlet var toturialImag: UIImageView!
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelText: UILabel!
    
    required init?(coder: NSCoder){
        super.init(coder: coder)
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        xibSetup(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
    }
    
    func xibSetup(frame: CGRect){
        let view = loadXib()
        view.frame = frame
        addSubview(view)
    }
    
    func loadXib() -> UIView{
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "Popup",bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        return view!
        
    }
    
    @IBAction func gotoNext(_ sender: Any) {
        
        currentPage = currentPage + 1
        if currentPage <= 4{
            
            var skipBtnTxt: String = "건너뛰기"
            if currentPage == 0{
                skipBtnTxt = "건너뛰기"
            }else{
                skipBtnTxt = "이전"
            }
            skipBtn.setTitle(skipBtnTxt, for: .normal)
            
            labelTitle.text = titles[currentPage]
            labelText.text = texts[currentPage]
            toturialImag.image = UIImage(named: images[currentPage])
            
            
        }else if currentPage == 5{
            
            toturialImag.image = UIImage(named: images[currentPage])
            nextBtn.layer.isHidden = true
            skipBtn.layer.isHidden = true
            completeBtn.layer.isHidden = false
        }
    }
    
//    @IBAction func closePopup(_ sender: Any) {
//        self.dism
//    }
}
