//
//  PhoneNoViewController.swift
//  allgo
//
//  Created by 한호철 on 2022/09/19.
//

import UIKit
import Alamofire
import SwiftyJSON

class PhoneNoViewController: UIViewController {

    @IBOutlet var parentView: UIView!
    @IBOutlet var closeImg: UIImageView!
    @IBOutlet var countryCodeLbl: UILabel!
    
    var codes = Array<Dictionary<String,String>>()
    var myCode = ""
    var myCodeName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setInit()
    }
    
    func setInit(){
        
        print("national Code : \(Util.getMyCountryCode())")
        
        parentView.layer.cornerRadius = 20
        
        let closeBtnTab = UITapGestureRecognizer(target: self, action: #selector(closeBtnClicked))
        closeImg.isUserInteractionEnabled = true
        closeImg.addGestureRecognizer(closeBtnTab)
        
        let countryCodeLblTab = UITapGestureRecognizer(target: self, action: #selector(countryCodeLblClicked))
        countryCodeLbl.isUserInteractionEnabled = true
        countryCodeLbl.addGestureRecognizer(countryCodeLblTab)
        
        var param: Dictionary<String,String> = [
            "id" : "",
            "order_query" : ""
        ]
        
        getCountryCode(param: param)
    }
    
    @objc func closeBtnClicked(){
        
        self.dismiss(animated: true,completion: nil)
    }
    
    @objc func countryCodeLblClicked(){
        
    }
    
    func getCountryCode(param: Dictionary<String,String>){
        
        let url = Constants.urlPrefix + "/member/getCountryCode"
        
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
                        
                        var myCode = Util.getMyCountryCode()
                        var codeArray = json["codes"].arrayValue
                        for element in codeArray {

                            var code = Dictionary<String,String>()
                            code.updateValue(element["country_phone_no"].stringValue, forKey: "code")
                            code.updateValue(element["country_nm"].stringValue, forKey: "name")
                            if element["id"].stringValue == myCode{
                                
                                self.countryCodeLbl.text = "+" + element["country_phone_no"].stringValue
                                self.myCode = element["country_phone_no"].stringValue
                                self.myCodeName = element["country_nm"].stringValue
                            }
                            
                            self.codes.append(code)
                        }
                        
                    }
                default:
                    return


                }
            }
        
        
    }


}
