//
//  RankingViewController.swift
//  allgo
//
//  Created by 한호철 on 2022/08/19.
//

import UIKit
import Alamofire
import SwiftyJSON

class RankingViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet var totalTabLbl: UILabel!
    @IBOutlet var totalUnderLineImg: UIImageView!
    
    @IBOutlet var yearTabLbl: UILabel!
    @IBOutlet var yearUnderLineImg: UIImageView!
    
    var underLines = Array<UIImageView>()
    
    var selectedTabNum:Int = 0
    var selectedTotal:Int = 0
    var selectedYear:Int = 1
    var selectedReset:Int = 0
    
    var userInfo: UserInfo!
    @IBOutlet var closeImg: UIImageView!
    @IBOutlet var totalRankLbl: UILabel!
    @IBOutlet var memberRankLbl: UILabel!
    @IBOutlet var periodLbl: UILabel!
    @IBOutlet var memberBirthLbl: UILabel!
    @IBOutlet var emojiImg: UIImageView!
    @IBOutlet var rankingTotalTableView: UITableView!
    @IBOutlet var showBtnImg: UILabel!
    
    var resetRow = Array<Dictionary<String,String>>()
    
    var rankings = Array<Dictionary<String,String>>()
    var rankingUnse: Int = Constants.UNSE_GOOD
    var memberRank: String = ""
    var myRank = [Bool]()
    var myRankPos:Int = 0
    var yearTotalRankNum:String = ""
    
    var myBirth: String = ""
    
    var myBirthYear: String = ""
    var myBirthMonth: String = ""
    var myBirthDay: String = ""
    
    var rankTotalUnseColor:UIColor!
    var rankYearUnseColor:UIColor!
    
    var rankTotalUnseImage:UIImage!
    var rankYearUnseImage:UIImage!
    
    var rankingTotals = Array<Dictionary<String,String>>()
    var rankingTotalUnse: Int = Constants.UNSE_GOOD
    var memberRankTotal: String = ""
    
    var myTotalRank = [Bool]()
    var myTotalRankPos:Int = 0
    var totalRankNum: String = ""
    var totalRankUnseColor:UIColor!
    var totalStartYear:String = ""
    var totalEndYear:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInit()
    }
    func setInit(){
        
        userInfo = UserInfo.shared
        
        underLines = [
                        totalUnderLineImg,
                        yearUnderLineImg
                    ]
        Util.setAllUnderLinesHidden(underLines: underLines)
        underLines[selectedTabNum].isHidden = false
        
        let closeImgTab = UITapGestureRecognizer(target: self, action: #selector(closeImgClicked))
        closeImg.isUserInteractionEnabled = true
        closeImg.addGestureRecognizer(closeImgTab)
        
        let totalTab = AllgoTapGestureRecognizer(target: self, action: #selector(tabClicked(sender:)))
        totalTabLbl.isUserInteractionEnabled = true
        totalTab.tapGB = 0
        totalTabLbl.addGestureRecognizer(totalTab)
        
        let yearTab = AllgoTapGestureRecognizer(target: self, action: #selector(tabClicked(sender:)))
        yearTabLbl.isUserInteractionEnabled = true
        yearTab.tapGB = 1
        yearTabLbl.addGestureRecognizer(yearTab)
        
        showBtnImg.layer.borderWidth = 1
        showBtnImg.layer.borderColor = Constants.GRAY?.cgColor
        showBtnImg.clipsToBounds = true
        showBtnImg.layer.cornerRadius = 10
        
        let showTab = AllgoTapGestureRecognizer(target: self, action: #selector(showClicked(sender:)))
        showBtnImg.isUserInteractionEnabled = true
        showTab.tapGB = 1
        showBtnImg.addGestureRecognizer(showTab)
        
        rankingTotalTableView.decelerationRate = UIScrollView.DecelerationRate.fast
        
//        print("year : \(Util.getYear())")
        
        let rankingParam : [String: String] = [

            "seek_year" : Util.getYear(),
            "birth_year" : userInfo.memberBirthYear ?? "",
            "birth_month" : userInfo.memberBirthMonth ?? "",
            "birth_day" : userInfo.memberBirthDay ?? "",
            "birth_type" : userInfo.memberBirthTypeGb ?? ""

        ]
        
        getRanking(param: rankingParam)
        
        let rankingTotalParam : [String: String] = [

            "seek_year" : Util.getYear(),
            "birth_year" : userInfo.memberBirthYear ?? "",
            "birth_month" : userInfo.memberBirthMonth ?? "",
            "birth_day" : userInfo.memberBirthDay ?? "",
            "birth_type" : userInfo.memberBirthTypeGb ?? ""

        ]
        
        getRankingTotal(param: rankingTotalParam)
    
    }
    
    @objc func closeImgClicked(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func tabClicked(sender: AllgoTapGestureRecognizer){
        
        if selectedTabNum == sender.tapGB{
            return
        }
        selectedTabNum = selectedReset
        rankingTotalTableView.reloadData()
        
        selectedTabNum = sender.tapGB
        Util.setAllUnderLinesHidden(underLines: underLines)
        print("selectedTabNum : \(selectedTabNum)")
        underLines[selectedTabNum].isHidden = false

        if selectedTabNum == selectedTotal{
            
            self.totalRankLbl.text = self.totalRankNum //전체랭킹
            self.memberRankLbl.text = self.memberRankTotal //내 랭킹
            
            self.emojiImg.image = rankTotalUnseImage
            self.memberRankLbl.textColor = rankTotalUnseColor
                
            self.periodLbl.text = self.totalStartYear + "년도" + "~" + self.totalEndYear + "년도 랭킹 순위"
            
            let indexPath = IndexPath(row:self.myTotalRankPos,section: 0)
            self.rankingTotalTableView.scrollToRow(at: indexPath, at: .top, animated: true)
            rankingTotalTableView.reloadData()
            
        }else if selectedTabNum == selectedYear{
//            print("memberRank\(memberRank)")
//            print("yearTotalRankNum\(yearTotalRankNum)"
            
            self.totalRankLbl.text = self.yearTotalRankNum //전체랭킹
            self.memberRankLbl.text = self.memberRank //내 랭킹
            
            self.emojiImg.image = rankYearUnseImage
            self.memberRankLbl.textColor = rankYearUnseColor
                
            self.periodLbl.text = "내가 태어난 연도 랭킹 순위"
            
            let indexPath = IndexPath(row:self.myRankPos,section: 0)
            self.rankingTotalTableView.scrollToRow(at: indexPath, at: .top, animated: true)
            rankingTotalTableView.reloadData()
           
        }
        
    }
    
    @objc func showClicked(sender: AllgoTapGestureRecognizer){
        
        let storyboard = UIStoryboard.init(name: "RankingAll", bundle: nil)
        guard let rankingAllVC = storyboard.instantiateViewController(identifier: "rankingAll") as? RankingAllViewController else{
            return
        }
        rankingAllVC.modalTransitionStyle = .coverVertical
        rankingAllVC.modalPresentationStyle = .fullScreen
//        let page = todayUnse as? TodayUnseViewController
//                        page?.param = param
        if selectedTabNum == selectedTotal{
            rankingAllVC.isTotal = true
        }else if selectedTabNum == selectedYear{
            rankingAllVC.isTotal = false
        }
        rankingAllVC.myBirthYear = myBirthYear
        rankingAllVC.myBirthMonth = myBirthMonth
        rankingAllVC.myBirthDay = myBirthDay
    
        self.present(rankingAllVC,animated: true,completion: nil)
    }
    
    func getRanking(param: Dictionary<String,String>){
        
        let url = Constants.urlPrefix + "/unse/getRanking"
        
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
                        
                        let ranks = json["ranking"].arrayValue
                        
                        self.yearTotalRankNum = String(ranks.count)
                        self.memberRank = json["member_rank"].stringValue
                        print("memberRank : \(self.memberRank)")
                        
                        let rankGrade = Int(self.memberRank) ?? 0
//                        print("rankGrade : \(rankGrade ?? 0)")
                        
                        if rankGrade <= 50{
                            
                            self.rankYearUnseImage = UIImage(named: "img_today_large_good")
                            self.rankingUnse = Constants.UNSE_GOOD
                            self.rankYearUnseColor = Constants.UNSE_GOOD_COLOR
                            
                        }else if rankGrade >= 315{
                            
                            self.rankYearUnseImage = UIImage(named: "img_today_large_bad")
                            self.rankingUnse = Constants.UNSE_BAD
                            self.rankYearUnseColor = Constants.UNSE_BAD_COLOR
                            
                        }else{
                            
                            self.rankYearUnseImage = UIImage(named: "img_today_large_normal")
                            self.rankingUnse = Constants.UNSE_NORMAL
                            self.rankYearUnseColor = Constants.UNSE_NORMAL_COLOR
                            
                        }
                        
                        for (index,rank) in ranks.enumerated(){
                            
                            var rankDic = Dictionary<String,String>()
                            if rank["chk"].stringValue == "1"{
                                
                                self.myRank.append(true)
                                self.myRankPos = index
                                
                            }else{
                                
                                self.myRank.append(false)
                                
                            }
                            
                            let year:String = Util.substringWithRange(target: rank["birth"].stringValue, start: 0, range: 4)
                            let month:String = Util.substringWithRange(target: rank["birth"].stringValue, start: 4, range: 2)
                            let day:String = Util.substringWithRange(target: rank["birth"].stringValue, start: 6, range: 2)
                            
                            rankDic.updateValue(year + "." + month + "." + day, forKey: "birth")
                            rankDic.updateValue(rank["rnk"].stringValue, forKey: "rnk")
                            rankDic.updateValue(rank["chk"].stringValue, forKey: "chk")
                            
                            self.rankings.append(rankDic)
                            print("rankings.count : \(self.rankings.count)")
                        }
                    }
                default:
                    return


                }
            }
    }
    
    func getRankingTotal(param: Dictionary<String,String>){
        
        let url = Constants.urlPrefix + "/unse/getRankingTotal"
        
        AF.request(url,
                   method: .post,
                   parameters: param,
                   encoding: JSONEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
//                    .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                //여기서 가져온 데이터를 자유롭게 활용하세요.
//                print("kkkkkkkkkkk : \(response)")

                switch response.result{

                case .success(let value):
                    let json = JSON(value)
                    print(json["error_number"].stringValue)
                    let errorNumber = json["error_number"].stringValue

                    if errorNumber == Constants.SEARCH_OK{
                        
                        let ranks = json["ranking"].arrayValue
                        self.totalRankNum = String(ranks.count)
                        self.totalRankLbl.text = self.totalRankNum
                        self.memberRankTotal = json["member_rank"].stringValue
                        
                        self.memberRankLbl.text = self.memberRankTotal
                        let rankGrade = Int(self.memberRankTotal) ?? 0
//                        print("rankGrade : \(rankGrade ?? 0)")
                        
                        if rankGrade <= 5000{
                            
                            self.rankTotalUnseImage = UIImage(named: "img_today_large_good")
                            self.emojiImg.image = self.rankTotalUnseImage
                            self.rankTotalUnseColor = Constants.UNSE_GOOD_COLOR
                            self.memberRankLbl.textColor = self.rankTotalUnseColor
                            self.rankingTotalUnse =  Constants.UNSE_GOOD
                            
                        }else if rankGrade >= 35000{
                            
                            self.rankTotalUnseImage = UIImage(named: "img_today_large_bad")
                            self.emojiImg.image = self.rankTotalUnseImage
                            self.rankTotalUnseColor = Constants.UNSE_BAD_COLOR
                            self.memberRankLbl.textColor = self.rankTotalUnseColor
                            self.rankingTotalUnse = Constants.UNSE_BAD
                            
                        }else{
                            
                            self.rankTotalUnseImage = UIImage(named: "img_today_large_normal")
                            self.emojiImg.image = self.rankTotalUnseImage
                            self.rankTotalUnseColor = Constants.UNSE_NORMAL_COLOR
                            self.memberRankLbl.textColor = self.rankTotalUnseColor
                            self.rankingTotalUnse = Constants.UNSE_NORMAL
                            
                        }
                        self.totalStartYear = json["min_year"].stringValue
                        self.totalEndYear = json["max_year"].stringValue
                        self.periodLbl.text = self.totalStartYear + "년도" + "~" + self.totalEndYear + "년도 랭킹 순위"
                        
                        for (index,rank) in ranks.enumerated(){
                            
                            var rankTotal = Dictionary<String,String>()
                            if rank["chk"].stringValue == "1"{
                                
                                self.myTotalRank.append(true)
                                self.myTotalRankPos = index
//                                print("\(self.myTotalRank.count)")
//                                print("\(self.myTotalRankPos)")
                                
                                self.myBirth = rank["birth"].stringValue
                                self.myBirthYear = Util.substringWithRange(target: self.myBirth, start: 0, range: 4)
                                self.myBirthMonth = Util.substringWithRange(target: self.myBirth, start: 4, range: 2)
                                self.myBirthDay = Util.substringWithRange(target: self.myBirth, start: 6, range: 2)
//                                print("year : \(year)")
//                                print("month : \(month)")
//                                print("day : \(day)")
                                self.memberBirthLbl.text = self.myBirthYear + "년" + self.myBirthMonth + "월" + self.myBirthDay + "일"
                                
                            }else{
                                
                                self.myTotalRank.append(false)
                                
                            }
                            
                            let year:String = Util.substringWithRange(target: rank["birth"].stringValue, start: 0, range: 4)
                            let month:String = Util.substringWithRange(target: rank["birth"].stringValue, start: 4, range: 2)
                            let day:String = Util.substringWithRange(target: rank["birth"].stringValue, start: 6, range: 2)
                            
                            rankTotal.updateValue(year + "." + month + "." + day, forKey: "birth")
                            rankTotal.updateValue(rank["rnk"].stringValue, forKey: "rnk")
                            rankTotal.updateValue(rank["chk"].stringValue, forKey: "chk")
                            
                            self.rankingTotals.append(rankTotal)
                        }
                        self.rankingTotalTableView.reloadData()
                        let indexPath = IndexPath(row:self.myTotalRankPos,section: 0)
                        self.rankingTotalTableView.scrollToRow(at: indexPath, at: .top, animated: true)
                        
                        print("count : \(self.myTotalRank.count)")
                    }
                default:
                    return


                }
            }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var result:Int = 0
        if self.selectedTabNum == selectedTotal{
            result = rankingTotals.count
        }else if self.selectedTabNum == selectedYear{
            result = rankings.count
        }else if self.selectedTabNum == selectedReset{
            result = resetRow.count
        }
        
        return result
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.rankingTotalTableView.dequeueReusableCell(withIdentifier: "rankingTotalListCell",for: indexPath) as? RankingTotalListCell else{

            return UITableViewCell()
        }

        if selectedTabNum == selectedTotal{
            
            if self.myTotalRank[indexPath.row] == true{
                cell.cellView.backgroundColor = rankTotalUnseColor
            }else{
                cell.cellView.backgroundColor = Constants.WHITE
            }
            cell.rankingTotalRankLbl.text = self.rankingTotals[indexPath.row]["rnk"] ?? ""
            cell.rankTotalBirthLbl.text = self.rankingTotals[indexPath.row]["birth"] ?? ""
            
        }else if selectedTabNum == selectedYear{
            
            if self.myRank[indexPath.row] == true{
                cell.cellView.backgroundColor = rankYearUnseColor
            }else{
                cell.cellView.backgroundColor = Constants.WHITE
            }
            cell.rankingTotalRankLbl.text = self.rankings[indexPath.row]["rnk"] ?? ""
            cell.rankTotalBirthLbl.text = self.rankings[indexPath.row]["birth"] ?? ""
            
        }
        return cell
    }
}

class RankingTotalListCell: UITableViewCell{
    
    @IBOutlet var cellView: UIView!
    @IBOutlet var rankingTotalRankLbl: UILabel!
    @IBOutlet var rankTotalBirthLbl: UILabel!
    
}

