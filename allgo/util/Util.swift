//
//  Util.swift
//  allgo
//
//  Created by 한호철 on 2022/05/27.
//

import UIKit

class Util{
    
    static func showToast(message : String, font: UIFont = UIFont.systemFont(ofSize: 14.0), controller: UIViewController) {
        let toastLabel = UILabel(frame: CGRect(x: controller.view.frame.size.width/2 - 75, y: controller.view.frame.size.height-100, width: 200, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        controller.view.addSubview(toastLabel)
        UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    static func getLanguage() -> String{
        
        return Locale.current.languageCode ?? ""
        
    }
    
    static func getMyCountryCode() -> String{
        let locale = Locale.current
        
        return locale.regionCode!
    }
    
    static func returnArrow(dir: String) -> String{
        
        var imageName: String = ""
        
        if dir == "동"{
            imageName = "ic_direction_right"
        }else if dir == "서"{
            imageName = "ic_direction_left"
        }else if dir == "남"{
            imageName = "ic_direction_down"
        }else if dir == "북"{
            imageName = "ic_direction_up"
        }
        
        return imageName
        
    }
    /*
     오늘의 운세 오늘의 색깔 파일명 return
     */
    static func returnColor(color: String) -> String{
        
        var colorImage: String = ""
        if color == "블랙"{
            colorImage = "ic_color_black"
        }else if color == "블루"{
            colorImage = "ic_color_blue"
        }else if color == "옐로우"{
            colorImage = "ic_color_yellow"
        }else if color == "레드"{
            colorImage = "ic_color_red"
        }else if color == "베이지"{
            colorImage = "ic_color_beige"
        }else if color == "인디고"{
            colorImage = "ic_color_indigo"
        }else if color == "오렌지"{
            colorImage = "ic_color_orange"
        }else if color == "그린"{
            colorImage = "ic_color_green"
        }else if color == "화이트"{
            colorImage = "ic_color_white"
        }else if color == "그레이"{
            colorImage = "ic_color_gray"
        }else if color == "브라운"{
            colorImage = "ic_color_brown"
        }else if color == "핑크"{
            colorImage = "ic_color_pink"
        }
        
        return colorImage
    }
    
    static func getSexName(sex: String) -> String{
        var sexName:String = ""
        
        if sex == "1"{
            sexName = "남"
        }else if sex == "0"{
            sexName = "여"
        }
        return sexName
    }
    
    static func getBirthType(type: String) -> String{
        var birthType = ""
        
        if type == "0" || type == "2"{
            birthType = "음력"
        }else{
            birthType = "양력"
        }
        return birthType
    
    }
    
    static func getGenderTypeImage(type: String) -> String{
//        print("type : \(type)")
        var image: String = ""
        if type == "1" {
            image = "ic_gender_male"
        }else if type == "0"{
            image = "ic_gender_female"
        }
        
        return image
    }
    
    static func getBloodTypeImage(type: String) -> String{
        var image: String = ""
        
//        print("type : \(type)")
        
        if type == "A"{
            image = "ic_blood_a"
        }else if type == "B"{
            image = "ic_blood_b"
        }else if type == "O"{
            image = "ic_blood_o"
        }else if type == "AB"{
            image = "ic_blood_ab"
        }
        
        return image
    }
    
    
//    "u_t" = "생시모름";
//    "rat_t" = "자시(23:30~01:29)";
//    "cow_t" = "축시(01:30~03:29)";
//    "tiger_t" = "인시(03:30~05:29)";
//    "rabbit_t" = "묘시(05:30~07:29)";
//    "dragon_t" = "진시(07:30~09:29)";
//    "snake_t" = "사시(09:30~11:29)";
//    "horse_t" = "오시(11:30~13:29)";
//    "sheep_t" = "미시(13:30~15:29)";
//    "monkey_t" = "신시(15:30~17:29)";
//    "chicken_t" = "유시(17:30~19:29)";
//    "dog_t" = "술시(19:30~21:29)";
//    "pig_t" = "해시(21:30~23:29)";

    static func getOrientalTime(time: String) -> String{
        var result: String = ""
        if time == "0" {
            result = "생시모름"//NSLocalizedString("ut_t", comment: "생시모름")
        }else if time == "1"{
            result = "자시(23:30~01:29)"//NSLocalizedString("rat_t", comment: "자시(23:30~01:29)")
        }else if time == "2"{
            result = "축시(01:30~03:29)"//NSLocalizedString("cow_t", comment: "축시(01:30~03:29)")
        }else if time == "3"{
            result = "인시(03:30~05:29)"//NSLocalizedString("tiger_t", comment: "인시(03:30~05:29)")
        }else if time == "4"{
            result = "묘시(05:30~07:29)"//NSLocalizedString("rabbit_t", comment: "인시(03:30~05:29)")
        }else if time == "5"{
            result = "진시(07:30~09:29)"//NSLocalizedString("dragon_t", comment: "진시(07:30~09:29)")
        }else if time == "6"{
            result = "사시(09:30~11:29)"//NSLocalizedString("snake_t", comment: "사시(09:30~11:29)")
        }else if time == "7"{
            result = "오시(11:30~13:29)"//NSLocalizedString("horse_t", comment: "오시(11:30~13:29)")
        }else if time == "8"{
            result = "미시(13:30~15:29)"//NSLocalizedString("sheep_t", comment: "미시(13:30~15:29)")
        }else if time == "9"{
            result = "신시(15:30~17:29)"//NSLocalizedString("monkey_t", comment: "신시(15:30~17:29)")
        }else if time == "10"{
            result = "유시(17:30~19:29)"//NSLocalizedString("chicken_t", comment: "유시(17:30~19:29)")
        }else if time == "11"{
            result = "술시(19:30~21:29)"//NSLocalizedString("dog_t", comment: "술시(19:30~21:29)")
        }else if time == "12"{
            result = "해시(21:30~23:29)"//NSLocalizedString("pig_t", comment: "술시(19:30~21:29)")
        }
        return result
    }
    
    static func getOrientalTimeName(time: String) -> String{
        var result: String = ""
        if time == "0" {
            result = "생시모름"//NSLocalizedString("ut_t", comment: "생시모름")
        }else if time == "1"{
            result = "자시"//NSLocalizedString("rat_t", comment: "자시(23:30~01:29)")
        }else if time == "2"{
            result = "축시"//NSLocalizedString("cow_t", comment: "축시(01:30~03:29)")
        }else if time == "3"{
            result = "인시"//NSLocalizedString("tiger_t", comment: "인시(03:30~05:29)")
        }else if time == "4"{
            result = "묘시"//NSLocalizedString("rabbit_t", comment: "인시(03:30~05:29)")
        }else if time == "5"{
            result = "진시"//NSLocalizedString("dragon_t", comment: "진시(07:30~09:29)")
        }else if time == "6"{
            result = "사시"//NSLocalizedString("snake_t", comment: "사시(09:30~11:29)")
        }else if time == "7"{
            result = "오시"//NSLocalizedString("horse_t", comment: "오시(11:30~13:29)")
        }else if time == "8"{
            result = "미시"//NSLocalizedString("sheep_t", comment: "미시(13:30~15:29)")
        }else if time == "9"{
            result = "신시"//NSLocalizedString("monkey_t", comment: "신시(15:30~17:29)")
        }else if time == "10"{
            result = "유시"//NSLocalizedString("chicken_t", comment: "유시(17:30~19:29)")
        }else if time == "11"{
            result = "술시"//NSLocalizedString("dog_t", comment: "술시(19:30~21:29)")
        }else if time == "12"{
            result = "해시"//NSLocalizedString("pig_t", comment: "술시(19:30~21:29)")
        }
        return result
    }
    
    static func getOrientalTimeValue(time: String) -> String{
        var result: String = ""
        if time == "0" {
            result = "생시모름"//NSLocalizedString("ut_t", comment: "생시모름")
        }else if time == "1"{
            result = "23:30~01:29"//NSLocalizedString("rat_t", comment: "자시(23:30~01:29)")
        }else if time == "2"{
            result = "01:30~03:29"//NSLocalizedString("cow_t", comment: "축시(01:30~03:29)")
        }else if time == "3"{
            result = "03:30~05:29"//NSLocalizedString("tiger_t", comment: "인시(03:30~05:29)")
        }else if time == "4"{
            result = "05:30~07:29"//NSLocalizedString("rabbit_t", comment: "인시(03:30~05:29)")
        }else if time == "5"{
            result = "07:30~09:29"//NSLocalizedString("dragon_t", comment: "진시(07:30~09:29)")
        }else if time == "6"{
            result = "09:30~11:29"//NSLocalizedString("snake_t", comment: "사시(09:30~11:29)")
        }else if time == "7"{
            result = "11:30~13:29"//NSLocalizedString("horse_t", comment: "오시(11:30~13:29)")
        }else if time == "8"{
            result = "13:30~15:29"//NSLocalizedString("sheep_t", comment: "미시(13:30~15:29)")
        }else if time == "9"{
            result = "15:30~17:29"//NSLocalizedString("monkey_t", comment: "신시(15:30~17:29)")
        }else if time == "10"{
            result = "17:30~19:29"//NSLocalizedString("chicken_t", comment: "유시(17:30~19:29)")
        }else if time == "11"{
            result = "19:30~21:29"//NSLocalizedString("dog_t", comment: "술시(19:30~21:29)")
        }else if time == "12"{
            result = "21:30~23:29"//NSLocalizedString("pig_t", comment: "술시(19:30~21:29)")
        }
        return result
    }
    
    static func substringWithRange(target: String,start: Int,range: Int) -> String{
        var result: String = ""
        
        let sIndex = target.index(target.startIndex,offsetBy: start)
        let eIndex = target.index(sIndex,offsetBy: range)
        
        let range = sIndex..<eIndex

        result = String(target[range])
//        print("result : \(result)")
        
        return result
    }
    
    static func setAllUnderLinesHidden(underLines: Array<UIImageView>){
        var i = 0
        while i < underLines.count{
            underLines[i].isHidden = true
            i += 1
        }
    }
    
    static func checkBlood(myBlood:String,fBlood:String,mBlood:String) -> Bool{
        
        var result:Bool = true
        
        switch myBlood{
        case "A" :
            if fBlood == "B"{
                if mBlood == "B" || mBlood == "O"{
                    result = false
                }
            }else if fBlood == "O"{
                if mBlood == "B" || mBlood == "O"{
                    result = false
                }
            }
        case "B" :
            if fBlood == "A"{
                if mBlood == "A" || mBlood == "O"{
                    result = false
                }
            }
            
        case "O" :
            if fBlood == "A"{
                if mBlood == "AB"{
                    result = false
                }
            }else if fBlood == "B"{
                if mBlood == "AB"{
                    result = false
                }
            }else if fBlood == "O"{
                if mBlood == "AB"{
                    result = false
                }
            }else if fBlood == "AB"{
                result = false
            }
        case "AB" :
            if fBlood == "A"{
                if mBlood == "A" || mBlood == "O"{
                    result = false
                }
            }else if fBlood == "B"{
               if mBlood == "B" || mBlood == "O"{
                    result = false
                }
            }else if fBlood == "O"{
                if mBlood == "A" || mBlood == "B" || mBlood == "O"{
                    result = false
                }
            }
        default:
            result = false
        }
        return result
        
    }
    
    static func getYear() -> String{
        
        var year: String = ""
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        year = dateFormatter.string(from: date)
        return year
        
    }
    
    static func getToday() -> String{
        
        var today: String = ""
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        today = dateFormatter.string(from: date)
        return today
    }
    
}


