//
//  appNotificationsEnum.swift
//  NICU Ventilators
//
//  Created by Coy Coburn on 5/13/23.
//

import Foundation

enum appNotificationsString: String, CaseIterable {
    
    case title1
    case title2
    case title3
    case title4
    case title5
    case title6
    case title7
    case title8
    case title9
    case title10
    case title11
    case title12
    case title13
    case title14
    
    case body1
    case body2
    case body3
    case body4
    case body5
    case body6
    case body7
    case body8
    case body9
    case body10
    case body11
    case body12
    case body13
    case body14
    
    var localized: String {
        NSLocalizedString(self.rawValue, comment: "")
    }
    
    var labelLocalized: String {
        NSLocalizedString(String(describing: Self.self) + "_\(rawValue)", comment: "")
    }
}
