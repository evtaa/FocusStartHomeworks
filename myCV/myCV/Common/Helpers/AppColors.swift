//
//  AppColors.swift
//  myCV
//
//  Created by Alexandr Evtodiy on 12.11.2021.
//

import Foundation
import UIKit

enum AppColors {
    static let badColor = UIColor(named: "badColor")
    static let badCgColor = CGColor(red: 1, green: 1, blue: 0, alpha: 1)
    static let background = UIColor.systemGray5
    static let contentBackground = UIColor.systemBackground
    static let unimportantLabel = UIColor.systemGray
    static let segmentActive = UIColor(named: "segmentActive") ?? badColor
    static let segmentNoActive = UIColor.systemGray5
    static let segmentTextActive = UIColor(named: "segmentTextActive") ?? badColor
    static let segmentTextNoActive = UIColor(named: "segmentTextNoActive") ?? badColor
    static let borderOfAvatar = UIColor(named: "borderOfAvatar")?.cgColor ?? badCgColor
}
