//
//  SajuInfoInputViewController.swift
//  allgo
//
//  Created by 한호철 on 2022/06/27.
//

import UIKit
import Alamofire
import SwiftyJSON

class SajuInfoInputViewController: UIViewController {

    var sexGB: String = Constants.MALE
    var bloodType: String = Constants.BLOOD_TYPE_A
    var birthGB: String = Constants.SOLAR
    var friendCD: String = Constants.PARENT
    
    var birthYear: String = ""
    var birthMonth: String = ""
    var birthDay: String = ""
    var birthTime: String = "0"
    
    var userInfo: UserInfo!
    
    
    @IBOutlet var nameTF: UITextField!
    @IBOutlet var maleBtn: UIButton!
    @IBOutlet var femaleBtn: UIButton!
    
    @IBOutlet var bloodABtn: UIButton!
    @IBOutlet var bloodBBtn: UIButton!
    @IBOutlet var bloodOBtn: UIButton!
    @IBOutlet var bloodABBtn: UIButton!
    
    @IBOutlet var birthGBSBtn: UIButton!
    @IBOutlet var birthGBLBtn: UIButton!
    @IBOutlet var birthGBYBtn: UIButton!
    
    @IBOutlet var datePickerBtn: UILabel!
    @IBOutlet var relationBtn: UILabel!
    @IBOutlet var sangsiBtn: UILabel!
    
    @IBOutlet var confirmBtn: UIButton!
    @IBOutlet var cancelBtn: UIButton!
    
