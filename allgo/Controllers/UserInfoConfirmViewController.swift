//
//  UserInfoConfirmViewController.swift
//  allgo
//
//  Created by 한호철 on 2022/06/02.
//

import UIKit

class UserInfoConfirmViewController: UIViewController {

    var isSocial: Bool = false
    
    @IBOutlet var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if isSocial == true{
            textLabel.text = "이미 등록된 이메일 주소입니다."
        }
        // Do any additional setup after loading the view.
    }
    

    @IBAction func closeUserInfoConfirm(_ sender: UIButton) {
        
        print("closeUserInfoConfirm() called~!")
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clickedConfirmBtn(_ sender: UIButton) {
        
        print("clickedConfirmBtn() called~!")
        self.dismiss(animated: true, completion: nil)
    }
}
