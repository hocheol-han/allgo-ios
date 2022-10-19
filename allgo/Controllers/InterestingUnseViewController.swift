//
//  InterestingUnseViewController.swift
//  allgo
//
//  Created by 한호철 on 2022/06/07.
//

import UIKit
import Alamofire
import SwiftyJSON

class InterestingUnseViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet var closeBtn: UIImageView!
    @IBOutlet var interestingUnseTableView: UITableView!

    var userInfo: UserInfo!
    
    var unseNames = [String]()
    var unseId = [String]()
    var myInterestUnseId = [String]()
    var regUnses = [Bool]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setInitData()
    }
    
    func setInitData(){
        let settingTap = UITapGestureRecognizer(target: self, action: #selector(closeBtnClicked))
        closeBtn.isUserInteractionEnabled = true
        closeBtn.addGestureRecognizer(settingTap)
        
        userInfo    = UserInfo.shared
        
        getInterestingUnse()
    }
    
    func getInterestingUnse(){
        
        print("getInterestingUnse() called~!")
        print(UserDefaults.standard.string(forKey: (self.userInfo.memberId ?? "") + "language_code") ?? /*Util.getLanguage()*/"ko")
        
        let langStr = Locale.current.languageCode
        print("\(langStr)")
        
        let memberId: String = userInfo.memberId ?? ""
        let key: String = memberId + "language_code"
        
        print("key : \(key)")
        print("languageCode : \(Util.getLanguage())")
        
        let param : [String: Any] = [
            "language_value" :UserDefaults.standard.string(forKey: key) ?? /*Util.getLanguage()*/"ko",
            "service_yn" : "Y",
            "type_category_id" : "",
            "category_id" : "",
            "group_id" : "i",
            "unse_nm" : ""
        ]
        
        print("language code : \(UserDefaults.standard.string(forKey: "language_code") ?? "")")
        
        let url = Constants.urlPrefix + "/unse/getUnseList"
        
        AF.request(url,
                   method: .post,
                   parameters: param,
                   encoding: JSONEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
//                    .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                //여기서 가져온 데이터를 자유롭게 활용하세요.
                print(response.result)
                
                switch response.result{
                    
                case .success(let value):
                    let json = JSON(value)
                    print(json["error_number"].stringValue)
                    let errorNumber = json["error_number"].stringValue
                    
                    if errorNumber == Constants.SEARCH_OK{
                        
                        var unseList = json["unseList"].arrayValue
                        
                        for unse in unseList {
                            self.unseNames.append(unse["unse_nm"].stringValue)
                            self.unseId.append(unse["id"].stringValue)
                        }
                        
                        print("unseNames.count : \(self.unseNames.count)")
                        print("\(self.unseNames)")
                        
                        for unse in unseList{
                            self.regUnses.append(false)
                        }
                        self.interestingUnseTableView.reloadData()
                        self.getMyInterestUnse()
                        
                    }
                default:
                    return
                    
                     
                }
            }
    }
    
    func getMyInterestUnse(){
        let param : [String: Any] = [
            "member_id" : self.userInfo.memberId ?? "",
            "search_keyword" : "",
            "language_code" :UserDefaults.standard.string(forKey: (self.userInfo.memberId ?? "") + "language_code") ?? /*Util.getLanguage()*/"ko"
        ]
        
        print(UserDefaults.standard.string(forKey: (self.userInfo.memberId ?? "") + "language_code") ?? /*Util.getLanguage()*/"ko")
        
        let url = Constants.urlPrefix + "/interest/getMyinterest"
        
        AF.request(url,
                   method: .post,
                   parameters: param,
                   encoding: JSONEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
//                    .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                //여기서 가져온 데이터를 자유롭게 활용하세요.
                print("myInterestUnse : \(response.result)")

                switch response.result{

                case .success(let value):
                    let json = JSON(value)
                    print(json["error_number"].stringValue)
                    let errorNumber = json["error_number"].stringValue

                    if errorNumber == Constants.SEARCH_OK{

                        let interests = json["interest"].arrayValue
                        for interest in interests {
                            self.myInterestUnseId.append(interest["unse_id"].stringValue)
                        }
                        
//                        print(self.myInterestUnseId.count)
                        
                        for (index,id) in self.unseId.enumerated(){
                            self.regUnses[index] = false
                            for regId in self.myInterestUnseId{
                                
                                if id == regId{
                                    self.regUnses[index] = true
                                }
                            }
                        }
                        
                        print("regUnses : \(self.regUnses)")
                        self.interestingUnseTableView.reloadData()
                        
                    }
                default:
                    return


                }
            }
    }
    
    @IBAction func confirmBtnClicked(_ sender: UIButton) {
        print("confirmBtnClicked() called~!!")
        var selectedUnse: String = ""
        for (index,unse) in regUnses.enumerated(){
            if unse == true{
                if index == 0{
                    selectedUnse = unseId[index]
                }else{
                    selectedUnse = selectedUnse + "," + unseId[index]
                }
            }
        }
        
        print("selectedUnse : \(selectedUnse)")
        print("memberId : \(self.userInfo.memberId ?? "")")
        
        let param : [String: Any] = [
            "member_id" : self.userInfo.memberId ?? "",
            "unse_id" : selectedUnse
        ]
        
        let url = Constants.urlPrefix + "/interest/setMyinterest"
        
        AF.request(url,
                   method: .post,
                   parameters: param,
                   encoding: JSONEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
//                    .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                //여기서 가져온 데이터를 자유롭게 활용하세요.
                print("kkkkkkkkkkk : \(response.result)")

                switch response.result{

                case .success(let value):
                    let json = JSON(value)
                    print(json["error_number"].stringValue)
                    let errorNumber = json["error_number"].stringValue

                    if errorNumber == Constants.SEARCH_OK{
                        self.dismiss(animated: true, completion: nil)
                        
                    }
                default:
                    return


                }
            }
        
    }
    @objc func closeBtnClicked(){
    
        print("closeBtnClicked() called")
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return unseNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = interestingUnseTableView.dequeueReusableCell(withIdentifier: "interestingUnseCell",for: indexPath) as? InterestingUnseCell else{
            return UITableViewCell()
        }
        cell.interestingUnseTitle.text = unseNames[indexPath.row]
        if self.regUnses[indexPath.row] == true{
            cell.interestingUnseCheck.image = UIImage(named: "ic_check_chk_s")
        }else{
            cell.interestingUnseCheck.image = UIImage(named: "ic_check_nor_s")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("IndexPath : \(indexPath.row)")
        self.regUnses[indexPath.row] = !self.regUnses[indexPath.row]
        self.interestingUnseTableView.reloadData()
        
    }

}

//extension InterestingUnseViewController: UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return tableViewItems.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = interestingUnseTableView.dequeueReusableCell(withIdentifier: "interestingUnseCell",for:indexPath)
//        cell.textLabel?.text = tableViewItems[indexPath.row]
//        return cell
//    }
//}

class InterestingUnseCell: UITableViewCell{
    
    @IBOutlet var interestingUnseTitle: UILabel!
    @IBOutlet var interestingUnseCheck: UIImageView!
}

