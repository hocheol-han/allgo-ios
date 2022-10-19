//
//  RankingAllViewController.swift
//  allgo
//
//  Created by 한호철 on 2022/08/25.
//

import UIKit
import Alamofire
import SwiftyJSON

class RankingAllViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var isTotal:Bool = true
    @IBOutlet var closeImg: UIImageView!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var rankingAllTableView: UITableView!
    @IBOutlet var myRankLbl: UILabel!
    @IBOutlet var totalRankLbl: UILabel!
    @IBOutlet var searchTF: UITextField!
    @IBOutlet var calImg: UIImageView!
    
    var userInfo:UserInfo!
    var myBirthYear:String = ""
    var myBirthMonth:String = ""
    var myBirthDay:String = ""
    
    var rankYearUnseColor:UIColor!
    var isMyYearRank = [Bool]()
    var isMyYearRankPos:Int = 0
    var yearRankings = Array<Dictionary<String,String>>()
    var yearMemberRank:String = ""
    var yearMemberTotalRank:String = ""
    
    var rankTotalUnseColor:UIColor!
    var isMyTotalRank = [Bool]()
    var isMyTotalRankPos:Int = 0
    var totalRankings = Array<Dictionary<String,String>>()
    var totalMemberRank:String = ""
    var totalMemberTotalRank:String = ""
    
    var resetRow = Array<Dictionary<String,String>>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setInit()
    }
    
    func setInit(){
        
        userInfo = UserInfo.shared
        
        let closeImgTab = UITapGestureRecognizer(target: self, action: #selector(closeImgClicked))
        closeImg.isUserInteractionEnabled = true
        closeImg.addGestureRecognizer(closeImgTab)
        
        searchTF.text = myBirthYear + "/" + myBirthMonth + "/" + myBirthDay
        
        let datePickerTab = UITapGestureRecognizer(target: self, action: #selector(datePickerBtnClicked))
        calImg.isUserInteractionEnabled = true
        calImg.addGestureRecognizer(datePickerTab)
        
        let rankingParam : [String: String] = [

            "seek_year" : Util.getYear(),
            "birth_year" : userInfo.memberBirthYear ?? "",
            "birth_month" : userInfo.memberBirthMonth ?? "",
            "birth_day" : userInfo.memberBirthDay ?? "",
            "birth_type" : userInfo.memberBirthTypeGb ?? ""

        ]
        
        if isTotal == true{
            
            titleLbl.text = "전체랭킹"
            getRankingTotal(param: rankingParam)
            
        }else if isTotal == false{
            
            titleLbl.text = "연도별랭킹"
            getRanking(param: rankingParam)
            
        }
    }
    
    @objc func closeImgClicked(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func datePickerBtnClicked(){
        
        print("datePickerBtnClicked ~! called")
        let storyboard = UIStoryboard.init(name: "DatePickerPop", bundle: nil)
        let datePickerPop = storyboard.instantiateViewController(identifier: "datePickerPop")
        datePickerPop.modalTransitionStyle = .coverVertical
        datePickerPop.modalPresentationStyle = .overCurrentContext
        
        self.present(datePickerPop,animated: true,completion: nil)
        
    }
    
    func setBirthDate(year:String,month:String,day:String){
        print("aaaaaaaaaa\(year + "/" + month + "/" + day)")
        searchTF.text = year + "/" + month + "/" + day
        print("year : \(year)")
        
        var currentYear:String = ""
        if isTotal == true{
            currentYear = Util.getYear()
        }else if isTotal == false{
            currentYear = year
        }
        
        let param : [String: String] = [

            "seek_year" : Util.getYear(),
            "birth_year" : year,
            "birth_month" : month,
            "birth_day" : day,
            "birth_type" : Constants.SOLAR

        ]
        
        if isTotal == true{
            getRankingTotal(param: param)
            print("aaaaaa")
        }else if isTotal == false{
            getRanking(param: param)
            print("bbbbbbb")
        }
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
                    self.totalRankings.removeAll()
                    if errorNumber == Constants.SEARCH_OK{
                        
                        let ranks = json["ranking"].arrayValue
                        
                        self.yearMemberTotalRank = String(ranks.count)
                        self.yearMemberRank = json["member_rank"].stringValue

                        let rankGrade = Int(json["member_rank"].stringValue) ?? 0
                        if rankGrade <= 50{

//                            self.rankYearUnseImage = UIImage(named: "img_today_large_good")
//                            self.rankingUnse = Constants.UNSE_GOOD
                            self.rankYearUnseColor = Constants.UNSE_GOOD_COLOR

                        }else if rankGrade >= 315{

//                            self.rankYearUnseImage = UIImage(named: "img_today_large_bad")
//                            self.rankingUnse = Constants.UNSE_BAD
                            self.rankYearUnseColor = Constants.UNSE_BAD_COLOR

                        }else{

//                            self.rankYearUnseImage = UIImage(named: "img_today_large_normal")
//                            self.rankingUnse = Constants.UNSE_NORMAL
                            self.rankYearUnseColor = Constants.UNSE_NORMAL_COLOR

                        }
                        
                        for (index,rank) in ranks.enumerated(){
                            
                            var rankDic = Dictionary<String,String>()
                            if rank["chk"].stringValue == "1"{
                                
                                self.isMyYearRank.append(true)
                                self.isMyYearRankPos = index
                                
                            }else{
                                
                                self.isMyYearRank.append(false)
                                
                            }
                            
                            let year:String = Util.substringWithRange(target: rank["birth"].stringValue, start: 0, range: 4)
                            let month:String = Util.substringWithRange(target: rank["birth"].stringValue, start: 4, range: 2)
                            let day:String = Util.substringWithRange(target: rank["birth"].stringValue, start: 6, range: 2)
                            
                            rankDic.updateValue(year + "." + month + "." + day, forKey: "birth")
                            rankDic.updateValue(rank["rnk"].stringValue, forKey: "rnk")
                            rankDic.updateValue(rank["chk"].stringValue, forKey: "chk")
                            
                            self.yearRankings.append(rankDic)
                            
                            self.rankingAllTableView.reloadData()
                            let indexPath = IndexPath(row:self.isMyYearRankPos,section: 0)
                            self.rankingAllTableView.scrollToRow(at: indexPath, at: .top, animated: true)
//                            print("rankings.count : \(self.yearRankings.count)")
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
//                        self.totalRankNum = String(ranks.count)
//                        self.totalRankLbl.text = self.totalRankNum
//                        self.memberRankTotal = json["member_rank"].stringValue
//
//                        self.memberRankLbl.text = self.memberRankTotal
                        let rankGrade = Int(json["member_rank"].stringValue) ?? 0
                        print("rankGrade : \(rankGrade)")
                        
                        if rankGrade <= 5000{
                            
                            print("aaaaa")
                            self.rankTotalUnseColor = Constants.UNSE_GOOD_COLOR
//                            self.memberRankLbl.textColor = self.rankTotalUnseColor
//                            self.rankingTotalUnseColor =  Constants.UNSE_GOOD
                            
                        }else if rankGrade >= 35000{
                            
                            print("bbbbbb")
//                            self.rankTotalUnseImage = UIImage(named: "img_today_large_bad")
//                            self.emojiImg.image = self.rankTotalUnseImage
                            self.rankTotalUnseColor = Constants.UNSE_BAD_COLOR
//                            self.memberRankLbl.textColor = self.rankTotalUnseColor
//                            self.rankingTotalUnse = Constants.UNSE_BAD
                            
                        }else{
                            print("ccccccc")
//                            self.rankTotalUnseImage = UIImage(named: "img_today_large_normal")
//                            self.emojiImg.image = self.rankTotalUnseImage
                            self.rankTotalUnseColor = Constants.UNSE_NORMAL_COLOR
//                            self.memberRankLbl.textColor = self.rankTotalUnseColor
//                            self.rankingTotalUnse = Constants.UNSE_NORMAL
                            
                        }
//                        self.totalStartYear = json["min_year"].stringValue
//                        self.totalEndYear = json["max_year"].stringValue
//                        self.periodLbl.text = self.totalStartYear + "년도" + "~" + self.totalEndYear + "년도 랭킹 순위"
                    
                        
                        for (index,rank) in ranks.enumerated(){
                            
                            var rankTotal = Dictionary<String,String>()
                            if rank["chk"].stringValue == "1"{
                                
                                self.isMyTotalRank.append(true)
                                self.isMyTotalRankPos = index
                                print("index : \(index)")
//                                print("\(self.myTotalRank.count)")
//                                print("\(self.myTotalRankPos)")
                                
//                                self.myBirth = rank["birth"].stringValue
//                                self.myBirthYear = Util.substringWithRange(target: self.myBirth, start: 0, range: 4)
//                                self.myBirthMonth = Util.substringWithRange(target: self.myBirth, start: 4, range: 2)
//                                self.myBirthDay = Util.substringWithRange(target: self.myBirth, start: 6, range: 2)
//                                print("year : \(year)")
//                                print("month : \(month)")
//                                print("day : \(day)")
//                                self.memberBirthLbl.text = self.myBirthYear + "년" + self.myBirthMonth + "월" + self.myBirthDay + "일"
                                
                            }else{
                                
                                self.isMyTotalRank.append(false)
                                
                            }
                            
                            var year:String = Util.substringWithRange(target: rank["birth"].stringValue, start: 0, range: 4)
                            var month:String = Util.substringWithRange(target: rank["birth"].stringValue, start: 4, range: 2)
                            var day:String = Util.substringWithRange(target: rank["birth"].stringValue, start: 6, range: 2)
                            
                            rankTotal.updateValue(year + "." + month + "." + day, forKey: "birth")
                            rankTotal.updateValue(rank["rnk"].stringValue, forKey: "rnk")
                            rankTotal.updateValue(rank["chk"].stringValue, forKey: "chk")
                            
                            self.totalRankings.append(rankTotal)
                        }
                        
                        self.rankingAllTableView.reloadData()
                        var indexPath = IndexPath(row:self.isMyTotalRankPos,section: 0)
                        self.rankingAllTableView.scrollToRow(at: indexPath, at: .top, animated: true)
                        
//                        print("count : \(self.myTotalRank.count)")
                    }
                default:
                    return


                }
            }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var result:Int = 0
        
        if self.isTotal == true{
            result = totalRankings.count
        }else if self.isTotal == false{
            result = yearRankings.count
        }
        
        return result
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.rankingAllTableView.dequeueReusableCell(withIdentifier: "rankingAllListCell",for: indexPath) as? RankingAllListCell else{

            return UITableViewCell()
        }
        
       
        if isTotal == true{
            
            if self.isMyTotalRank[indexPath.row] == true{
                print("kkkkkkk")
                cell.parentView.backgroundColor = rankTotalUnseColor
            }else{
                cell.parentView.backgroundColor = Constants.WHITE
            }
            cell.rankLbl.text = self.totalRankings[indexPath.row]["rnk"] ?? ""
            cell.birthLbl.text = self.totalRankings[indexPath.row]["birth"] ?? ""
            
        }else if isTotal == false{
            
            if self.isMyYearRank[indexPath.row] == true{
                cell.parentView.backgroundColor = rankYearUnseColor
            }else{
                cell.parentView.backgroundColor = Constants.WHITE
            }
            cell.rankLbl.text = self.yearRankings[indexPath.row]["rnk"] ?? ""
            cell.birthLbl.text = self.yearRankings[indexPath.row]["birth"] ?? ""
        }
        
        
        return cell
    }
}


class RankingAllListCell: UITableViewCell{
    
    @IBOutlet var parentView: UIView!
    @IBOutlet var rankLbl: UILabel!
    @IBOutlet var birthLbl: UILabel!
    
}
