//
//  TodayUnseViewController.swift
//  allgo
//
//  Created by 한호철 on 2022/06/03.
//

import UIKit

class TodayUnseViewController: UIViewController {

    var todayUnse: TodayUnse!
    
    @IBOutlet var todayDirection: UIImageView!
    @IBOutlet var todayColor: UIImageView!
    @IBOutlet var todayNumber: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        todayUnse = TodayUnse.shared
        print("number : \(self.todayUnse.todayNumber ?? "")")
        print("direction : \(self.todayUnse.todayDirection ?? "")")
        
        print(Util.returnArrow(dir: self.todayUnse.todayDirection ?? ""))
        self.setTodayUnse()
    }
    
    func setTodayUnse(){
        
        todayDirection.image = UIImage(named: Util.returnArrow(dir: self.todayUnse.todayDirection ?? ""))
        todayColor.image = UIImage(named: Util.returnColor(color: self.todayUnse.todayColor ?? ""))
        todayNumber.text = self.todayUnse.todayNumber
        
    }

    @IBAction func seeMyUnseClicked(_ sender: UIButton) {
        
        let storyboard = UIStoryboard.init(name: "TodayUnseDetail", bundle: nil)
        let todayUnseDetail = storyboard.instantiateViewController(identifier: "todayUnseDetail")
        todayUnseDetail.modalTransitionStyle = .coverVertical
        todayUnseDetail.modalPresentationStyle = .fullScreen
        let page = todayUnseDetail as? TodayUnseDetailViewController
//                        page?.param = param
    
        self.present(todayUnseDetail,animated: true,completion: nil)
    }
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
