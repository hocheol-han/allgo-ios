//
//  MainPageViewController.swift
//  allgo
//
//  Created by 한호철 on 2022/06/02.
//

import UIKit
import Hero
import Alamofire
import SwiftyJSON

class MainPageViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var currentPos: Int = 0
    @IBOutlet var nexBtn: UIButton!
    @IBOutlet var preBtn: UIButton!
    
//    @IBOutlet var interestingUnseSetBtn: UIImageView!
    @IBOutlet var interestingUnseSetBtn: UIImageView!
    
    @IBOutlet var naviImg: UIImageView!
    @IBOutlet var mainMenuImage: UIImageView!
    @IBOutlet var mainMenuNameLbl: UILabel!
    
    @IBOutlet var todayTapLbl: UILabel!
    @IBOutlet var interestTapLbl: UILabel!
    
    @IBOutlet var todayUnderLineImg: UIImageView!
    @IBOutlet var interestUnderLineImg: UIImageView!
    
    @IBOutlet var todayContentView: UIView!
    var underLines = Array<UIImageView>()
    var curTap: Int = 0
    
    var userInfo: UserInfo!
    
    @IBOutlet var interestUnseTableView: UITableView!
    var interestUnse = Array<String>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setInit()
    }
    
    func setInit(){
        
        userInfo = UserInfo.shared
        
        mainMenuImage.image = UIImage(named: Constants.MAIN_MENU[currentPos])
        mainMenuNameLbl.text = Constants.MAIN_MENU_NAME[currentPos]
        
        todayContentView.isHidden = false
        interestUnseTableView.isHidden = true
        
        interestUnseTableView.rowHeight = 130
        
        if currentPos == 0{
            preBtn.isHidden = true
        }
        
        underLines = [
                        todayUnderLineImg,
                        interestUnderLineImg
        ]
        
        Util.setAllUnderLinesHidden(underLines: underLines)
        underLines[0].isHidden = false
        
        let todayTab = AllgoTapGestureRecognizer(target: self, action: #selector(tabClicked(sender:)))
        todayTapLbl.isUserInteractionEnabled = true
        todayTab.tapGB = 0
        todayTapLbl.addGestureRecognizer(todayTab)
        
        let interestTab = AllgoTapGestureRecognizer(target: self, action: #selector(tabClicked(sender:)))
        interestTapLbl.isUserInteractionEnabled = true
        interestTab.tapGB = 1
        interestTapLbl.addGestureRecognizer(interestTab)
        
        let settingTap = UITapGestureRecognizer(target: self, action: #selector(interestingUnseSetBtnClicked))
        interestingUnseSetBtn.isUserInteractionEnabled = true
        interestingUnseSetBtn.addGestureRecognizer(settingTap)
        
        let naviTap = UITapGestureRecognizer(target: self, action: #selector(naviBtnClicked))
        naviImg.isUserInteractionEnabled = true
        naviImg.addGestureRecognizer(naviTap)
        
        let mainContentTap = UITapGestureRecognizer(target: self, action: #selector(mainContentClicked))
        mainMenuImage.isUserInteractionEnabled = true
        mainMenuImage.addGestureRecognizer(mainContentTap)
        
        getMyInterestUnse()
        
    }
    
    @objc func tabClicked(sender: AllgoTapGestureRecognizer){
        
        curTap = sender.tapGB
        Util.setAllUnderLinesHidden(underLines: underLines)
        underLines[curTap].isHidden = false
        
        if curTap == 0{
            
            todayContentView.isHidden = false
            interestUnseTableView.isHidden = true
            
        }else if curTap == 1{
            
            todayContentView.isHidden = true
            interestUnseTableView.isHidden = false
        }
        
    }
    
    @objc func interestingUnseSetBtnClicked(){
        print("interestingUnseSetBtnClicked() called~!")
        
        let storyboard = UIStoryboard.init(name: "InterestingUnse", bundle: nil)
        let interestingUnseVC = storyboard.instantiateViewController(identifier: "interestingUnse")
        interestingUnseVC.modalTransitionStyle = .coverVertical
        interestingUnseVC.modalPresentationStyle = .overCurrentContext
//        let page = todayUnse as? TodayUnseViewController
//                        page?.param = param
    
        self.present(interestingUnseVC,animated: true,completion: nil)
    }
    
//    @IBAction func clickedTodayUnseBtn(_ sender: Any) {
//
//        print("clickedTodayUnseBtn() called~!")
//
//        let storyboard = UIStoryboard.init(name: "TodayUnse", bundle: nil)
//        let todayUnse = storyboard.instantiateViewController(identifier: "todayUnse")
//        todayUnse.modalTransitionStyle = .coverVertical
//        todayUnse.modalPresentationStyle = .fullScreen
////        let page = todayUnse as? TodayUnseViewController
////                        page?.param = param
//
//        self.present(todayUnse,animated: true,completion: nil)
//    }
    
    @objc func mainContentClicked(){
        
        print("cccccccc")
        let storyboard = UIStoryboard.init(name: "TodayUnse", bundle: nil)
        let todayUnse = storyboard.instantiateViewController(identifier: "todayUnse")
        todayUnse.modalTransitionStyle = .coverVertical
        todayUnse.modalPresentationStyle = .fullScreen
//        let page = todayUnse as? TodayUnseViewController
//                        page?.param = param
    
        self.present(todayUnse,animated: true,completion: nil)
    }
    
    @IBAction func nextBtnClicked(_ sender: Any) {
        
        if currentPos < 3 {
            currentPos = currentPos + 1
            
            if currentPos > 0 {
                preBtn.isHidden = false
            }
            
            if currentPos == 3{
                nexBtn.isHidden = true
            }
        }
        
        
        
        let fadeAnim:CABasicAnimation = CABasicAnimation(keyPath: "contents")


        fadeAnim.fromValue = UIImage(named: Constants.MAIN_MENU[currentPos-1])
        fadeAnim.toValue   = UIImage(named: Constants.MAIN_MENU[currentPos])
        fadeAnim.duration  = 0.8;         //smoothest value

        mainMenuImage.layer.add(fadeAnim, forKey: "contents");
        
        mainMenuImage.image = UIImage(named: Constants.MAIN_MENU[currentPos])
        mainMenuNameLbl.text = Constants.MAIN_MENU_NAME[currentPos]
    }
    
    @IBAction func preBtnClicked(_ sender: UIButton) {
        
        if currentPos > 0 {
            currentPos = currentPos - 1
            
            if currentPos < 3 {
                nexBtn.isHidden = false
            }
            if currentPos == 0 {
                preBtn.isHidden = true
            }
        }
        
        let fadeAnim:CABasicAnimation = CABasicAnimation(keyPath: "contents")


        fadeAnim.fromValue = UIImage(named: Constants.MAIN_MENU[currentPos+1])
        fadeAnim.toValue   = UIImage(named: Constants.MAIN_MENU[currentPos])
        fadeAnim.duration  = 0.8;         //smoothest value

        mainMenuImage.layer.add(fadeAnim, forKey: "contents");
        
        mainMenuImage.image = UIImage(named: Constants.MAIN_MENU[currentPos])
        mainMenuNameLbl.text = Constants.MAIN_MENU_NAME[currentPos]
        
    }
    
//    @IBAction func naviBtnClicked(_ sender: Any) {
//
//        let storyboard = UIStoryboard.init(name: "Navigation", bundle: nil)
//        let todayUnse = storyboard.instantiateViewController(identifier: "navigation")
//        todayUnse.modalTransitionStyle = .coverVertical
//        todayUnse.modalPresentationStyle = .fullScreen
//
//        todayUnse.hero.isEnabled = true
//        todayUnse.hero.modalAnimationType = .selectBy(presenting: .pull(direction: .left), dismissing: .slide(direction: .down))
//        self.present(todayUnse,animated: true,completion: nil)
//
//    }
    
    @objc func naviBtnClicked(){
        
        let storyboard = UIStoryboard.init(name: "Navigation", bundle: nil)
        let todayUnse = storyboard.instantiateViewController(identifier: "navigation")
        todayUnse.modalTransitionStyle = .coverVertical
        todayUnse.modalPresentationStyle = .fullScreen
        
        todayUnse.hero.isEnabled = true
        todayUnse.hero.modalAnimationType = .selectBy(presenting: .pull(direction: .left), dismissing: .slide(direction: .down))
        self.present(todayUnse,animated: true,completion: nil)
        
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
                            self.interestUnse.append(interest["unse_id"].stringValue)
                        }
                        
                        self.interestUnseTableView.reloadData()
                        
                    }
                default:
                    return


                }
            }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.interestUnse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = interestUnseTableView.dequeueReusableCell(withIdentifier: "interestUnseCell",for: indexPath) as? InterestUnseCell else{
            
            print("kkkkkkkk")
            
            return UITableViewCell()
        }
        
        if interestUnse[indexPath.row] == Constants.FORTUNE_COOKIE{
            
            cell.contentImg.image = UIImage(named: "img_fortune_wide_tab_02_item_01_01")
            cell.contentNameLbl.text = Constants.THEME_UNSE_NAME[0]//포춘쿠키
            
        }else if interestUnse[indexPath.row] == Constants.TARO{
            
            cell.contentImg.image = UIImage(named: "img_fortune_wide_tab_02_item_02")
            cell.contentNameLbl.text = Constants.THEME_UNSE_NAME[1]//타로
            
        }else if interestUnse[indexPath.row] == Constants.DREAM{
            
            cell.contentImg.image = UIImage(named: "img_fortune_wide_tab_02_item_03")
            cell.contentNameLbl.text = Constants.THEME_UNSE_NAME[2]//꿈해몽
            
        }else if interestUnse[indexPath.row] == Constants.NAMING{
            
            cell.contentImg.image = UIImage(named: "img_fortune_wide_tab_02_item_04")
            cell.contentNameLbl.text = Constants.THEME_UNSE_NAME[3]//작명/이름풀이
            
        }else if interestUnse[indexPath.row] == Constants.ANIMAL{
            
            cell.contentImg.image = UIImage(named: "img_fortune_wide_tab_02_item_05")
            cell.contentNameLbl.text = Constants.THEME_UNSE_NAME[4]//동물점
            
        }else if interestUnse[indexPath.row] == Constants.FLOWER{
            
            cell.contentImg.image = UIImage(named: "img_fortune_wide_tab_02_item_06")
            cell.contentNameLbl.text = Constants.THEME_UNSE_NAME[5]//탄생화점&꽃점
            
        }else if interestUnse[indexPath.row] == Constants.MIND_CATCH{
            
            cell.contentImg.image = UIImage(named: "img_fortune_wide_tab_02_item_07")
            cell.contentNameLbl.text = Constants.THEME_UNSE_NAME[6]//마음사로잡기
            
        }else if interestUnse[indexPath.row] == Constants.BLOOD_N_LOVE{
            
            cell.contentImg.image = UIImage(named: "img_fortune_wide_tab_02_item_08")
            cell.contentNameLbl.text = Constants.THEME_UNSE_NAME[7]//혈액형&연애
            
        }else if interestUnse[indexPath.row] == Constants.STAR_N_BLOOD{
            
            cell.contentImg.image = UIImage(named: "img_fortune_wide_tab_02_item_09")
            cell.contentNameLbl.text = Constants.THEME_UNSE_NAME[8]//혈액형&별
            
        }else if interestUnse[indexPath.row] == Constants.STAR_STORY{
            
            cell.contentImg.image = UIImage(named: "img_fortune_wide_tab_02_item_10")
            cell.contentNameLbl.text = Constants.THEME_UNSE_NAME[9]//별이야기
            
        }else if interestUnse[indexPath.row] == Constants.STAR_N_CHAR{
            
            cell.contentImg.image = UIImage(named: "img_fortune_wide_tab_02_item_11")
            cell.contentNameLbl.text = Constants.THEME_UNSE_NAME[10]//별자리&띠성격
            
        }else if interestUnse[indexPath.row] == Constants.TOJEONG{
            
            cell.contentImg.image = UIImage(named: "img_fortune_wide_tab_01_item_01")
            cell.contentNameLbl.text = Constants.JUNGTONG_UNSE_NAME[0]//토정비결
            
        }else if interestUnse[indexPath.row] == Constants.SAJU{
            
            cell.contentImg.image = UIImage(named: "img_fortune_wide_tab_01_item_02")
            cell.contentNameLbl.text = Constants.JUNGTONG_UNSE_NAME[1]//사주
            
        }else if interestUnse[indexPath.row] == Constants.GUNGHAP{
            
            cell.contentImg.image = UIImage(named: "img_fortune_wide_tab_01_item_03")
            cell.contentNameLbl.text = Constants.JUNGTONG_UNSE_NAME[2]//궁합
            
        }
        
        return cell
    }
}

class InterestUnseCell: UITableViewCell{
    
    @IBOutlet var contentImg: UIImageView!
    @IBOutlet var contentNameLbl: UILabel!
    
}
