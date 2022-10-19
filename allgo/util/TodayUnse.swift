//
//  TodayUnse.swift
//  allgo
//
//  Created by 한호철 on 2022/05/27.
//

import Foundation

class TodayUnse{
    
    static let shared = TodayUnse()
    
    private init() { }
    
    var unseId: String?
    var todayUnseScore: Int?
    var todayUnseScoreString: String?
    
    var todayDirection: String?
    var todayColor: String?
    var todayNumber: String?
    
    var todayTotalJisu: Int?
    var todayWishJisu: Int?
    var todayPromotionJisu: Int?
    var todayJobJisu: Int?
    var todayLuckJisu: Int?
    var todayBusinessJisu: Int?
    var todayLoveJisu: Int?
    
    var todayRealScoreTotal: Int?
    var todayRealScore: String?
    
    var todayTodalContents: String?
    var todayWishContents: String?
    var todayPromotionContents: String?
    var todayJobContents: String?
    var todayLuckContents: String?
    var todayBusinessContents: String?
    var todayLoveContents: String?
    
    var todayBujukId: String?
    var todayBujukTitle: String?
    var todayBujukLevel: String?
    var todayBujukUrl: String?
    
    
}
