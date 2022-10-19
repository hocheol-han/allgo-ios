//
//  BloodNLoveViewController.swift
//  allgo
//
//  Created by 한호철 on 2022/08/02.
//

import UIKit
import Alamofire
import SwiftyJSON

class BloodNLoveViewController: UIViewController {
    @IBOutlet var closeImg: UIImageView!
    @IBOutlet var keywordLbl: UILabel!
    @IBOutlet var keywordImgBar: UIImageView!
    @IBOutlet var keywordContentLbl: UILabel!
    @IBOutlet var contentLbl: UILabel!
    
    var conId:String = ""
    var myBloodType:String = ""
    var fBloodType:String = ""
    var mBloodType:String = ""
    
    var userInfo: UserInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setInit()
    }
    
    func setInit(){
        
        userInfo = UserInfo.shared
        myBloodType = userInfo.memberBlood ?? ""
//        print("myBloodType : \(myBloodType)")
//        print("fBloodType : \(fBloodType)")
//        print("mBloodType : \(mBloodType)")
        
        let closeImgTab = UITapGestureRecognizer(target: self, action: #selector(closeImgClicked))
        closeImg.isUserInteractionEnabled = true
        closeImg.addGestureRecognizer(closeImgTab)
        
        keywordLbl.backgroundColor = Constants.BUTTON_GREEN
        keywordLbl.clipsToBounds = true
        keywordLbl.layer.cornerRadius = 10
        keywordLbl.textColor = Constants.WHITE
        
        keywordImgBar.backgroundColor = Constants.BUTTON_GREEN
        
        var param:[String:String] = [String:String]()
        param = [
                    "father_blood" : fBloodType,
                    "mother_blood" : mBloodType,
                    "my_blood" : myBloodType,
                    "language_code" : Util.getLanguage()
                ]
        getBloodNLove(param: param)
        
    }
    
    func getBloodNLove(param: Dictionary<String,String>){
        let url = Constants.urlPrefix + "/theme/getBloocNLove"
        
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
                        
                        let blood = json["bloods"].arrayValue[0]

                        self.conId = blood["id"].stringValue
                        let keyword = blood["keyword"].stringValue

                        let contents = blood["contents"].stringValue
                        let contents1 = blood["contents1"].stringValue
                        let contents2 = blood["contents2"].stringValue
                        let contents3 = blood["contents3"].stringValue
                        

                        self.keywordContentLbl.text = keyword
                        self.contentLbl.text = contents + "\n" + contents1 + "\n" + contents2 + "\n" + contents3
                    }
                default:
                    return


                }
            }
    }
    
    @objc func closeImgClicked(){
            
        self.dismiss(animated: true, completion: nil)

    }

}
