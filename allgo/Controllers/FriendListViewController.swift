//
//  FriendListViewController.swift
//  allgo
//
//  Created by 한호철 on 2022/07/05.
//

import UIKit
import Alamofire
import SwiftyJSON

class FriendListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var userInfo: UserInfo!
    @IBOutlet var friendListTableView: UITableView!
    @IBOutlet var closeImg: UIImageView!
    
    var parents = Array<Dictionary<String,String>>()
    var family = Array<Dictionary<String,String>>()
    var friends = Array<Dictionary<String,String>>()
    var etc = Array<Dictionary<String,String>>()
    
    var results = Array<Dictionary<String,String>>()
    
    var content: String = ""
    
    var friendCD = Constants.PARENT
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setInit()
        getFriendList()
    }
    
    func setInit(){
        userInfo    = UserInfo.shared
        
        let closeImgTab = UITapGestureRecognizer(target: self, action: #selector(closeImgClicked))
        closeImg.isUserInteractionEnabled = true
        closeImg.addGestureRecognizer(closeImgTab)
    }
    
    @objc func closeImgClicked(){
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func getFriendList(){
        
        let param : [String: String] = [
            
            "member_id" : userInfo.memberId ?? "",
            "friend_id" : "",
            "friend_cd" : "",
            "search_query" : ""
            
        ]
        
        let url = Constants.urlPrefix + "/friend/"
        
        AF.request(url,
                   method: .post,
                   parameters: param,
                   encoding: JSONEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
//                    .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                //여기서 가져온 데이터를 자유롭게 활용하세요.
                print("getFriendList result : \(response.result)")

                switch response.result{

                case .success(let value):
                    let json = JSON(value)
                    print(json["error_number"].stringValue)
                    let errorNumber = json["error_number"].stringValue

                    if errorNumber == Constants.SEARCH_OK{

//                        "birth_time_name" = "\Uc778\Uc2dc";
//                        "birth_time_value" = "03:30~05:30";
//                        "friend_birth_gb" = 1;
//                        "friend_birth_time" = 3;
//                        "friend_birth_ymd" = 20190725;
//                        "friend_blood" = O;
//                        "friend_cd" = M06002;
//                        "friend_cd_name" = "\Uac00\Uc871";
//                        "friend_id" = "<null>";
//                        "friend_nm" = Peach;
//                        "friend_sex_gb" = 0;
//                        id = 103;
//                        "member_id" = "hyeongrok@gmail.com";
//                        score = 29;
//                        updateday = "2021-06-23T01:50:52.000Z";
//                        writeday = "2021-06-23T01:50:52.000Z";
                        
                        var friendList = json["friends"].arrayValue
                        for (index,element) in friendList.enumerated(){
//                            print("\(element["friend_cd"])")
                            var pElement = Dictionary<String,String>()
                            if element["friend_cd"].stringValue == Constants.PARENT{
                                
                                pElement.updateValue(element["birth_time_name"].stringValue, forKey: "birth_time_name")
                                pElement.updateValue(element["birth_time_value"].stringValue, forKey: "birth_time_value")
                                pElement.updateValue(element["friend_birth_gb"].stringValue, forKey: "friend_birth_gb")
                                pElement.updateValue(element["friend_birth_time"].stringValue, forKey: "friend_birth_time")
                                pElement.updateValue(element["friend_birth_ymd"].stringValue, forKey: "friend_birth_ymd")
                                pElement.updateValue(element["friend_blood"].stringValue, forKey: "friend_blood")
                                pElement.updateValue(element["friend_cd"].stringValue, forKey: "friend_cd")
                                pElement.updateValue(element["friend_cd_name"].stringValue, forKey: "friend_cd_name")
                                pElement.updateValue(element["friend_nm"].stringValue, forKey: "friend_nm")
                                pElement.updateValue(element["friend_sex_gb"].stringValue, forKey: "friend_sex_gb")
                                pElement.updateValue(element["id"].stringValue, forKey: "id")
                                pElement.updateValue(element["member_id"].stringValue, forKey: "member_id")
                                pElement.updateValue(element["score"].stringValue, forKey: "score")
                                pElement.updateValue(element["updateday"].stringValue, forKey: "updateday")
                                pElement.updateValue(element["writeday"].stringValue, forKey: "writeday")
                                self.parents.append(pElement)
                            }
                            var faElement = Dictionary<String,String>()
                            if element["friend_cd"].stringValue == Constants.FAMILY{
                                
                                faElement.updateValue(element["birth_time_name"].stringValue, forKey: "birth_time_name")
                                faElement.updateValue(element["birth_time_value"].stringValue, forKey: "birth_time_value")
                                faElement.updateValue(element["friend_birth_gb"].stringValue, forKey: "friend_birth_gb")
                                faElement.updateValue(element["friend_birth_time"].stringValue, forKey: "friend_birth_time")
                                faElement.updateValue(element["friend_birth_ymd"].stringValue, forKey: "friend_birth_ymd")
                                faElement.updateValue(element["friend_blood"].stringValue, forKey: "friend_blood")
                                faElement.updateValue(element["friend_cd"].stringValue, forKey: "friend_cd")
                                faElement.updateValue(element["friend_cd_name"].stringValue, forKey: "friend_cd_name")
                                faElement.updateValue(element["friend_nm"].stringValue, forKey: "friend_nm")
                                faElement.updateValue(element["friend_sex_gb"].stringValue, forKey: "friend_sex_gb")
                                faElement.updateValue(element["id"].stringValue, forKey: "id")
                                faElement.updateValue(element["member_id"].stringValue, forKey: "member_id")
                                faElement.updateValue(element["score"].stringValue, forKey: "score")
                                faElement.updateValue(element["updateday"].stringValue, forKey: "updateday")
                                faElement.updateValue(element["writeday"].stringValue, forKey: "writeday")
                                self.family.append(faElement)
                            }
                            var frElement = Dictionary<String,String>()
                            if element["friend_cd"].stringValue == Constants.FRIEND{
                                
                                frElement.updateValue(element["birth_time_name"].stringValue, forKey: "birth_time_name")
                                frElement.updateValue(element["birth_time_value"].stringValue, forKey: "birth_time_value")
                                frElement.updateValue(element["friend_birth_gb"].stringValue, forKey: "friend_birth_gb")
                                frElement.updateValue(element["friend_birth_time"].stringValue, forKey: "friend_birth_time")
                                frElement.updateValue(element["friend_birth_ymd"].stringValue, forKey: "friend_birth_ymd")
                                frElement.updateValue(element["friend_blood"].stringValue, forKey: "friend_blood")
                                frElement.updateValue(element["friend_cd"].stringValue, forKey: "friend_cd")
                                frElement.updateValue(element["friend_cd_name"].stringValue, forKey: "friend_cd_name")
                                frElement.updateValue(element["friend_nm"].stringValue, forKey: "friend_nm")
                                frElement.updateValue(element["friend_sex_gb"].stringValue, forKey: "friend_sex_gb")
                                frElement.updateValue(element["id"].stringValue, forKey: "id")
                                frElement.updateValue(element["member_id"].stringValue, forKey: "member_id")
                                frElement.updateValue(element["score"].stringValue, forKey: "score")
                                frElement.updateValue(element["updateday"].stringValue, forKey: "updateday")
                                frElement.updateValue(element["writeday"].stringValue, forKey: "writeday")
                                self.friends.append(frElement)
                            }
                            var etcElement = Dictionary<String,String>()
                            if element["friend_cd"].stringValue == Constants.ETC{
                                
                                etcElement.updateValue(element["birth_time_name"].stringValue, forKey: "birth_time_name")
                                etcElement.updateValue(element["birth_time_value"].stringValue, forKey: "birth_time_value")
                                etcElement.updateValue(element["friend_birth_gb"].stringValue, forKey: "friend_birth_gb")
                                etcElement.updateValue(element["friend_birth_time"].stringValue, forKey: "friend_birth_time")
                                etcElement.updateValue(element["friend_birth_ymd"].stringValue, forKey: "friend_birth_ymd")
                                etcElement.updateValue(element["friend_blood"].stringValue, forKey: "friend_blood")
                                etcElement.updateValue(element["friend_cd"].stringValue, forKey: "friend_cd")
                                etcElement.updateValue(element["friend_cd_name"].stringValue, forKey: "friend_cd_name")
                                etcElement.updateValue(element["friend_nm"].stringValue, forKey: "friend_nm")
                                etcElement.updateValue(element["friend_sex_gb"].stringValue, forKey: "friend_sex_gb")
                                etcElement.updateValue(element["id"].stringValue, forKey: "id")
                                etcElement.updateValue(element["member_id"].stringValue, forKey: "member_id")
                                etcElement.updateValue(element["score"].stringValue, forKey: "score")
                                etcElement.updateValue(element["updateday"].stringValue, forKey: "updateday")
                                etcElement.updateValue(element["writeday"].stringValue, forKey: "writeday")
                                self.etc.append(etcElement)
                            }
                        }
//                        print("parents : \(self.parents.count)")
//                        print("family : \(self.family.count)")
//                        print("friend : \(self.friends.count)")
//                        print("etc : \(self.etc.count)")
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
                        
                        print("parents : \(self.parents.count)")
                        print("family : \(self.family.count)")
                        print("friends : \(self.friends.count)")
                        print("etc : \(self.etc.count)")
                        
                        self.results = self.parents + self.family + self.friends + self.etc
                        print("results : \(self.results.count)")
                        print("results : \(self.results)")
                        
                        self.friendListTableView.reloadData()
                        
                    }
                default:
                    return

                }
            }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = friendListTableView.dequeueReusableCell(withIdentifier: "friendListCell",for: indexPath) as? FriendListCell else{
            
            return UITableViewCell()
        }
        
        cell.parentView.layer.borderWidth = 1
        cell.parentView.layer.borderColor = Constants.BUTTON_GRAY_BORDER?.cgColor
        cell.parentView.layer.cornerRadius = 20
        
        cell.name.text = results[indexPath.row]["friend_nm"]
        
//        print("\(results[indexPath.row]["friend_cd"] )")
//        print("\(results[indexPath.row]["title"] )")
        
        if results[indexPath.row]["friend_cd"] ?? "" == Constants.PARENT && results[indexPath.row]["title"] ?? "" == "Y" {
           
            cell.friend_cd.isHidden = false
            cell.friend_cd.text = results[indexPath.row]["friend_cd_name"] ?? ""
        }else if results[indexPath.row]["friend_cd"] ?? "" == Constants.PARENT && results[indexPath.row]["title"] ?? "" == "N" {
          
            cell.friend_cd.isHidden = true
        }
        
        if results[indexPath.row]["friend_cd"] ?? "" == Constants.FAMILY && results[indexPath.row]["title"] ?? "" == "Y" {
          
            cell.friend_cd.isHidden = false
            cell.friend_cd.text = results[indexPath.row]["friend_cd_name"] ?? ""
        }else if results[indexPath.row]["friend_cd"] ?? "" == Constants.FAMILY && results[indexPath.row]["title"] ?? "" == "N" {
           
            cell.friend_cd.isHidden = true
        }
        
        if results[indexPath.row]["friend_cd"] ?? "" == Constants.FRIEND && results[indexPath.row]["title"] ?? "" == "Y" {
      
            cell.friend_cd.isHidden = false
            cell.friend_cd.text = results[indexPath.row]["friend_cd_name"] ?? ""
        }else if results[indexPath.row]["friend_cd"] ?? "" == Constants.FRIEND && results[indexPath.row]["title"] ?? "" == "N" {
          
            cell.friend_cd.isHidden = true
        }
        
        if results[indexPath.row]["friend_cd"] ?? "" == Constants.ETC && results[indexPath.row]["title"] ?? "" == "Y" {
          
            cell.friend_cd.isHidden = false
            cell.friend_cd.text = results[indexPath.row]["friend_cd_name"] ?? ""
        }else if results[indexPath.row]["friend_cd"] ?? "" == Constants.ETC && results[indexPath.row]["title"] ?? "" == "N" {
           
            cell.friend_cd.isHidden = true
        }
        
        let genderImage = Util.getGenderTypeImage(type: results[indexPath.row]["friend_sex_gb"] ?? "")
        cell.genderImage.image = UIImage(named: genderImage)
        
        let bloodImage = Util.getBloodTypeImage(type: results[indexPath.row]["friend_blood"] ?? "")
        cell.bloodTypeImage.image = UIImage(named: bloodImage)
        
        let year = Util.substringWithRange(target: results[indexPath.row]["friend_birth_ymd"] ?? "", start: 0, range: 4)
//        print("year : \(year)")
        let month = Util.substringWithRange(target: results[indexPath.row]["friend_birth_ymd"] ?? "", start: 4, range: 2)
//        print("month : \(month)")
        let day = Util.substringWithRange(target: results[indexPath.row]["friend_birth_ymd"] ?? "", start: 6, range: 2)
//        print("day : \(day)")
        cell.birthYMDlbl.text = year + "." + month + "." + day
        
        let birthType = Util.getBirthType(type: results[indexPath.row]["friend_birth_gb"] ?? "")
        cell.birthTypelbl.text = birthType
        
        let birthTime = Util.getOrientalTime(time: results[indexPath.row]["friend_birth_time"] ?? "")
        cell.birthTimelbl.text = birthTime
//        if self.regUnses[indexPath.row] == true{
//            cell.interestingUnseCheck.image = UIImage(named: "ic_check_chk_s")
//        }else{
//            cell.interestingUnseCheck.image = UIImage(named: "ic_check_nor_s")
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("IndexPath : \(indexPath.row)")
        
        guard let pvc = self.presentingViewController else { return }

        
        self.dismiss(animated: true) {
            
            
            if self.content == Constants.JUNGTONG_UNSE_NAME[0]{//토정비결}
                let storyboard = UIStoryboard.init(name: "Tojeong", bundle: nil)
                guard let tojeongVC = storyboard.instantiateViewController(identifier: "tojeong") as? TojeongViewController else{ return }
                tojeongVC.modalTransitionStyle = .coverVertical
                tojeongVC.modalPresentationStyle = .fullScreen
                
    //            "friend_name" : name,
    //            "friend_sex_gb" : sexGB,
    //            "friend_cd" : friendCD,
    //            "friend_birth_gb" : birthGB,
    //            "friend_birth_ymd" : birthYMD,
    //            "friend_birth_time" : birthTime,
    //            "friend_blood_type" : bloodType,
                
                
                tojeongVC.from = "SAVED"
                tojeongVC.friend_name = self.results[indexPath.row]["friend_nm"] ?? ""
                tojeongVC.friend_sex_gb = self.results[indexPath.row]["friend_sex_gb"] ?? ""
                tojeongVC.friend_cd = self.results[indexPath.row]["friend_cd"] ?? ""
                tojeongVC.friend_birth_gb = self.results[indexPath.row]["friend_birth_gb"] ?? ""
                tojeongVC.friend_birth_ymd = self.results[indexPath.row]["friend_birth_ymd"] ?? ""
                
                let year = Util.substringWithRange(target: self.results[indexPath.row]["friend_birth_ymd"] ?? "", start: 0, range: 4)
                let month = Util.substringWithRange(target: self.results[indexPath.row]["friend_birth_ymd"] ?? "", start: 4, range: 2)
                let day = Util.substringWithRange(target: self.results[indexPath.row]["friend_birth_ymd"] ?? "", start: 6, range: 2)
                tojeongVC.friend_birth_year = year
                tojeongVC.friend_birth_month = month
                tojeongVC.friend_birth_day = day
                
                tojeongVC.friend_birth_time = self.results[indexPath.row]["friend_birth_time"] ?? ""
                tojeongVC.friend_blood_type = self.results[indexPath.row]["friend_blood"] ?? ""
                
                pvc.present(tojeongVC, animated: true, completion: nil)
            }else if self.content == Constants.JUNGTONG_UNSE_NAME[1]{//사주
                let storyboard = UIStoryboard.init(name: "Saju", bundle: nil)
                guard let sajuVC = storyboard.instantiateViewController(identifier: "saju") as? SajuViewController else{ return }
                sajuVC.modalTransitionStyle = .coverVertical
                sajuVC.modalPresentationStyle = .fullScreen
                
    //            "friend_name" : name,
    //            "friend_sex_gb" : sexGB,
    //            "friend_cd" : friendCD,
    //            "friend_birth_gb" : birthGB,
    //            "friend_birth_ymd" : birthYMD,
    //            "friend_birth_time" : birthTime,
    //            "friend_blood_type" : bloodType,
                
                
                sajuVC.from = "SAVED"
                sajuVC.friend_name = self.results[indexPath.row]["friend_nm"] ?? ""
                sajuVC.friend_sex_gb = self.results[indexPath.row]["friend_sex_gb"] ?? ""
                sajuVC.friend_cd = self.results[indexPath.row]["friend_cd"] ?? ""
                sajuVC.friend_birth_gb = self.results[indexPath.row]["friend_birth_gb"] ?? ""
                sajuVC.friend_birth_ymd = self.results[indexPath.row]["friend_birth_ymd"] ?? ""
                
                let year = Util.substringWithRange(target: self.results[indexPath.row]["friend_birth_ymd"] ?? "", start: 0, range: 4)
                let month = Util.substringWithRange(target: self.results[indexPath.row]["friend_birth_ymd"] ?? "", start: 4, range: 2)
                let day = Util.substringWithRange(target: self.results[indexPath.row]["friend_birth_ymd"] ?? "", start: 6, range: 2)
                sajuVC.friend_birth_year = year
                sajuVC.friend_birth_month = month
                sajuVC.friend_birth_day = day
                
                sajuVC.friend_birth_time = self.results[indexPath.row]["friend_birth_time"] ?? ""
                sajuVC.friend_blood_type = self.results[indexPath.row]["friend_blood"] ?? ""
                
                pvc.present(sajuVC, animated: true, completion: nil)
                
            }else if self.content == Constants.THEME_UNSE_NAME[4]{
                
                print("go animal page~!!!")
                
                let storyboard = UIStoryboard.init(name: "Animal", bundle: nil)
                guard let animalVC = storyboard.instantiateViewController(identifier: "animal") as? AnimalViewController else{ return }
                animalVC.modalTransitionStyle = .coverVertical
                animalVC.modalPresentationStyle = .fullScreen
                
                
                animalVC.from = "SAVED"
                animalVC.friend_name = self.results[indexPath.row]["friend_nm"] ?? ""
                animalVC.friend_sex_gb = self.results[indexPath.row]["friend_sex_gb"] ?? ""
                animalVC.friend_cd = self.results[indexPath.row]["friend_cd"] ?? ""
                animalVC.friend_birth_gb = self.results[indexPath.row]["friend_birth_gb"] ?? ""
                animalVC.friend_birth_ymd = self.results[indexPath.row]["friend_birth_ymd"] ?? ""
                
                let year = Util.substringWithRange(target: self.results[indexPath.row]["friend_birth_ymd"] ?? "", start: 0, range: 4)
                let month = Util.substringWithRange(target: self.results[indexPath.row]["friend_birth_ymd"] ?? "", start: 4, range: 2)
                let day = Util.substringWithRange(target: self.results[indexPath.row]["friend_birth_ymd"] ?? "", start: 6, range: 2)
                animalVC.friend_birth_year = year
                animalVC.friend_birth_month = month
                animalVC.friend_birth_day = day
                
                animalVC.friend_birth_time = self.results[indexPath.row]["friend_birth_time"] ?? ""
                animalVC.friend_blood_type = self.results[indexPath.row]["friend_blood"] ?? ""
                
                pvc.present(animalVC, animated: true, completion: nil)
            
            }else if self.content == Constants.THEME_UNSE_NAME[5]{
                
                let storyboard = UIStoryboard.init(name: "Flower", bundle: nil)
                guard let flowerVC = storyboard.instantiateViewController(identifier: "flower") as? FlowerViewController else{ return }
                flowerVC.modalTransitionStyle = .coverVertical
                flowerVC.modalPresentationStyle = .fullScreen
                
                
                flowerVC.from = "SAVED"
                flowerVC.friend_name = self.results[indexPath.row]["friend_nm"] ?? ""
                flowerVC.friend_sex_gb = self.results[indexPath.row]["friend_sex_gb"] ?? ""
                flowerVC.friend_cd = self.results[indexPath.row]["friend_cd"] ?? ""
                flowerVC.friend_birth_gb = self.results[indexPath.row]["friend_birth_gb"] ?? ""
                flowerVC.friend_birth_ymd = self.results[indexPath.row]["friend_birth_ymd"] ?? ""
                
                let year = Util.substringWithRange(target: self.results[indexPath.row]["friend_birth_ymd"] ?? "", start: 0, range: 4)
                let month = Util.substringWithRange(target: self.results[indexPath.row]["friend_birth_ymd"] ?? "", start: 4, range: 2)
                let day = Util.substringWithRange(target: self.results[indexPath.row]["friend_birth_ymd"] ?? "", start: 6, range: 2)
                flowerVC.friend_birth_year = year
                flowerVC.friend_birth_month = month
                flowerVC.friend_birth_day = day
                
                flowerVC.friend_birth_time = self.results[indexPath.row]["friend_birth_time"] ?? ""
                flowerVC.friend_blood_type = self.results[indexPath.row]["friend_blood"] ?? ""
                
                pvc.present(flowerVC, animated: true, completion: nil)
                
            }else if self.content == Constants.THEME_UNSE_NAME[6]{
                
                let storyboard = UIStoryboard.init(name: "CatchMind", bundle: nil)
                guard let catchMindVC = storyboard.instantiateViewController(identifier: "catchMind") as? CatchMindViewController else{ return }
                catchMindVC.modalTransitionStyle = .coverVertical
                catchMindVC.modalPresentationStyle = .fullScreen
                
                
                catchMindVC.from = "SAVED"
                catchMindVC.friend_name = self.results[indexPath.row]["friend_nm"] ?? ""
                catchMindVC.friend_sex_gb = self.results[indexPath.row]["friend_sex_gb"] ?? ""
                catchMindVC.friend_cd = self.results[indexPath.row]["friend_cd"] ?? ""
                catchMindVC.friend_birth_gb = self.results[indexPath.row]["friend_birth_gb"] ?? ""
                catchMindVC.friend_birth_ymd = self.results[indexPath.row]["friend_birth_ymd"] ?? ""
                
                let year = Util.substringWithRange(target: self.results[indexPath.row]["friend_birth_ymd"] ?? "", start: 0, range: 4)
                let month = Util.substringWithRange(target: self.results[indexPath.row]["friend_birth_ymd"] ?? "", start: 4, range: 2)
                let day = Util.substringWithRange(target: self.results[indexPath.row]["friend_birth_ymd"] ?? "", start: 6, range: 2)
                catchMindVC.friend_birth_year = year
                catchMindVC.friend_birth_month = month
                catchMindVC.friend_birth_day = day
                
                catchMindVC.friend_birth_time = self.results[indexPath.row]["friend_birth_time"] ?? ""
                catchMindVC.friend_blood_type = self.results[indexPath.row]["friend_blood"] ?? ""
                
                pvc.present(catchMindVC, animated: true, completion: nil)
                
            }else if self.content == Constants.THEME_UNSE_NAME[8]{
                
                let storyboard = UIStoryboard.init(name: "BloodNStar", bundle: nil)
                guard let bloodNStarVC = storyboard.instantiateViewController(identifier: "bloodNStar") as? BloodNStarViewController else{ return }
                bloodNStarVC.modalTransitionStyle = .coverVertical
                bloodNStarVC.modalPresentationStyle = .fullScreen
                
                
                bloodNStarVC.from = "SAVED"
                bloodNStarVC.friend_name = self.results[indexPath.row]["friend_nm"] ?? ""
                bloodNStarVC.friend_sex_gb = self.results[indexPath.row]["friend_sex_gb"] ?? ""
                bloodNStarVC.friend_cd = self.results[indexPath.row]["friend_cd"] ?? ""
                bloodNStarVC.friend_birth_gb = self.results[indexPath.row]["friend_birth_gb"] ?? ""
                bloodNStarVC.friend_birth_ymd = self.results[indexPath.row]["friend_birth_ymd"] ?? ""
                
                let year = Util.substringWithRange(target: self.results[indexPath.row]["friend_birth_ymd"] ?? "", start: 0, range: 4)
                let month = Util.substringWithRange(target: self.results[indexPath.row]["friend_birth_ymd"] ?? "", start: 4, range: 2)
                let day = Util.substringWithRange(target: self.results[indexPath.row]["friend_birth_ymd"] ?? "", start: 6, range: 2)
                bloodNStarVC.friend_birth_year = year
                bloodNStarVC.friend_birth_month = month
                bloodNStarVC.friend_birth_day = day
                
                bloodNStarVC.friend_birth_time = self.results[indexPath.row]["friend_birth_time"] ?? ""
                bloodNStarVC.friend_blood_type = self.results[indexPath.row]["friend_blood"] ?? ""
                
                pvc.present(bloodNStarVC, animated: true, completion: nil)
                
            }else if self.content == Constants.THEME_UNSE_NAME[9]{
                
                let storyboard = UIStoryboard.init(name: "StarStory", bundle: nil)
                guard let starStoryVC = storyboard.instantiateViewController(identifier: "starStory") as? StarStoryViewController else{ return }
                starStoryVC.modalTransitionStyle = .coverVertical
                starStoryVC.modalPresentationStyle = .fullScreen
                
                
                starStoryVC.from = "SAVED"
                starStoryVC.friend_name = self.results[indexPath.row]["friend_nm"] ?? ""
                starStoryVC.friend_sex_gb = self.results[indexPath.row]["friend_sex_gb"] ?? ""
                starStoryVC.friend_cd = self.results[indexPath.row]["friend_cd"] ?? ""
                starStoryVC.friend_birth_gb = self.results[indexPath.row]["friend_birth_gb"] ?? ""
                starStoryVC.friend_birth_ymd = self.results[indexPath.row]["friend_birth_ymd"] ?? ""
                
                let year = Util.substringWithRange(target: self.results[indexPath.row]["friend_birth_ymd"] ?? "", start: 0, range: 4)
                let month = Util.substringWithRange(target: self.results[indexPath.row]["friend_birth_ymd"] ?? "", start: 4, range: 2)
                let day = Util.substringWithRange(target: self.results[indexPath.row]["friend_birth_ymd"] ?? "", start: 6, range: 2)
                starStoryVC.friend_birth_year = year
                starStoryVC.friend_birth_month = month
                starStoryVC.friend_birth_day = day
                
                starStoryVC.friend_birth_time = self.results[indexPath.row]["friend_birth_time"] ?? ""
                starStoryVC.friend_blood_type = self.results[indexPath.row]["friend_blood"] ?? ""
                
                pvc.present(starStoryVC, animated: true, completion: nil)
                
            }else if self.content == Constants.THEME_UNSE_NAME[10]{
                
                let storyboard = UIStoryboard.init(name: "StarNDdi", bundle: nil)
                guard let starNDdiVC = storyboard.instantiateViewController(identifier: "starNDdi") as? StarNDdiViewController else{ return }
                starNDdiVC.modalTransitionStyle = .coverVertical
                starNDdiVC.modalPresentationStyle = .fullScreen
                
                
                starNDdiVC.from = "SAVED"
                starNDdiVC.friend_name = self.results[indexPath.row]["friend_nm"] ?? ""
                starNDdiVC.friend_sex_gb = self.results[indexPath.row]["friend_sex_gb"] ?? ""
                starNDdiVC.friend_cd = self.results[indexPath.row]["friend_cd"] ?? ""
                starNDdiVC.friend_birth_gb = self.results[indexPath.row]["friend_birth_gb"] ?? ""
                starNDdiVC.friend_birth_ymd = self.results[indexPath.row]["friend_birth_ymd"] ?? ""
                
                let year = Util.substringWithRange(target: self.results[indexPath.row]["friend_birth_ymd"] ?? "", start: 0, range: 4)
                let month = Util.substringWithRange(target: self.results[indexPath.row]["friend_birth_ymd"] ?? "", start: 4, range: 2)
                let day = Util.substringWithRange(target: self.results[indexPath.row]["friend_birth_ymd"] ?? "", start: 6, range: 2)
                starNDdiVC.friend_birth_year = year
                starNDdiVC.friend_birth_month = month
                starNDdiVC.friend_birth_day = day
                
                starNDdiVC.friend_birth_time = self.results[indexPath.row]["friend_birth_time"] ?? ""
                starNDdiVC.friend_blood_type = self.results[indexPath.row]["friend_blood"] ?? ""
                
                pvc.present(starNDdiVC, animated: true, completion: nil)
                
            }
        }
    }

}

class FriendListCell: UITableViewCell{
    @IBOutlet var parentView: UIView!
    @IBOutlet var friend_cd: UILabel!
    @IBOutlet var name: UILabel!
    @IBOutlet var genderImage: UIImageView!
    @IBOutlet var birthYMDlbl: UILabel!
    @IBOutlet var bloodTypeImage: UIImageView!
    @IBOutlet var birthTypelbl: UILabel!
    @IBOutlet var birthTimelbl: UILabel!
    
    
}
