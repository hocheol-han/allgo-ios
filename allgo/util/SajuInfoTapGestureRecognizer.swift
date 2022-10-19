//
//  SajuInfoTapGestureRecognizer.swift
//  allgo
//
//  Created by 한호철 on 2022/08/09.
//

import UIKit

class SajuInfoTapGestureRecognizer: UITapGestureRecognizer{
    
    var from: String = ""
    var friendId: String = ""
    var friendCD: String = ""
    var friendName: String = ""
    var friendSexGb: String = ""
    var friendBloodType: String = ""
    var friendBirthGb: String = ""
    var birthYear: String = ""
    var birthMonth: String = ""
    var birthDay: String = ""
    var friendBirthTime = ""
    
    var infos: Dictionary<String,String>!
    
}
