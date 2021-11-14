//
//  AppColors.swift
//  myCV
//
//  Created by Alexandr Evtodiy on 12.11.2021.
//

import Foundation
import UIKit

enum AppColors {
    static let badColor = UIColor(hex: 0xFFFF00)
    static let background = UIColor.systemGray5
    static let contentBackground = UIColor.systemBackground
    static let unimportantLabel = UIColor.systemGray
    static let segmentActive = UIColor(named: "segmentActive") ?? badColor
    static let segmentNoActive = UIColor(named: "segmentNoActive") ?? badColor
    static let segmentTextActive = UIColor(named: "segmentTextActive") ?? badColor
    static let segmentTextNoActive = UIColor(named: "segmentTextNoActive") ?? badColor
    static let borderOfAvatar = segmentActive.cgColor
}
