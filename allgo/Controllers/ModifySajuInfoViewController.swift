//
//  ModifySajuInfoViewController.swift
//  allgo
//
//  Created by 한호철 on 2022/08/09.
//

import UIKit
import Alamofire
import SwiftyJSON

class ModifySajuInfoViewController: UIViewController {
    
    var name: String = ""
    var sex: String = ""
    var bloodType: String = ""
    var birthGb: String = ""
    var birthYMD: String = ""
    var birthTime: String = ""
    var friendCd: String = ""
    var friendId: String = ""
    
    var userInfo: UserInfo!
    
    var birthYear: String = ""
    var birthMonth: String = ""
    var birthDay: String = ""
    
    @IBOutlet var nameTF: UITextField!
    
    var sajuInfo: Dictionary<String,String>!
    
    @IBOutlet var closeImg: UIImageView!
    
    @IBOutlet var maleLbl: UILabel!
    @IBOutlet var feMaleLbl: UILabel!
    var sexs: Array<UILabel> = Array<UILabel>()
    
    @IBOutlet var typeALbl: UILabel!
    @IBOutlet var typeBLbl: UILabel!
    @IBOutlet var typeOLbl: UILabel!
    @IBOutlet var typeABLbl: UILabel!
    var bloodTypes: Array<UILabel> = Array<UILabel>()
    
    @IBOutlet var birthTypeS: UILabel!
    @IBOutlet var birthTypeL: UILabel!
    @IBOutlet var birthTypeLY: UILabel!
    var birthTypes: Array<UILabel> = Array<UILabel>()
    
    @IBOutlet var birthYMDLbl: UILabel!
    
    @IBOutlet var birthTimeLbl: UILabel!
    
    @IBOutlet var relationTitleLbl: UILabel!
    @IBOutlet var relationLbl: UILabel!
    @IBOutlet var relationUnderLineImg: UIImageView!
    
