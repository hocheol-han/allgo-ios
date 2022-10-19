//
//  MemberDeleteViewController.swift
//  allgo
//
//  Created by 한호철 on 2022/08/16.
//

import UIKit
import Alamofire
import SwiftyJSON

class MemberDeleteViewController: UIViewController {

    var userInfo: UserInfo!
    var sajuInfo: Dictionary<String,String>!
    
    @IBOutlet var parentView: UIView!
    @IBOutlet var closeImg: UIImageView!
    @IBOutlet var confirmBtn: UIButton!
    @IBOutlet var cancelBtn: UIButton!
    
    var friendId: String = ""
    var memberId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setInit()
    }
    
    func setInit(){
        
        userInfo = UserInfo.shared
        friendId = sajuInfo["id"] ?? ""
        print("friendId : \(friendId)")
        
        parentView.clipsToBounds = true
        parentView.layer.cornerRadius = 20
        
        let closeImgTab = UITapGestureRecognizer(target: self, action: #selector(closeImgClicked))
        closeImg.isUserInteractionEnabled = true
        closeImg.addGestureRecognizer(closeImgTab)
        
        confirmBtn.clipsToBounds = true
        confirmBtn.layer.borderWidth = 1
        confirmBtn.layer.borderColor = Constants.GRAY?.cgColor
        confirmBtn.layer.cornerRadius = 25
        confirmBtn.layer.backgroundColor = Constants.GRAY?.cgColor
//        confirmBtn.setTitleColor(Constants.WHITE, for: .normal)
//        confirmBtn.titleLabel?.textColor = Constants.WHITE
        
        cancelBtn.layer.borderWidth = 1
        cancelBtn.layer.borderColor = Constants.GRAY?.cgColor
        cancelBtn.layer.cornerRadius = 25
        cancelBtn.layer.backgroundColor = Constants.WHITE?.cgColor
//        cancelBtn.setTitleColor(Constants.GRAY, for: .normal)
//        cancelBtn.titleLabel?.textColor = Constants.GRAY

    }
    
    @objc func closeImgClicked(){
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func cancelBtnClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmBtnClicked(_ sender: UIButton) {
        let param : [String: String] = [
            "member_friend_id" : friendId,
            "member_id" : userInfo.memberId ?? "",
        ]
        
        print("friendId 22: \(friendId)")
        memberInfoDelete(param: param)
    }
    func memberInfoDelete(param: Dictionary<String,String>){
        
        let url = Constants.urlPrefix + "/member/memberFriendDelete"
        
        AF.request(url,
                   method: .post,
                   parameters: param,
                   encoding: JSONEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
//                    .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                //여기서 가져온 데이터를 자유롭게 활용하세요.
                print("memberInfoDelete result : \(response.result)")

                switch response.result{

                case .success(let value):
                    let json = JSON(value)
                    print(json["error_number"].stringValue)
                    let errorNumber = json["error_number"].stringValue

                    if errorNumber == Constants.SEARCH_OK{

                        Util.showToast(message: "사주정보가 삭제 되었습니다.", controller: self)

                        
                    }
                default:
                    return


                }
            }
        self.dismiss(animated: true, completion: nil)
    }
}
