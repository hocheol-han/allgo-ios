//
//  SajuInfoViewController.swift
//  allgo
//
//  Created by 한호철 on 2022/08/04.
//

import UIKit
import Alamofire
import SwiftyJSON

class SajuInfoViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet var sajuInfoTableView: UITableView!
    
    var myInfo = Array<Dictionary<String,String>>()
    var parents = Array<Dictionary<String,String>>()
    var family = Array<Dictionary<String,String>>()
    var friends = Array<Dictionary<String,String>>()
    var etc = Array<Dictionary<String,String>>()
    
    var sajuInfos = Array<Dictionary<String,String>>()
    
    var userInfo: UserInfo!
    @IBOutlet var addInfoImg: UIImageView!
    @IBOutlet var menuImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setInit()
    }
    
    func setInit(){
        
        userInfo = UserInfo.shared
        
        let menuTap = UITapGestureRecognizer(target: self, action: #selector(menuClicked))
        menuImg.isUserInteractionEnabled = true
        menuImg.addGestureRecognizer(menuTap)
        
        let addInfoTap = UITapGestureRecognizer(target: self, action: #selector(addSajuInfo))
        addInfoImg.isUserInteractionEnabled = true
        addInfoImg.addGestureRecognizer(addInfoTap)
        
        var birthYMD = (userInfo.memberBirthYear ?? "") + (userInfo.memberBirthMonth ?? "") + (userInfo.memberBirthDay ?? "")
        
//        print("birthYMD : \(birthYMD)")
//        print("\(Util.getOrientalTimeName(time: userInfo.memberBirthTime ?? ""))")
        
        var myElement = Dictionary<String,String>()
        myElement.updateValue(Util.getOrientalTimeName(time: userInfo.memberBirthTime ?? ""), forKey: "birth_time_name")
        myElement.updateValue(Util.getOrientalTimeValue(time: userInfo.memberBirthTime ?? ""), forKey: "birth_time_value")
        myElement.updateValue(userInfo.memberBirthTypeGb ?? "", forKey: "friend_birth_gb")
        myElement.updateValue(userInfo.memberBirthTime ?? "", forKey: "friend_birth_time")
        myElement.updateValue(birthYMD, forKey: "friend_birth_ymd")
        myElement.updateValue(userInfo.memberBlood ?? "", forKey: "friend_blood")
        myElement.updateValue(Constants.ME, forKey: "friend_cd")
        myElement.updateValue(Constants.ME_NAME, forKey: "friend_cd_name")
        myElement.updateValue(userInfo.memberName ?? "", forKey: "friend_nm")
        myElement.updateValue(userInfo.memberSexGb ?? "", forKey: "friend_sex_gb")
        myElement.updateValue("", forKey: "id")
        myElement.updateValue(userInfo.memberId ?? "", forKey: "member_id")
        myElement.updateValue("", forKey: "score")
        myElement.updateValue("", forKey: "updateday")
        myElement.updateValue("", forKey: "writeday")
        
        
        print("memberId : \(userInfo.memberId)")
        print("memberName : \(userInfo.memberName)")
        self.myInfo.append(myElement)
        
        let param : [String: String] = [
            
            "member_id" : userInfo.memberId ?? "",
            "friend_id" : "",
            "friend_cd" : "",
            "search_query" : ""
            
        ]
        
        getSajuInfo(param: param)
    }
    
    @objc func menuClicked(){
        print("menuClicked() called~!")
        
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
    
    @objc func addSajuInfo(){
        guard let pvc = self.presentingViewController else { return }

//        self.isHeroEnabled = true
//        self.hero.modalAnimationType = .selectBy(presenting: .pull(direction: .left), dismissing: .slide(direction: .right))
        
        self.dismiss(animated: true) {
            
            let storyboard = UIStoryboard.init(name: "SajuInfoInput", bundle: nil)
//            let sajuInfoInput = storyboard.instantiateViewController(identifier: "sajuInfoInput")
            guard let sajuInfoInput = storyboard.instantiateViewController(identifier: "sajuInfoInput") as? SajuInfoInputViewController else{ return }
            sajuInfoInput.content = "ADD_NEW_INFO"
            
            sajuInfoInput.modalTransitionStyle = .coverVertical
            sajuInfoInput.modalPresentationStyle = .fullScreen
            pvc.present(sajuInfoInput, animated: true, completion: nil)
        }
    }
    
    func getSajuInfo(param:Dictionary<String,String>){
        let url = Constants.urlPrefix + "/friend/"
        
        AF.request(url,
                   method: .post,
                   parameters: param,
                   encoding: JSONEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
//                    .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                //여기서 가져온 데이터를 자유롭게 활용하세요.
                print("kkkkkkkkkkk : \(response)")

                switch response.result{

                case .success(let value):
                    let json = JSON(value)
                    print(json["error_number"].stringValue)
                    let errorNumber = json["error_number"].stringValue

                    if errorNumber == Constants.SEARCH_OK{
                        let friends = json["friends"].arrayValue
                        print("count : \(friends.count)")
                        var i = 0
                        while i < friends.count{
                
//                            print("\(friends[i]["birth_time_value"].stringValue)")
//                            print("\(friends[i]["friend_birth_ymd"].stringValue)")
                            print("\(friends[i]["friend_birth_ymd"].stringValue)")
                            print("id : \(friends[i]["id"].stringValue)")
                            print("member_id : \(friends[i]["member_id"].stringValue)")
                            print("score : \(friends[i]["score"].stringValue)")
                           if friends[i]["friend_cd"].stringValue == Constants.PARENT{
                               
                               var pElement = Dictionary<String,String>()
                               pElement.updateValue(friends[i]["birth_time_name"].stringValue, forKey: "birth_time_name")
                               pElement.updateValue(friends[i]["birth_time_value"].stringValue, forKey: "birth_time_value")
                               pElement.updateValue(friends[i]["friend_birth_gb"].stringValue, forKey: "friend_birth_gb")
                               pElement.updateValue(friends[i]["friend_birth_time"].stringValue, forKey: "friend_birth_time")
                               pElement.updateValue(friends[i]["friend_birth_ymd"].stringValue, forKey: "friend_birth_ymd")
                               pElement.updateValue(friends[i]["friend_blood"].stringValue, forKey: "friend_blood")
                               pElement.updateValue(friends[i]["friend_cd"].stringValue, forKey: "friend_cd")
                               pElement.updateValue(friends[i]["friend_cd_name"].stringValue, forKey: "friend_cd_name")
                               pElement.updateValue(friends[i]["friend_nm"].stringValue, forKey: "friend_nm")
                               pElement.updateValue(friends[i]["friend_sex_gb"].stringValue, forKey: "friend_sex_gb")
                               pElement.updateValue(friends[i]["id"].stringValue, forKey: "id")
                               pElement.updateValue(friends[i]["member_id"].stringValue, forKey: "member_id")
                               pElement.updateValue(friends[i]["score"].stringValue, forKey: "score")
                               pElement.updateValue(friends[i]["updateday"].stringValue, forKey: "updateday")
                               pElement.updateValue(friends[i]["writeday"].stringValue, forKey: "writeday")
                               self.parents.append(pElement)
                               
                           }else if friends[i]["friend_cd"].stringValue == Constants.FAMILY{
                               
                               var fElement = Dictionary<String,String>()
                               fElement.updateValue(friends[i]["birth_time_name"].stringValue, forKey: "birth_time_name")
                               fElement.updateValue(friends[i]["birth_time_value"].stringValue, forKey: "birth_time_value")
                               fElement.updateValue(friends[i]["friend_birth_gb"].stringValue, forKey: "friend_birth_gb")
                               fElement.updateValue(friends[i]["friend_birth_time"].stringValue, forKey: "friend_birth_time")
                               fElement.updateValue(friends[i]["friend_birth_ymd"].stringValue, forKey: "friend_birth_ymd")
                               fElement.updateValue(friends[i]["friend_blood"].stringValue, forKey: "friend_blood")
                               fElement.updateValue(friends[i]["friend_cd"].stringValue, forKey: "friend_cd")
                               fElement.updateValue(friends[i]["friend_cd_name"].stringValue, forKey: "friend_cd_name")
                               fElement.updateValue(friends[i]["friend_nm"].stringValue, forKey: "friend_nm")
                               fElement.updateValue(friends[i]["friend_sex_gb"].stringValue, forKey: "friend_sex_gb")
                               fElement.updateValue(friends[i]["id"].stringValue, forKey: "id")
                               fElement.updateValue(friends[i]["member_id"].stringValue, forKey: "member_id")
                               fElement.updateValue(friends[i]["score"].stringValue, forKey: "score")
                               fElement.updateValue(friends[i]["updateday"].stringValue, forKey: "updateday")
                               fElement.updateValue(friends[i]["writeday"].stringValue, forKey: "writeday")
                               self.family.append(fElement)
                               
                           }else if friends[i]["friend_cd"].stringValue == Constants.FRIEND{
                               
                               var frElement = Dictionary<String,String>()
                               frElement.updateValue(friends[i]["birth_time_name"].stringValue, forKey: "birth_time_name")
                               frElement.updateValue(friends[i]["birth_time_value"].stringValue, forKey: "birth_time_value")
                               frElement.updateValue(friends[i]["friend_birth_gb"].stringValue, forKey: "friend_birth_gb")
                               frElement.updateValue(friends[i]["friend_birth_time"].stringValue, forKey: "friend_birth_time")
                               frElement.updateValue(friends[i]["friend_birth_ymd"].stringValue, forKey: "friend_birth_ymd")
                               frElement.updateValue(friends[i]["friend_blood"].stringValue, forKey: "friend_blood")
                               frElement.updateValue(friends[i]["friend_cd"].stringValue, forKey: "friend_cd")
                               frElement.updateValue(friends[i]["friend_cd_name"].stringValue, forKey: "friend_cd_name")
                               frElement.updateValue(friends[i]["friend_nm"].stringValue, forKey: "friend_nm")
                               frElement.updateValue(friends[i]["friend_sex_gb"].stringValue, forKey: "friend_sex_gb")
                               frElement.updateValue(friends[i]["id"].stringValue, forKey: "id")
                               frElement.updateValue(friends[i]["member_id"].stringValue, forKey: "member_id")
                               frElement.updateValue(friends[i]["score"].stringValue, forKey: "score")
                               frElement.updateValue(friends[i]["updateday"].stringValue, forKey: "updateday")
                               frElement.updateValue(friends[i]["writeday"].stringValue, forKey: "writeday")
                               self.friends.append(frElement)
                               
                           }else if friends[i]["friend_cd"].stringValue == Constants.ETC{
                               
                               var etcElement = Dictionary<String,String>()
                               etcElement.updateValue(friends[i]["birth_time_name"].stringValue, forKey: "birth_time_name")
                               etcElement.updateValue(friends[i]["birth_time_value"].stringValue, forKey: "birth_time_value")
                               etcElement.updateValue(friends[i]["friend_birth_gb"].stringValue, forKey: "friend_birth_gb")
                               etcElement.updateValue(friends[i]["friend_birth_time"].stringValue, forKey: "friend_birth_time")
                               etcElement.updateValue(friends[i]["friend_birth_ymd"].stringValue, forKey: "friend_birth_ymd")
                               etcElement.updateValue(friends[i]["friend_blood"].stringValue, forKey: "friend_blood")
                               etcElement.updateValue(friends[i]["friend_cd"].stringValue, forKey: "friend_cd")
                               etcElement.updateValue(friends[i]["friend_cd_name"].stringValue, forKey: "friend_cd_name")
                               etcElement.updateValue(friends[i]["friend_nm"].stringValue, forKey: "friend_nm")
                               etcElement.updateValue(friends[i]["friend_sex_gb"].stringValue, forKey: "friend_sex_gb")
                               etcElement.updateValue(friends[i]["id"].stringValue, forKey: "id")
                               etcElement.updateValue(friends[i]["member_id"].stringValue, forKey: "member_id")
                               etcElement.updateValue(friends[i]["score"].stringValue, forKey: "score")
                               etcElement.updateValue(friends[i]["updateday"].stringValue, forKey: "updateday")
                               etcElement.updateValue(friends[i]["writeday"].stringValue, forKey: "writeday")
                               self.etc.append(etcElement)
                               
                           }
                            i += 1
                        }
//                        print("pcount : \(self.parents.count)")
                        if self.parents.count > 0{
                            for (index,element) in self.parents.enumerated(){
                                if index == 0{
                                    self.parents[index].updateValue("Y", forKey: "title")
                                }else{
                                    self.parents[index].updateValue("N", forKey: "title")
                                }
                            }
                        }
                        
                        if self.family.count > 0{
                            for (index,element) in self.family.enumerated(){
                                if index == 0{
                                    self.family[index].updateValue("Y", forKey: "title")
                                }else{
                                    self.family[index].updateValue("N", forKey: "title")
                                }
                            }
                        }
                        
                        if self.friends.count > 0{
                            for (index,element) in self.friends.enumerated(){
                                if index == 0{
                                    self.friends[index].updateValue("Y", forKey: "title")
                                }else{
                                    self.friends[index].updateValue("N", forKey: "title")
                                }
                            }
                        }
                        
                        if self.etc.count > 0{
                            for (index,element) in self.etc.enumerated(){
                                if index == 0{
                                    self.etc[index].updateValue("Y", forKey: "title")
                                }else{
                                    self.etc[index].updateValue("N", forKey: "title")
                                }
                            }
                        }
                        
                        self.sajuInfos = self.myInfo + self.parents + self.family + self.friends + self.etc
                        
                        self.sajuInfoTableView.reloadData()
                        
                    }
                default:
                    return


                }
            }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sajuInfos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = sajuInfoTableView.dequeueReusableCell(withIdentifier: "listCell",for: indexPath) as? ListCell else{
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        cell.parentView.layer.borderWidth = 1
        cell.parentView.layer.borderColor = Constants.BUTTON_GRAY_BORDER?.cgColor
        cell.parentView.layer.cornerRadius = 20
        
        if sajuInfos[indexPath.row]["friend_cd"] ?? "" == Constants.ME{
           
            cell.cdLbl.isHidden = false
            cell.cdLbl.text = sajuInfos[indexPath.row]["friend_cd_name"]
//            cell.firstImg.image = UIImage(named:"btn_edit")
            cell.firstImg.isHidden = true
            cell.secondImg.image = UIImage(named:"btn_edit")
            
            let editImgTab = SajuInfoTapGestureRecognizer(target: self, action: #selector(editSajuInfo(sender:)))
            
            editImgTab.infos = sajuInfos[indexPath.row]
            
            cell.secondImg.isUserInteractionEnabled = true
            cell.secondImg.addGestureRecognizer(editImgTab)
        
        }else{
            
            cell.firstImg.isHidden = false
            cell.secondImg.isHidden = false
            cell.firstImg.image = UIImage(named:"btn_edit")
            cell.secondImg.image = UIImage(named:"btn_delete")
            
            let editImgTab = SajuInfoTapGestureRecognizer(target: self, action: #selector(editSajuInfo(sender:)))
            
            editImgTab.infos = sajuInfos[indexPath.row]
            
            cell.firstImg.isUserInteractionEnabled = true
            cell.firstImg.addGestureRecognizer(editImgTab)
            
            
            let deleteImgTab = SajuInfoTapGestureRecognizer(target: self, action: #selector(deleteSajuInfo(sender:)))
            
            deleteImgTab.infos = sajuInfos[indexPath.row]
            
            cell.secondImg.isUserInteractionEnabled = true
            cell.secondImg.addGestureRecognizer(deleteImgTab)
            
        }
        if sajuInfos[indexPath.row]["friend_cd"] ?? "" == Constants.PARENT && sajuInfos[indexPath.row]["title"] ?? "" == "Y" {
           
            cell.cdLbl.isHidden = false
            cell.cdLbl.text = sajuInfos[indexPath.row]["friend_cd_name"] ?? ""
        }else if sajuInfos[indexPath.row]["friend_cd"] ?? "" == Constants.PARENT && sajuInfos[indexPath.row]["title"] ?? "" == "N" {
          
            cell.cdLbl.isHidden = true
        }
        
        if sajuInfos[indexPath.row]["friend_cd"] ?? "" == Constants.FAMILY && sajuInfos[indexPath.row]["title"] ?? "" == "Y" {
          
            cell.cdLbl.isHidden = false
            cell.cdLbl.text = sajuInfos[indexPath.row]["friend_cd_name"] ?? ""
        }else if sajuInfos[indexPath.row]["friend_cd"] ?? "" == Constants.FAMILY && sajuInfos[indexPath.row]["title"] ?? "" == "N" {
           
            cell.cdLbl.isHidden = true
        }
        
        if sajuInfos[indexPath.row]["friend_cd"] ?? "" == Constants.FRIEND && sajuInfos[indexPath.row]["title"] ?? "" == "Y" {
      
            cell.cdLbl.isHidden = false
            cell.cdLbl.text = sajuInfos[indexPath.row]["friend_cd_name"] ?? ""
        }else if sajuInfos[indexPath.row]["friend_cd"] ?? "" == Constants.FRIEND && sajuInfos[indexPath.row]["title"] ?? "" == "N" {
          
            cell.cdLbl.isHidden = true
        }
        
        if sajuInfos[indexPath.row]["friend_cd"] ?? "" == Constants.ETC && sajuInfos[indexPath.row]["title"] ?? "" == "Y" {
          
            cell.cdLbl.isHidden = false
            cell.cdLbl.text = sajuInfos[indexPath.row]["friend_cd_name"] ?? ""
        }else if sajuInfos[indexPath.row]["friend_cd"] ?? "" == Constants.ETC && sajuInfos[indexPath.row]["title"] ?? "" == "N" {
           
            cell.cdLbl.isHidden = true
        }
        
        cell.nameLbl.text = sajuInfos[indexPath.row]["friend_nm"]
        
        let genderImage = Util.getGenderTypeImage(type: sajuInfos[indexPath.row]["friend_sex_gb"] ?? "")
        cell.genderImg.image = UIImage(named: genderImage)
        
        let bloodImage = Util.getBloodTypeImage(type: sajuInfos[indexPath.row]["friend_blood"] ?? "")
        cell.bloodImg.image = UIImage(named: bloodImage)
        
        let year = Util.substringWithRange(target: sajuInfos[indexPath.row]["friend_birth_ymd"] ?? "", start: 0, range: 4)
//        print("year : \(year)")
        let month = Util.substringWithRange(target: sajuInfos[indexPath.row]["friend_birth_ymd"] ?? "", start: 4, range: 2)
//        print("month : \(month)")
        let day = Util.substringWithRange(target: sajuInfos[indexPath.row]["friend_birth_ymd"] ?? "", start: 6, range: 2)
//        print("day : \(day)")
        cell.birthYMDLbl.text = year + "." + month + "." + day
        
        let birthType = Util.getBirthType(type: sajuInfos[indexPath.row]["friend_birth_gb"] ?? "")
        cell.birthTypeLbl.text = birthType
        
        let birthTime = Util.getOrientalTime(time: sajuInfos[indexPath.row]["friend_birth_time"] ?? "")
        cell.birthTimeLbl.text = birthTime
        
        
        return cell
    }
    
    @objc func editSajuInfo(sender: SajuInfoTapGestureRecognizer){
        
        print(sender.infos["birth_time_name"] ?? "")
        guard let pvc = self.presentingViewController else { return }
        
        self.dismiss(animated: true) {
            
            let storyboard = UIStoryboard.init(name: "ModifySajuInfo", bundle: nil)
//            let sajuInfoInput = storyboard.instantiateViewController(identifier: "sajuInfoInput")
            guard let modifySajuInfoVC = storyboard.instantiateViewController(identifier: "modifySajuInfo") as? ModifySajuInfoViewController else{ return }
    
            modifySajuInfoVC.sajuInfo = sender.infos
            modifySajuInfoVC.modalTransitionStyle = .coverVertical
            modifySajuInfoVC.modalPresentationStyle = .fullScreen
            pvc.present(modifySajuInfoVC, animated: true, completion: nil)
        }
        
    }
    
    @objc func deleteSajuInfo(sender: SajuInfoTapGestureRecognizer){
        
        guard let pvc = self.presentingViewController else { return }
        
        self.dismiss(animated: true) {
            
            let storyboard = UIStoryboard.init(name: "MemberDelete", bundle: nil)
//            let sajuInfoInput = storyboard.instantiateViewController(identifier: "sajuInfoInput")
            guard let memberDeleteVC = storyboard.instantiateViewController(identifier: "memberDelete") as? MemberDeleteViewController else{ return }
    
            memberDeleteVC.sajuInfo = sender.infos
            memberDeleteVC.modalTransitionStyle = .coverVertical
            memberDeleteVC.modalPresentationStyle = .overCurrentContext
            pvc.present(memberDeleteVC, animated: true, completion: nil)
        }
    }
}

class ListCell: UITableViewCell{
    
    @IBOutlet var parentView: UIView!
    @IBOutlet var cdLbl: UILabel!
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var genderImg: UIImageView!
    @IBOutlet var bloodImg: UIImageView!
    @IBOutlet var birthYMDLbl: UILabel!
    @IBOutlet var birthTypeLbl: UILabel!
    @IBOutlet var birthTimeLbl: UILabel!
    @IBOutlet var firstImg: UIImageView!
    @IBOutlet var secondImg: UIImageView!
    
    
}
