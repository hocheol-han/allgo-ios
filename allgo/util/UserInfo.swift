//
//  UserInfo.swift
//  allgo
//
//  Created by 한호철 on 2022/05/18.
//

import Foundation

class UserInfo {
    static let shared = UserInfo()
    
    private init() { }
    
    var isLogin: Bool?
    var needMainRefresh: Bool?
    
    var memberId: String?
    var memberCountryPhoneNo: String?
    var memberPhoneNo: String?
    var memberEmail: String?
    var memberName: String?
    var memberBirthYear: String?
    var memberBirthMonth: String?
    var memberBirthDay: String?
    var memberBirthTime: String?
    var memberSexGb: String?
    var memberBirthTypeGb: String?
    var memberBlood: String?
    
    var memberSelectBujukUrl: String?
    var memberSelectBujukTitle: String?
    var memberSelectBujukLevel: String?
    var memberSelectBujukId: String?
    
    var memberGabja: String?
    
    
    
}