    @IBOutlet var confrimBtn: UIButton!
    @IBOutlet var cancelBtn: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setInit()
    }
    
    
    func setInit(){
        
//        print("birth_time_name :  \(sajuInfo["birth_time_name"])")
        print("blood : \(sajuInfo["friend_blood"])")
        print("sex : \(sajuInfo["friend_sex_gb"])")
        
        userInfo = UserInfo.shared
        
        let closeImgTab = UITapGestureRecognizer(target: self, action: #selector(closeImgClicked))
        closeImg.isUserInteractionEnabled = true
        closeImg.addGestureRecognizer(closeImgTab)
        
        sexs = [
                    maleLbl,
                    feMaleLbl
                ]
        setLblsToBtns(btns: sexs)
        
        bloodTypes = [
                            typeALbl,
                            typeBLbl,
                            typeOLbl,
                            typeABLbl
                    ]
        setLblsToBtns(btns: bloodTypes)

        birthTypes = [
                        birthTypeS,
                        birthTypeL,
                        birthTypeLY
                    ]
        setLblsToBtns(btns: birthTypes)
        
        setBtn(btn: confrimBtn)
        setBtn(btn: cancelBtn)
        
        let sexGBMTap = AllgoTapGestureRecognizer(target: self, action: #selector(sexGBTapClicked(sender:)))
        sexGBMTap.tapGB = 0
        maleLbl.isUserInteractionEnabled = true
        maleLbl.addGestureRecognizer(sexGBMTap)
        
        let sexGBFTap = AllgoTapGestureRecognizer(target: self, action: #selector(sexGBTapClicked(sender:)))
        sexGBFTap.tapGB = 1
        feMaleLbl.isUserInteractionEnabled = true
        feMaleLbl.addGestureRecognizer(sexGBFTap)
        
        let bloodATap = AllgoTapGestureRecognizer(target: self, action: #selector(bloodTypeTapClicked(sender:)))
        bloodATap.tapGB = 0
        typeALbl.isUserInteractionEnabled = true
        typeALbl.addGestureRecognizer(bloodATap)
        
        let bloodBTap = AllgoTapGestureRecognizer(target: self, action: #selector(bloodTypeTapClicked(sender:)))
        bloodBTap.tapGB = 1
        typeBLbl.isUserInteractionEnabled = true
        typeBLbl.addGestureRecognizer(bloodBTap)
        
        let bloodOTap = AllgoTapGestureRecognizer(target: self, action: #selector(bloodTypeTapClicked(sender:)))
        bloodOTap.tapGB = 2
        typeOLbl.isUserInteractionEnabled = true
        typeOLbl.addGestureRecognizer(bloodOTap)
        
        let bloodABTap = AllgoTapGestureRecognizer(target: self, action: #selector(bloodTypeTapClicked(sender:)))
        bloodABTap.tapGB = 3
        typeABLbl.isUserInteractionEnabled = true
        typeABLbl.addGestureRecognizer(bloodABTap)
        
        let birthTypeSTap = AllgoTapGestureRecognizer(target: self, action: #selector(birthTypeTapClicked(sender:)))
        birthTypeSTap.tapGB = 0
        birthTypeS.isUserInteractionEnabled = true
        birthTypeS.addGestureRecognizer(birthTypeSTap)
        
        let birthTypeLTap = AllgoTapGestureRecognizer(target: self, action: #selector(birthTypeTapClicked(sender:)))
        birthTypeLTap.tapGB = 1
        birthTypeL.isUserInteractionEnabled = true
        birthTypeL.addGestureRecognizer(birthTypeLTap)
        
        let birthTypeYTap = AllgoTapGestureRecognizer(target: self, action: #selector(birthTypeTapClicked(sender:)))
        birthTypeYTap.tapGB = 2
        birthTypeLY.isUserInteractionEnabled = true
        birthTypeLY.addGestureRecognizer(birthTypeYTap)
        
        let datePickerTab = AllgoTapGestureRecognizer(target: self, action: #selector(datePickerBtnClicked))
        birthYMDLbl.isUserInteractionEnabled = true
        birthYMDLbl.addGestureRecognizer(datePickerTab)
        
        let sangsiTab = AllgoTapGestureRecognizer(target: self, action: #selector(sangsiBtnClicked))
        birthTimeLbl.isUserInteractionEnabled = true
        birthTimeLbl.addGestureRecognizer(sangsiTab)
        
        setInitData()
    }
    
    func setInitData(){
        
        name = sajuInfo["friend_nm"] ?? ""
        nameTF.text = name
        
        sex = sajuInfo["friend_sex_gb"] ?? ""
        
        if sex == Constants.MALE{
            sexs[0].backgroundColor = Constants.BUTTON_GREEN
        }else if sex == Constants.FEMALE{
            sexs[1].backgroundColor = Constants.BUTTON_GREEN
        }
        
        bloodType = sajuInfo["friend_blood"] ?? ""
        
        if bloodType == Constants.BLOOD_TYPE_A{
            bloodTypes[0].backgroundColor = Constants.BUTTON_GREEN
        }else if bloodType == Constants.BLOOD_TYPE_B{
            bloodTypes[1].backgroundColor = Constants.BUTTON_GREEN
        }else if bloodType == Constants.BLOOD_TYPE_O{
            bloodTypes[2].backgroundColor = Constants.BUTTON_GREEN
        }else if bloodType == Constants.BLOOD_TYPE_AB{
            bloodTypes[3].backgroundColor = Constants.BUTTON_GREEN
        }
        
        birthGb = sajuInfo["friend_birth_gb"] ?? ""
        
        if birthGb == Constants.SOLAR{
            birthTypes[0].backgroundColor = Constants.BUTTON_GREEN
        }else if birthGb == Constants.LUNAR{
            birthTypes[1].backgroundColor = Constants.BUTTON_GREEN
        }else if birthGb == Constants.YUN{
            birthTypes[2].backgroundColor = Constants.BUTTON_GREEN
        }
        
        birthYMD = sajuInfo["friend_birth_ymd"] ?? ""
        birthYear = Util.substringWithRange(target: birthYMD, start: 0, range: 4)
        birthMonth = Util.substringWithRange(target: birthYMD, start: 4, range: 2)
        birthDay = Util.substringWithRange(target: birthYMD, start: 6, range: 2)
        
        print("birthYear : \(birthYear)")
        print("birthMonth : \(birthMonth)")
        print("birthDay : \(birthDay)")
        birthYMDLbl.text = birthYear + "/" + birthMonth + "/" + birthDay
        
        birthTime = sajuInfo["friend_birth_time"] ?? ""
        print("birthTime : \(birthTime)")
        birthTimeLbl.text = Util.getOrientalTime(time: birthTime)
        friendCd = sajuInfo["friend_cd"] ?? ""
        
        print("friendCd : \(friendCd)")
        if friendCd == Constants.ME{
            
            friendId = userInfo.memberId ?? ""
            relationTitleLbl.isHidden = true
            relationLbl.isHidden = true
            relationUnderLineImg.isHidden = true
            
            
        }else if friendCd == Constants.PARENT{
            
            relationLbl.text = Constants.PARENT_NAME
            friendId = sajuInfo["id"] ?? ""
            
        }else if friendCd == Constants.FAMILY{
            
            relationLbl.text = Constants.FAMILY_NAME
            friendId = sajuInfo["id"] ?? ""
            
        }else if friendCd == Constants.FRIEND{
            
            relationLbl.text = Constants.FRIEND_NAME
            friendId = sajuInfo["id"] ?? ""
            
        }else if friendCd == Constants.ETC{
            
            relationLbl.text = Constants.ETC_NAME
            friendId = sajuInfo["id"] ?? ""
            
        }
    }
    
    @objc func closeImgClicked(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func sexGBTapClicked(sender: AllgoTapGestureRecognizer){
        print("\(sender.tapGB)")
        var i = 0
        while i < sexs.count{
            sexs[i].backgroundColor = Constants.WHITE
            i = i + 1
        }
        if sender.tapGB == 0{
            sex = Constants.MALE
            sexs[0].backgroundColor = Constants.BUTTON_GREEN
        }else if sender.tapGB == 1{
            sex = Constants.FEMALE
            sexs[1].backgroundColor = Constants.BUTTON_GREEN
        }
    }
    
    @objc func bloodTypeTapClicked(sender: AllgoTapGestureRecognizer){
        print("\(sender.tapGB)")
        var i = 0
        while i < bloodTypes.count{
            bloodTypes[i].backgroundColor = Constants.WHITE
            i = i + 1
        }
        if sender.tapGB == 0{
            bloodType = Constants.BLOOD_TYPE_A
            bloodTypes[0].backgroundColor = Constants.BUTTON_GREEN
        }else if sender.tapGB == 1{
            bloodType = Constants.BLOOD_TYPE_B
            bloodTypes[1].backgroundColor = Constants.BUTTON_GREEN
        }else if sender.tapGB == 2{
            bloodType = Constants.BLOOD_TYPE_O
            bloodTypes[2].backgroundColor = Constants.BUTTON_GREEN
        }else if sender.tapGB == 3{
            bloodType = Constants.BLOOD_TYPE_AB
            bloodTypes[3].backgroundColor = Constants.BUTTON_GREEN
        }
    }
    
    @objc func birthTypeTapClicked(sender: AllgoTapGestureRecognizer){
        print("\(sender.tapGB)")
        var i = 0
        while i < birthTypes.count{
            birthTypes[i].backgroundColor = Constants.WHITE
            i = i + 1
        }
        if sender.tapGB == 0{
            birthGb = Constants.SOLAR
            birthTypes[0].backgroundColor = Constants.BUTTON_GREEN
        }else if sender.tapGB == 1{
            birthGb = Constants.LUNAR
            birthTypes[1].backgroundColor = Constants.BUTTON_GREEN
        }else if sender.tapGB == 2{
            birthGb = Constants.YUN
            birthTypes[2].backgroundColor = Constants.BUTTON_GREEN
        }
    }
    
    @objc func datePickerBtnClicked(){
        
        print("datePickerBtnClicked ~! called")
        let storyboard = UIStoryboard.init(name: "DatePickerPop", bundle: nil)
        let datePickerPop = storyboard.instantiateViewController(identifier: "datePickerPop")
        datePickerPop.modalTransitionStyle = .coverVertical
        datePickerPop.modalPresentationStyle = .overCurrentContext
        
        self.present(datePickerPop,animated: true,completion: nil)
    }
    
    @objc func sangsiBtnClicked(){
        
        let storyboard = UIStoryboard.init(name: "SangsiPop", bundle: nil)
        let sangsiPop = storyboard.instantiateViewController(identifier: "sangsiPop")
        sangsiPop.modalTransitionStyle = .coverVertical
        sangsiPop.modalPresentationStyle = .overCurrentContext
        
        self.present(sangsiPop,animated: true,completion: nil)
    }
    
    func setLblToBtn(btn:UILabel){
        
        btn.clipsToBounds = true
        btn.layer.borderWidth = 1
        btn.layer.borderColor = Constants.BUTTON_GREEN?.cgColor
        btn.layer.cornerRadius = 13
        btn.backgroundColor = Constants.BUTTON_GREEN
        
    }
    
    func setLblsToBtns(btns:Array<UILabel>){
        
        var i = 0
        while i < btns.count{
            
            btns[i].clipsToBounds = true
            btns[i].layer.borderWidth = 1
            btns[i].layer.borderColor = Constants.BUTTON_GREEN?.cgColor
            btns[i].layer.cornerRadius = 13
//            btns[i].backgroundColor = Constants.BUTTON_GREEN
            i += 1
            
        }
        
    }
    
    func setBtn(btn: UIButton){
        
        btn.layer.borderWidth = 1
        btn.layer.borderColor = Constants.BUTTON_GREEN?.cgColor
        btn.layer.cornerRadius = 13
//        btn.backgroundColor = Constants.BUTTON_GREEN
    }
    
    func setBirthDate(year: String,month: String,day: String){
        birthYear = year
        birthMonth = month
        birthDay = day
        
        print("date : \(birthYear)\(birthMonth)\(birthDay)")
        
        birthYMDLbl.text = birthYear + "\\" + birthMonth + "\\" + birthDay
    }
    
    func setSangsi(sangsi: String,index: Int){
        
        birthTimeLbl.text = sangsi
        birthTime = String(index)
        print("birthTime : \(birthTime)")
        
    }
    
    @IBAction func confirmBtnClicked(_ sender: UIButton) {
        
        name = nameTF.text ?? ""
        if name == ""{
            Util.showToast(message: "이름을 입력해 주세요", controller: self)
            return
        }
        let birthYMD = birthYear + birthMonth + birthDay
        
        print("member_id : \(friendId)")
        print("friend_name : \(name)")
        print("friend_sex_gb : \(sex)")
        print("friend_birth_gb : \(birthGb)")
        print("birthYMD : \(birthYMD)")
        print("friend_birth_time : \(birthTime)")
        print("friend_blood_type : \(bloodType)")
        
        if friendCd == Constants.ME{
            
            let param : [String: String] = [
                "member_id" : friendId,
                "member_name" : name,
                "member_sex_gb" : sex,
                "member_birthtype_gb" : birthGb,
                "member_birth_ymd" : birthYMD,
                "member_birth_time" : self.birthTime,
                "member_blood" : self.bloodType,
            ]
            memberInfoUpdate(param: param)
            
        }else{
            
            print("friend_id : \(friendId)")
            print("member_id : \(userInfo.memberId ?? "")")
            print("friend_name : \(name)")
            print("friend_sex_gb : \(sex)")
            print("friend_cd : \(friendCd)")
            print("friend_birth_gb : \(birthGb)")
            print("birthYMD : \(birthYMD)")
            print("friend_birth_time : \(birthTime)")
            print("friend_blood_type : \(bloodType)")
            
            let param : [String: String] = [
                "member_friend_id" : friendId,
                "member_id" : userInfo.memberId ?? "",
                "friend_name" : name,
                "friend_sex_gb" : sex,
                "friend_cd" : friendCd,
                "friend_birth_gb" : birthGb,
                "friend_birth_ymd" : birthYMD,
                "friend_birth_time" : self.birthTime,
                "friend_blood" : self.bloodType,
            ]
            memberFriendUpdate(param: param)
            
            
        }
    }
    
    func memberInfoUpdate(param: Dictionary<String,String>){
        
        let url = Constants.urlPrefix + "/member/memberInfoUpdate"
        
        AF.request(url,
                   method: .post,
                   parameters: param,
                   encoding: JSONEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
//                    .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                //여기서 가져온 데이터를 자유롭게 활용하세요.
                print("memberInfoUpdate result : \(response.result)")

                switch response.result{

                case .success(let value):
                    let json = JSON(value)
                    print(json["error_number"].stringValue)
                    let errorNumber = json["error_number"].stringValue

                    if errorNumber == Constants.SEARCH_OK{

                        Util.showToast(message: "사주정보가 수정 되었습니다.", controller: self)
                        
//                        var name: String = ""
//                        var sex: String = ""
//                        var bloodType: String = ""
//                        var birthGb: String = ""
//                        var birthYMD: String = ""
//                        var birthTime: String = ""
//                        var friendCd: String = ""
//                        var friendId: String = ""
                        self.userInfo.memberName = self.name
                        self.userInfo.memberSexGb = self.sex
                        self.userInfo.memberBirthTypeGb = self.birthGb
                        self.userInfo.memberBirthYear = self.birthYear
                        self.userInfo.memberBirthMonth = self.birthMonth
                        self.userInfo.memberBirthDay = self.birthDay
                        self.userInfo.memberBirthTime = self.birthTime
                        self.userInfo.memberBlood = self.bloodType
                        
                    }
                default:
                    return


                }
            }
        self.dismiss(animated: true, completion: nil)
    }
    
    func memberFriendUpdate(param: Dictionary<String,String>){
        
        let url = Constants.urlPrefix + "/member/memberFriendUpdate"
        
        AF.request(url,
                   method: .post,
                   parameters: param,
                   encoding: JSONEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
//                    .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                //여기서 가져온 데이터를 자유롭게 활용하세요.
                print("memberFriendUpdate result : \(response.result)")

                switch response.result{

                case .success(let value):
                    let json = JSON(value)
                    print(json["error_number"].stringValue)
                    let errorNumber = json["error_number"].stringValue

                    if errorNumber == Constants.SEARCH_OK{

                        Util.showToast(message: "사주정보가 수정 되었습니다.", controller: self)

                        
                    }
                default:
                    return


                }
            }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelBtnClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
