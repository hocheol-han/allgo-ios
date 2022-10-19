//
//  SangsiPopViewController.swift
//  allgo
//
//  Created by 한호철 on 2022/06/29.
//

import UIKit

class SangsiPopViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet var parentView: UIView!
    @IBOutlet var closeBtn: UIImageView!
    @IBOutlet var sangsiTableView: UITableView!
    
    var checkSangsi = [Bool()]
    var checkedSangsiNum: Int = 0
    var checkedSangsiName: String = Constants.SANGSI[0]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setInit()
    }
    
    func setInit(){
        parentView.layer.cornerRadius = 20
        print("checkedSangsiName : \(checkedSangsiName)")
        
        var i: Int = 0
        while i < Constants.SANGSI.count {
            print("i : \(i)")
            if i == 0{
                checkSangsi.append(true)
            }else{
                checkSangsi.append(false)
            }
            i = i + 1
        }
        
        let closeBtnTab = UITapGestureRecognizer(target: self, action: #selector(closeBtnClicked))
        closeBtn.isUserInteractionEnabled = true
        closeBtn.addGestureRecognizer(closeBtnTab)
    }
    
    
    @IBAction func confrimBtnClicked(_ sender: UIButton) {
        let preVC = self.presentingViewController
        
        
        if preVC is SajuInfoInputViewController{
            guard let vc = preVC as? SajuInfoInputViewController else{
                return
            }
            vc.setSangsi(sangsi: checkedSangsiName,index: checkedSangsiNum)
            
        }else if preVC is ModifySajuInfoViewController{
            guard let vc = preVC as? ModifySajuInfoViewController else{
                return
            }
            vc.setSangsi(sangsi: checkedSangsiName,index: checkedSangsiNum)
        }
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func closeBtnClicked(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Constants.SANGSI.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = sangsiTableView.dequeueReusableCell(withIdentifier: "sangsiCell",for: indexPath) as? SangsiCell else{
            return UITableViewCell()
        }
        cell.sangsiName.text = Constants.SANGSI[indexPath.row]
        if self.checkSangsi[indexPath.row] == true{
            cell.check.isHidden = false
        }else{
            cell.check.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("IndexPath : \(indexPath.row)")
        
        var i: Int = 0
        while i < Constants.SANGSI.count {
            self.checkSangsi[i] = false
            i = i + 1
        }
        self.checkSangsi[indexPath.row] = !self.checkSangsi[indexPath.row]
        self.checkedSangsiNum = indexPath.row
        self.checkedSangsiName = Constants.SANGSI[self.checkedSangsiNum]
//        print("checkedSangsiNum : \(checkedSangsiNum)")
        print("checkedSangsiName : \(checkedSangsiName)")
        self.sangsiTableView.reloadData()

    }

}

class SangsiCell: UITableViewCell{
    
    @IBOutlet var check: UIImageView!
    @IBOutlet var sangsiName: UILabel!
}
