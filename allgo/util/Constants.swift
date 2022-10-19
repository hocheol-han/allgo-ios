//
//  Constants.swift
//  allgo
//
//  Created by 한호철 on 2022/05/25.
//

import Foundation
import SwiftUI

class Constants{
    
    
//    static let urlPrefix: String = "http://192.168.0.81:3000"
    static let urlPrefix: String = "http://allgoapi.sirioh.com"
    
    static let SEARCH_OK: String    = "0000"
    static let NO_MEMBERID: String  = "001"
    static let NO_INF: String       = "002"
    static let PWD_WRONG: String    = "003"
    static let SOCIALID_DUP         = "004"
    
    static let FRIEND               = "M06001"
    static let FAMILY               = "M06002"
    static let PARENT               = "M06003"
    static let ETC                  = "M06004"
    static let ME                   = "M06005"
    
    static let FRIEND_NAME          = "친구"
    static let FAMILY_NAME          = "가족"
    static let PARENT_NAME          = "부모님"
    static let ETC_NAME             = "기타"
    static let ME_NAME              = "내 사주"
    
    static let MALE                 = "1"
    static let FEMALE               = "0"
    
    static let BLOOD_TYPE_A         = "A"
    static let BLOOD_TYPE_B         = "B"
    static let BLOOD_TYPE_O         = "O"
    static let BLOOD_TYPE_AB        = "AB"
    
    static let SOLAR                = "1"
    static let LUNAR                = "0"
    static let YUN                  = "2"
    
    //정통운세
    static let TOJEONG              = "300"
    static let SAJU                 = "307"
    static let GUNGHAP              = "400"
    
    
    //테마운세
    static let FORTUNE_COOKIE       = "202"
    static let TARO                 = "606"
    static let DREAM                = "715"
    static let NAMING               = "700"
    static let ANIMAL               = "727"
    static let FLOWER               = "718"
    static let MIND_CATCH           = "731"
    static let BLOOD_N_LOVE         = "736"
    static let STAR_N_BLOOD         = "733"
    static let STAR_STORY           = "732"
    static let STAR_N_CHAR          = "737"
    
//    static let FRIEND_NAME          = "친구"
//    static let FAMILY_NAME          = ""
    
    static let BOARD_CD_NOTICE      = "A05001"
    static let BOARD_CD_FAQ         = "A05002"
    
    
    static let MAIN_MENU : [String] = 	["img_today_item_01","img_today_item_02_01","img_today_item_03","img_today_item_04"]
    static let MAIN_MENU_NAME : [String] = ["오늘의 운세","포춘쿠키","오늘의 애정운","오늘의타로"]
    
    static let JUNGTONG_UNSE : [String] =     ["img_fortune_tab_01_item_01","img_fortune_tab_01_item_02","img_fortune_tab_01_item_03"]
    static let THEME_UNSE : [String] = ["img_fortune_tab_02_item_01_01",/*포춘쿠키*/
                                        "img_fortune_tab_02_item_02",/*타로*/
                                        "img_fortune_tab_02_item_03",/*꿈해몽*/
                                        "img_fortune_tab_02_item_04",/*작명,이름풀이*/
                                        "img_fortune_tab_02_item_05",/*동물점*/
                                        "img_fortune_tab_02_item_06",/*탄생화점,꽃점*/
                                        "img_fortune_tab_02_item_07",/*마음사로잡기*/
                                        "img_fortune_tab_02_item_08",/*혈액형성격,연애*/
                                        "img_fortune_tab_02_item_09",/*별과혈액형*/
                                        "img_fortune_tab_02_item_10",/*나의 별이야기*/
                                        "img_fortune_tab_02_item_11",/*별자리,띠 성격*/
                                        ]
//    static let JUNGTONG_UNSE : [String] = ["img_fortune_tab_01_itme_01","img_fortune_tab_01_itme_02","img_fortune_tab_01_itme_03"]
    static let JUNGTONG_UNSE_NAME : [String] = ["토정비결","사주","궁합"]
    static let THEME_UNSE_NAME : [String] = ["포춘쿠키","타로","꿈해몽","작명/이름풀이","동물점","탄생화점&꽃점","마음사로잡기","혈액형&연애","혈액형&별","별 이야기","별자리&띠성격"]
    
    static let SANGSI = ["생시모름",
                         "자시(23:30~01:29)",
                         "축시(01:30~03:29)",
                         "인시(03:30~05:29)",
                         "묘시(05:30~07:29)",
                         "진시(07:30~09:29)",
                         "사시(09:30~11:29)",
                         "오시(11:30~13:29)",
                         "미시(13:30~15:29)",
                         "신시(15:30~17:29)",
                         "유시(17:30~19:29)",
                         "술시(19:30~21:29)",
                         "해시(21:30~23:29)"]
    
    static let CARD_BACK = "img_tarotcard_back"
    
    static let CARD = [
                        "img_tarotcard_item_00",
                        "img_tarotcard_item_01",
                        "img_tarotcard_item_02",
                        "img_tarotcard_item_03",
                        "img_tarotcard_item_04",
                        "img_tarotcard_item_05",
                        "img_tarotcard_item_06",
                        "img_tarotcard_item_07",
                        "img_tarotcard_item_08",
                        "img_tarotcard_item_09",
                        "img_tarotcard_item_10",
                        "img_tarotcard_item_11",
                        "img_tarotcard_item_12",
                        "img_tarotcard_item_13",
                        "img_tarotcard_item_14",
                        "img_tarotcard_item_15",
                        "img_tarotcard_item_16",
                        "img_tarotcard_item_17",
                        "img_tarotcard_item_18",
                        "img_tarotcard_item_19",
                        "img_tarotcard_item_20",
                        "img_tarotcard_item_21",
    
                        ]
    
    static let MONEY: String = "0"
    static let LOVE: String = "1"
    static let BUSINESS: String = "2"
    
    static let MONEY_NAME: String = "재물운"
    static let LOVE_NAME: String = "연애운"
    static let BUSINESS_NAME: String = "사업운"
    
    static let STANDARD: String = "정방향"
    static let REVERSE: String = "역방향"
    
    static let GRAY = UIColor(hex: "#FF484C53")
    static let WHITE = UIColor(hex: "#FFFFFFFF")
    
    static let TITLE_BACKGROUND = UIColor(hex: "#FF484353")
    static let TEXTCOLOR_SELECTED = UIColor(hex: "#FF484C53")
    static let TEXTCOLOR_UNSELECTED = UIColor(hex: "#99484C53")
    
    static let BUTTON_GREEN = UIColor(hex: "#FF55AAA3")
    static let BUTTON_GRAY = UIColor(hex: "#FFEDEDED")
    static let BUTTON_GRAY_BORDER = UIColor(hex: "#FFE7E7E7")
    
    static let UNSE_GOOD = 0
    static let UNSE_NORMAL = 1
    static let UNSE_BAD = 2
    
    static let UNSE_GOOD_COLOR = UIColor(hex: "#FF5DA2E3")
    static let UNSE_NORMAL_COLOR = UIColor(hex: "#FFFAB733")
    static let UNSE_BAD_COLOR = UIColor(hex: "#FFD24545")
    
    static let GIBUN_CHECK_ALRIM = "gibun_check_alrim"
    static let UNSE_CHECK_ALRIM = "today_unse_alrim"
    
    static let CHECK_ON = "btn_toggle_on"
    static let CHECK_OFF = "btn_toggle_off"
}
