//
//  DatePickerPopViewController.swift
//  allgo
//
//  Created by 한호철 on 2022/06/30.
//

import UIKit

class DatePickerPopViewController: UIViewController {
    
    @IBOutlet var parentView: UIView!
    @IBOutlet var closeBtn: UIImageView!
    @IBOutlet var selectedDate: UILabel!
    
    var selectedYear: String = ""
    var selectedMonth: String = ""
    var selectedDay: String = ""
    
    @IBOutlet var datePicker: UIDatePicker!
    
    
    @IBOutlet var confirmBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setInit()
    }
    
    func setInit(){
        
        let formatter = DateFormatter()
        
        formatter.dateFormat   = "yyyy"
        selectedYear    = formatter.string(from: Date())
        
        formatter.dateFormat   = "MM"
        selectedMonth    = formatter.string(from: Date())
        
        formatter.dateFormat   = "dd"
        selectedDay    = formatter.string(from: Date())
        
        print("today : \(selectedYear) \(selectedMonth) \(selectedDay)")
        
        selectedDate.text = selectedYear + " " + selectedMonth + " " + selectedDay
        
        
        parentView.layer.cornerRadius = 20
        confirmBtn.layer.cornerRadius = 15
        confirmBtn.backgroundColor = Constants.GRAY
        
        datePicker.datePickerMode = .date
        
        let closeBtnTab = UITapGestureRecognizer(target: self, action: #selector(closeBtnClicked))
        closeBtn.isUserInteractionEnabled = true
        closeBtn.addGestureRecognizer(closeBtnTab)
    }
    
    @IBAction func datePickerChange(_ sender: UIDatePicker) {
    
        print("datePickerChange called~!")
        let datePickerView = sender
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        selectedDate.text = formatter.string(from: datePickerView.date)
        
        var date:String = selectedDate.text ?? ""
        
//        print("date : \(date)")

//        print("year : \(Util.substringWithRange(target: date, start: 0, range: 4))")
//        print("month : \(Util.substringWithRange(target: date, start: 5, range: 2))")
//        print("day : \(Util.substringWithRange(target: date, start: 8, range: 2))")
        
        selectedYear = Util.substringWithRange(target: date, start: 0, range: 4)
        selectedMonth = Util.substringWithRange(target: date, start: 5, range: 2)
        selectedDay = Util.substringWithRange(target: date, start: 8, range: 2)

        
    }
    
    @objc func closeBtnClicked(){
        print("closeBtnClicked called")
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func confrimBtnClicked(_ sender: UIButton) {
    
        print("today : \(Util.getToday())")
        
        
        let preVC = self.presentingViewController
        
//        guard let vc = preVC as? SajuInfoInputViewController , preVC as? ModifySajuInfoViewController else{
//            return
//        }
        
        if preVC is SajuInfoInputViewController{
            guard let vc = preVC as? SajuInfoInputViewController else{
                return
            }
            vc.setBirthDate(year: selectedYear, month: selectedMonth, day: selectedDay)
        }else if preVC is ModifySajuInfoViewController{
            guard let vc = preVC as? ModifySajuInfoViewController else{
                return
            }
            vc.setBirthDate(year: selectedYear, month: selectedMonth, day: selectedDay)
        }else if preVC is RankingAllViewController{
            
            guard let vc = preVC as? RankingAllViewController else{
                return
            }
            
            vc.setBirthDate(year: selectedYear, month: selectedMonth, day: selectedDay)
        }
        
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