    var content: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setInit()
    }
    
    func setInit(){
        
        userInfo    = UserInfo.shared
        
        maleBtn.backgroundColor = Constants.BUTTON_GREEN
        maleBtn.layer.borderWidth = 1
        maleBtn.layer.borderColor = Constants.BUTTON_GREEN?.cgColor
        maleBtn.layer.cornerRadius = 15
        
//        maleBtn.setTitleColor(Constants.GRAY, for: .normal)
        
        femaleBtn.backgroundColor = Constants.WHITE
        femaleBtn.layer.borderWidth = 1
        femaleBtn.layer.borderColor = Constants.BUTTON_GREEN?.cgColor
        femaleBtn.layer.cornerRadius = 15
        
        bloodABtn.backgroundColor = Constants.BUTTON_GREEN
        bloodABtn.layer.borderWidth = 1
        bloodABtn.layer.borderColor = Constants.BUTTON_GREEN?.cgColor
        bloodABtn.layer.cornerRadius = 12
        
        bloodBBtn.backgroundColor = Constants.WHITE
        bloodBBtn.layer.borderWidth = 1
        bloodBBtn.layer.borderColor = Constants.BUTTON_GREEN?.cgColor
        bloodBBtn.layer.cornerRadius = 12
        
        bloodOBtn.backgroundColor = Constants.WHITE
        bloodOBtn.layer.borderWidth = 1
        bloodOBtn.layer.borderColor = Constants.BUTTON_GREEN?.cgColor
        bloodOBtn.layer.cornerRadius = 12
        
        bloodABBtn.backgroundColor = Constants.WHITE
        bloodABBtn.layer.borderWidth = 1
        bloodABBtn.layer.borderColor = Constants.BUTTON_GREEN?.cgColor
        bloodABBtn.layer.cornerRadius = 12
        
        birthGBSBtn.backgroundColor = Constants.BUTTON_GREEN
        birthGBSBtn.layer.borderWidth = 1
        birthGBSBtn.layer.borderColor = Constants.BUTTON_GREEN?.cgColor
        birthGBSBtn.layer.cornerRadius = 15
        
        birthGBLBtn.backgroundColor = Constants.WHITE
        birthGBLBtn.layer.borderWidth = 1
        birthGBLBtn.layer.borderColor = Constants.BUTTON_GREEN?.cgColor
        birthGBLBtn.layer.cornerRadius = 15
        
        birthGBYBtn.backgroundColor = Constants.WHITE
        birthGBYBtn.layer.borderWidth = 1
        birthGBYBtn.layer.borderColor = Constants.BUTTON_GREEN?.cgColor
        birthGBYBtn.layer.cornerRadius = 15
        
        confirmBtn.backgroundColor = Constants.GRAY
        confirmBtn.layer.borderWidth = 1
        confirmBtn.layer.borderColor = Constants.BUTTON_GRAY_BORDER?.cgColor
        confirmBtn.layer.cornerRadius = 15
        
        cancelBtn.backgroundColor = Constants.WHITE
        cancelBtn.layer.borderWidth = 1
        cancelBtn.layer.borderColor = Constants.BUTTON_GRAY_BORDER?.cgColor
        cancelBtn.layer.cornerRadius = 15
        
        let datePickerTab = UITapGestureRecognizer(target: self, action: #selector(datePickerBtnClicked))
        datePickerBtn.isUserInteractionEnabled = true
        datePickerBtn.addGestureRecognizer(datePickerTab)
        
        let relationTab = UITapGestureRecognizer(target: self, action: #selector(relationBtnClicked))
        relationBtn.isUserInteractionEnabled = true
        relationBtn.addGestureRecognizer(relationTab)
        
        let sangsiTab = UITapGestureRecognizer(target: self, action: #selector(sangsiBtnClicked))
        sangsiBtn.isUserInteractionEnabled = true
        sangsiBtn.addGestureRecognizer(sangsiTab)
        
    }
    
    
    
    @IBAction func maleBtnClicked(_ sender: UIButton) {
        sexGB = Constants.MALE
        maleBtn.backgroundColor = Constants.BUTTON_GREEN
        femaleBtn.backgroundColor = Constants.WHITE
    }
    
    
    @IBAction func femaleBtnClicked(_ sender: UIButton) {
        sexGB = Constants.FEMALE
        maleBtn.backgroundColor = Constants.WHITE
        femaleBtn.backgroundColor = Constants.BUTTON_GREEN
    }
    
    @IBAction func aBtnClicked(_ sender: UIButton) {
        
        bloodType = "A"
        
        bloodABtn.backgroundColor = Constants.BUTTON_GREEN
        bloodBBtn.backgroundColor = Constants.WHITE
        bloodOBtn.backgroundColor = Constants.WHITE
        bloodABBtn.backgroundColor = Constants.WHITE

    }
    
    @IBAction func bBtnClicked(_ sender: UIButton) {
        
        bloodType = "B"
        
        bloodABtn.backgroundColor = Constants.WHITE
        bloodBBtn.backgroundColor = Constants.BUTTON_GREEN
        bloodOBtn.backgroundColor = Constants.WHITE
        bloodABBtn.backgroundColor = Constants.WHITE
        
    }
    
    @IBAction func oBtnClicked(_ sender: UIButton) {
        
        bloodType = "O"
        bloodABtn.backgroundColor = Constants.WHITE
        bloodBBtn.backgroundColor = Constants.WHITE
        bloodOBtn.backgroundColor = Constants.BUTTON_GREEN
        bloodABBtn.backgroundColor = Constants.WHITE
        
    }
    
    @IBAction func abBtnClicked(_ sender: UIButton) {
        
        bloodType = "AB"
        bloodABtn.backgroundColor = Constants.WHITE
        bloodBBtn.backgroundColor = Constants.WHITE
        bloodOBtn.backgroundColor = Constants.WHITE
        bloodABBtn.backgroundColor = Constants.BUTTON_GREEN
        
    }

    @IBAction func birthGBSBtnClicked(_ sender: UIButton) {
        birthGB = Constants.SOLAR
        
        birthGBSBtn.backgroundColor = Constants.BUTTON_GREEN
        birthGBLBtn.backgroundColor = Constants.WHITE
        birthGBYBtn.backgroundColor = Constants.WHITE
        
    }
    
    @IBAction func birthGBLBtnClicked(_ sender: UIButton) {
        birthGB = Constants.LUNAR
        
        birthGBSBtn.backgroundColor = Constants.WHITE
        birthGBLBtn.backgroundColor = Constants.BUTTON_GREEN
        birthGBYBtn.backgroundColor = Constants.WHITE
        
    }
    
    @IBAction func birthGBYBtnClicked(_ sender: UIButton) {
        birthGB = Constants.YUN
        
        birthGBSBtn.backgroundColor = Constants.WHITE
        birthGBLBtn.backgroundColor = Constants.WHITE
        birthGBYBtn.backgroundColor = Constants.BUTTON_GREEN
        
    }
    
    @objc func datePickerBtnClicked(){
        
        print("datePickerBtnClicked ~! called")
        let storyboard = UIStoryboard.init(name: "DatePickerPop", bundle: nil)
        let datePickerPop = storyboard.instantiateViewController(identifier: "datePickerPop")
        datePickerPop.modalTransitionStyle = .coverVertical
        datePickerPop.modalPresentationStyle = .overCurrentContext
        
        self.present(datePickerPop,animated: true,completion: nil)
        
    }
    
    @objc func relationBtnClicked(){
        
        let storyboard = UIStoryboard.init(name: "RelationPop", bundle: nil)
        let relationPop = storyboard.instantiateViewController(identifier: "relationPop")
        relationPop.modalTransitionStyle = .coverVertical
        relationPop.modalPresentationStyle = .overCurrentContext
        
        self.present(relationPop,animated: true,completion: nil)
    }
    
    @objc func sangsiBtnClicked(){
        
        let storyboard = UIStoryboard.init(name: "SangsiPop", bundle: nil)
        let sangsiPop = storyboard.instantiateViewController(identifier: "sangsiPop")
        sangsiPop.modalTransitionStyle = .coverVertical
        sangsiPop.modalPresentationStyle = .overCurrentContext
        
        self.present(sangsiPop,animated: true,completion: nil)
    }
    
    func setBirthDate(year: String,month: String,day: String){
        birthYear = year
        birthMonth = month
        birthDay = day
        
        print("date : \(birthYear)\(birthMonth)\(birthDay)")
        
        datePickerBtn.text = birthYear + "\\" + birthMonth + "\\" + birthDay
    }
    
    func setSangsi(sangsi: String,index: Int){
        
        sangsiBtn.text = sangsi
        birthTime = String(index)
        print("birthTime : \(birthTime)")
        
    }
    
    func setRelation(cd: String){
        print("setRelation ~!!! : \(cd)")
        
        friendCD = cd
        
        if cd == Constants.FRIEND{
            relationBtn.text = "친구"
        }else if cd == Constants.FAMILY{
            relationBtn.text = "가족"
        }else if cd == Constants.PARENT{
            relationBtn.text = "부모님"
        }else if cd == Constants.ETC{
            relationBtn.text = "기타"
        }
    }
    
    @IBAction func confirmBtnClicked(_ sender: UIButton) {
        let name = nameTF.text ?? ""
        if name == "" {
            Util.showToast(message: "이름을 입력해 주세요", controller: self)
            return
        }
        
        if birthYear == "" || birthMonth == "" || birthDay == "" {
            Util.showToast(message: "생년월일을 입력해 주세요", controller: self)
            return
        }
        
        
        guard let pvc = self.presentingViewController else { return }

        if self.content == "ADD_NEW_INFO"{

            let birthYMD = self.birthYear + self.birthMonth + self.birthDay
            
            let param : [String: String] = [
                "member_id" : userInfo.memberId ?? "",
                "friend_name" : name,
                "friend_sex_gb" : self.sexGB,
                "friend_cd" : self.friendCD,
                "friend_birth_gb" : self.birthGB,
                "friend_birth_ymd" : birthYMD,
                "friend_birth_time" : self.birthTime,
                "friend_blood_type" : self.bloodType,
                "friend_id" : ""
            ]
                
                let url = Constants.urlPrefix + "/friend/insert"
                
                AF.request(url,
                           method: .post,
                           parameters: param,
                           encoding: JSONEncoding.default,
                           headers: ["Content-Type":"application/json", "Accept":"application/json"])
        //                    .validate(statusCode: 200..<300)
                    .responseJSON { (response) in
                        //여기서 가져온 데이터를 자유롭게 활용하세요.
                        print("saveFriendInfo result : \(response.result)")

                        switch response.result{

                        case .success(let value):
                            let json = JSON(value)
                            print(json["error_number"].stringValue)
                            let errorNumber = json["error_number"].stringValue

                            if errorNumber == Constants.SEARCH_OK{

                                Util.showToast(message: "저장 되었습니다.", controller: self)
                                
                            }
                        default:
                            return


                        }
                    }
                self.dismiss(animated: true, completion: nil)
            
        }else{
        
            self.dismiss(animated: true) {
                
                if self.content == Constants.JUNGTONG_UNSE_NAME[0] { //토정비결
                    let storyboard = UIStoryboard.init(name: "Tojeong", bundle: nil)
                    guard let tojeongVC = storyboard.instantiateViewController(identifier: "tojeong") as? TojeongViewController else{ return }
                    tojeongVC.modalTransitionStyle = .coverVertical
                    tojeongVC.modalPresentationStyle = .fullScreen
                    
                    let birthYMD = self.birthYear + self.birthMonth + self.birthDay
                    
                    tojeongVC.from = "NEW"
                    tojeongVC.friend_name = name
                    tojeongVC.friend_sex_gb = self.sexGB
                    tojeongVC.friend_cd = self.friendCD
                    tojeongVC.friend_birth_gb = self.birthGB
                    tojeongVC.friend_birth_ymd = birthYMD
                    tojeongVC.friend_birth_year = self.birthYear
                    tojeongVC.friend_birth_month = self.birthMonth
                    tojeongVC.friend_birth_day = self.birthDay
                    tojeongVC.friend_birth_time = self.birthTime
                    tojeongVC.friend_blood_type = self.bloodType
                    
                    pvc.present(tojeongVC, animated: true, completion: nil)
                    
                }else if self.content == Constants.JUNGTONG_UNSE_NAME[1] {//사주
                    let storyboard = UIStoryboard.init(name: "Saju", bundle: nil)
                    guard let sajuVC = storyboard.instantiateViewController(identifier: "saju") as? SajuViewController else{ return }
                    sajuVC.modalTransitionStyle = .coverVertical
                    sajuVC.modalPresentationStyle = .fullScreen
                    
                    let birthYMD = self.birthYear + self.birthMonth + self.birthDay
                    
                    sajuVC.from = "NEW"
                    sajuVC.friend_name = name
                    sajuVC.friend_sex_gb = self.sexGB
                    sajuVC.friend_cd = self.friendCD
                    sajuVC.friend_birth_gb = self.birthGB
                    sajuVC.friend_birth_ymd = birthYMD
                    sajuVC.friend_birth_year = self.birthYear
                    sajuVC.friend_birth_month = self.birthMonth
                    sajuVC.friend_birth_day = self.birthDay
                    sajuVC.friend_birth_time = self.birthTime
                    sajuVC.friend_blood_type = self.bloodType
                    
                    pvc.present(sajuVC, animated: true, completion: nil)
                
                }else if self.content == Constants.JUNGTONG_UNSE_NAME[2]{ //궁합일 경우
                    
                    let storyboard = UIStoryboard.init(name: "Gunghap", bundle: nil)
                    guard let gunghapVC = storyboard.instantiateViewController(identifier: "gunghap") as? GunghapViewController else{ return }
                    gunghapVC.modalTransitionStyle = .coverVertical
                    gunghapVC.modalPresentationStyle = .fullScreen
                    
                    let birthYMD = self.birthYear + self.birthMonth + self.birthDay
                    
                    gunghapVC.from = "NEW"
                    gunghapVC.friend_name = name
                    gunghapVC.friend_sex_gb = self.sexGB
                    gunghapVC.friend_cd = self.friendCD
                    gunghapVC.friend_birth_gb = self.birthGB
                    gunghapVC.friend_birth_ymd = birthYMD
                    gunghapVC.friend_birth_year = self.birthYear
                    gunghapVC.friend_birth_month = self.birthMonth
                    gunghapVC.friend_birth_day = self.birthDay
                    gunghapVC.friend_birth_time = self.birthTime
                    gunghapVC.friend_blood_type = self.bloodType
                    
                    pvc.present(gunghapVC, animated: true, completion: nil)
                    
                }else if self.content == Constants.THEME_UNSE_NAME[4]{
                    
                    let storyboard = UIStoryboard.init(name: "Animal", bundle: nil)
                    guard let animalVC = storyboard.instantiateViewController(identifier: "animal") as? AnimalViewController else{ return }
                    animalVC.modalTransitionStyle = .coverVertical
                    animalVC.modalPresentationStyle = .fullScreen
                    
                    let birthYMD = self.birthYear + self.birthMonth + self.birthDay
                    
                    animalVC.from = "NEW"
                    animalVC.friend_name = name
                    animalVC.friend_sex_gb = self.sexGB
                    animalVC.friend_cd = self.friendCD
                    animalVC.friend_birth_gb = self.birthGB
                    animalVC.friend_birth_ymd = birthYMD
                    animalVC.friend_birth_year = self.birthYear
                    animalVC.friend_birth_month = self.birthMonth
                    animalVC.friend_birth_day = self.birthDay
                    animalVC.friend_birth_time = self.birthTime
                    animalVC.friend_blood_type = self.bloodType
                    
                    pvc.present(animalVC, animated: true, completion: nil)
                    
                }else if self.content == Constants.THEME_UNSE_NAME[5]{
                    
                    let storyboard = UIStoryboard.init(name: "Flower", bundle: nil)
                    guard let flowerVC = storyboard.instantiateViewController(identifier: "flower") as? FlowerViewController else{ return }
                    flowerVC.modalTransitionStyle = .coverVertical
                    flowerVC.modalPresentationStyle = .fullScreen
                    
                    let birthYMD = self.birthYear + self.birthMonth + self.birthDay
                    
                    flowerVC.from = "NEW"
                    flowerVC.friend_name = name
                    flowerVC.friend_sex_gb = self.sexGB
                    flowerVC.friend_cd = self.friendCD
                    flowerVC.friend_birth_gb = self.birthGB
                    flowerVC.friend_birth_ymd = birthYMD
                    flowerVC.friend_birth_year = self.birthYear
                    flowerVC.friend_birth_month = self.birthMonth
                    flowerVC.friend_birth_day = self.birthDay
                    flowerVC.friend_birth_time = self.birthTime
                    flowerVC.friend_blood_type = self.bloodType
                    
                    pvc.present(flowerVC, animated: true, completion: nil)
                    
                }else if self.content == Constants.THEME_UNSE_NAME[6]{
                    
                    let storyboard = UIStoryboard.init(name: "CatchMind", bundle: nil)
                    guard let catchMindVC = storyboard.instantiateViewController(identifier: "catchMind") as? CatchMindViewController else{ return }
                    catchMindVC.modalTransitionStyle = .coverVertical
                    catchMindVC.modalPresentationStyle = .fullScreen
                    
                    let birthYMD = self.birthYear + self.birthMonth + self.birthDay
                    
                    catchMindVC.from = "NEW"
                    catchMindVC.friend_name = name
                    catchMindVC.friend_sex_gb = self.sexGB
                    catchMindVC.friend_cd = self.friendCD
                    catchMindVC.friend_birth_gb = self.birthGB
                    catchMindVC.friend_birth_ymd = birthYMD
                    catchMindVC.friend_birth_year = self.birthYear
                    catchMindVC.friend_birth_month = self.birthMonth
                    catchMindVC.friend_birth_day = self.birthDay
                    catchMindVC.friend_birth_time = self.birthTime
                    catchMindVC.friend_blood_type = self.bloodType
                    
                    pvc.present(catchMindVC, animated: true, completion: nil)
                    
                }else if self.content == Constants.THEME_UNSE_NAME[8]{
                    
                    let storyboard = UIStoryboard.init(name: "BloodNStar", bundle: nil)
                    guard let bloodNStarVC = storyboard.instantiateViewController(identifier: "bloodNStar") as? BloodNStarViewController else{ return }
                    bloodNStarVC.modalTransitionStyle = .coverVertical
                    bloodNStarVC.modalPresentationStyle = .fullScreen
                    
                    let birthYMD = self.birthYear + self.birthMonth + self.birthDay
                    
                    bloodNStarVC.from = "NEW"
                    bloodNStarVC.friend_name = name
                    bloodNStarVC.friend_sex_gb = self.sexGB
                    bloodNStarVC.friend_cd = self.friendCD
                    bloodNStarVC.friend_birth_gb = self.birthGB
                    bloodNStarVC.friend_birth_ymd = birthYMD
                    bloodNStarVC.friend_birth_year = self.birthYear
                    bloodNStarVC.friend_birth_month = self.birthMonth
                    bloodNStarVC.friend_birth_day = self.birthDay
                    bloodNStarVC.friend_birth_time = self.birthTime
                    bloodNStarVC.friend_blood_type = self.bloodType
                    
                    pvc.present(bloodNStarVC, animated: true, completion: nil)
                    
                }else if self.content == Constants.THEME_UNSE_NAME[9]{
                    
                    let storyboard = UIStoryboard.init(name: "StarStory", bundle: nil)
                    guard let starStoryVC = storyboard.instantiateViewController(identifier: "starStory") as? StarStoryViewController else{ return }
                    starStoryVC.modalTransitionStyle = .coverVertical
                    starStoryVC.modalPresentationStyle = .fullScreen
                    
                    let birthYMD = self.birthYear + self.birthMonth + self.birthDay
                    
                    starStoryVC.from = "NEW"
                    starStoryVC.friend_name = name
                    starStoryVC.friend_sex_gb = self.sexGB
                    starStoryVC.friend_cd = self.friendCD
                    starStoryVC.friend_birth_gb = self.birthGB
                    starStoryVC.friend_birth_ymd = birthYMD
                    starStoryVC.friend_birth_year = self.birthYear
                    starStoryVC.friend_birth_month = self.birthMonth
                    starStoryVC.friend_birth_day = self.birthDay
                    starStoryVC.friend_birth_time = self.birthTime
                    starStoryVC.friend_blood_type = self.bloodType
                    
                    pvc.present(starStoryVC, animated: true, completion: nil)
                    
                }else if self.content == Constants.THEME_UNSE_NAME[10]{
                    
                    let storyboard = UIStoryboard.init(name: "StarNDdi", bundle: nil)
                    guard let starNDdiVC = storyboard.instantiateViewController(identifier: "starNDdi") as? StarNDdiViewController else{ return }
                    starNDdiVC.modalTransitionStyle = .coverVertical
                    starNDdiVC.modalPresentationStyle = .fullScreen
                    
                    let birthYMD = self.birthYear + self.birthMonth + self.birthDay
                    
                    starNDdiVC.from = "NEW"
                    starNDdiVC.friend_name = name
                    starNDdiVC.friend_sex_gb = self.sexGB
                    starNDdiVC.friend_cd = self.friendCD
                    starNDdiVC.friend_birth_gb = self.birthGB
                    starNDdiVC.friend_birth_ymd = birthYMD
                    starNDdiVC.friend_birth_year = self.birthYear
                    starNDdiVC.friend_birth_month = self.birthMonth
                    starNDdiVC.friend_birth_day = self.birthDay
                    starNDdiVC.friend_birth_time = self.birthTime
                    starNDdiVC.friend_blood_type = self.bloodType
                    
                    pvc.present(starNDdiVC, animated: true, completion: nil)
                    
                }
            }
        }
    }
    
    @IBAction func closeBtnClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelBtnClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
