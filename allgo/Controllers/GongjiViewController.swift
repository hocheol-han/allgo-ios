//
//  GongjiViewController.swift
//  allgo
//
//  Created by 한호철 on 2022/08/16.
//

import UIKit
import Alamofire
import SwiftyJSON

class GongjiViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet var gongjiListTableView: UITableView!
    
    var gongjis = Array<Dictionary<String,String>>()
    var isClicked = Array<Bool>()
    @IBOutlet var menuImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setInit()
    }
    
    func setInit(){
        
        let menuTap = UITapGestureRecognizer(target: self, action: #selector(menuClicked))
        menuImg.isUserInteractionEnabled = true
        menuImg.addGestureRecognizer(menuTap)
        
        var param: Dictionary<String,String> = [
            
            "board_id" : "",
            "board_search" : "",
            "board_cd" : Constants.BOARD_CD_NOTICE,
            "language_gb" : Util.getLanguage()
            
        ]
        
        getNoticeList(param: param)
        
    }
    
   
    @objc func menuClicked(){
        
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
    
    func getNoticeList(param: Dictionary<String,String>){
        let url = Constants.urlPrefix + "/board/getNoticeList"
        
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
                        
                        var gongjiList = json["notices"].arrayValue
                        for element in gongjiList {
                            
                            self.isClicked.append(false)
                            
                            var gongji = Dictionary<String,String>()
                            gongji.updateValue(element["title"].stringValue, forKey: "title")
                            gongji.updateValue(element["boardday"].stringValue, forKey: "boardday")
                            gongji.updateValue(element["memo"].stringValue, forKey: "memo")
                            gongji.updateValue(element["writeday"].stringValue, forKey: "writeday")
                            self.gongjis.append(gongji)
                        }
                        print("isClicked : \(self.isClicked.count)")
                        self.gongjiListTableView.reloadData()
                        
                    }
                default:
                    return


                }
            }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.gongjis.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = gongjiListTableView.dequeueReusableCell(withIdentifier: "gongjiListCell",for: indexPath) as? GongjiListCell else{
            
            return UITableViewCell()
        }
        
        cell.titleLbl.text = gongjis[indexPath.row]["title"] ?? ""
        cell.dateLbl.text = gongjis[indexPath.row]["boardday"] ?? ""
        cell.contentLbl.text = gongjis[indexPath.row]["memo"] ?? ""
        
        if isClicked[indexPath.row] == true{
            cell.contentPView.isHidden = false
        }else{
            cell.contentPView.isHidden = true
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           print("aaaaaaa")
        var i = 0
        while i < isClicked.count{
            isClicked[i] = false
            i = i + 1
        }
        isClicked[indexPath.row] = true
        self.gongjiListTableView.reloadData()
        
    }

}

class GongjiListCell: UITableViewCell{
    
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var dateLbl: UILabel!
    @IBOutlet var contentLbl: UILabel!
    @IBOutlet var contentPView: UIView!
    
    
}
