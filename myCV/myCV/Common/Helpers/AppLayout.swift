//
//  AppLayout.swift
//  myCV
//
//  Created by Alexandr Evtodiy on 11.11.2021.
//

import Foundation
import UIKit

enum AppLayout {
    enum PersonalInfo {
        static let cornerRadius: CGFloat = 15.0
        static let topForCommonAndEducationView: CGFloat = 10.0
        static let bottomForCommonAndEducationView: CGFloat = -topForCommonAndEducationView
        
        // MARK: - scrollView
        static let bottomContentScrollView: CGFloat = -50.0
        
        // MARK: - segmentControl
        static let topSegmentedControl: CGFloat = 10.0
        static let leadingSegmentedControl: CGFloat = 10.0
        static let trailingSegmentedControl: CGFloat = -leadingSegmentedControl
        static let heightSegmentedControl: CGFloat = 40.0
        
        // MARK: - avatarImageView
        static let borderWidthOfAvatarImage: CGFloat = 2.0
        static let topAvatarImage: CGFloat = 20.0
        static let leadingAvatarImage: CGFloat = 15.0
        static let heightAvatarImage: CGFloat = 150.0
        static var widthAvatarImage: CGFloat {
            get {
                guard let width = AppImages.Person.PersonalInfo.avatar?.size.width,
                      let height = AppImages.Person.PersonalInfo.avatar?.size.height
                else { return heightAvatarImage }
                return width / height * heightAvatarImage
            }
        }
        
        // MARK: - Labels
        static let topFieldLabel: CGFloat = 10.0
        static let topLabel: CGFloat = 3.0
        static let leadingLabel: CGFloat = 15.0
        static let trailingLabel: CGFloat = -leadingLabel
        
        // MARK: - Table
        static let tableEstimatedRowHeight: CGFloat = 100.0
        
        enum EducationCell {
            
            // MARK: - TableCell
            static let topMainView: CGFloat = 10.0
            static let bottomMainView: CGFloat = -topMainView
            static let topTimePeriod: CGFloat = 15.0
            static let leadingTimePeriod: CGFloat = 15.0
            static let trailingTimePeriod: CGFloat = -leadingTimePeriod
            static let topLabel: CGFloat = 5.0
            static let bottomLabel: CGFloat = -15.0
        }
    }
    
    enum Profile {
        static let cornerRadius: CGFloat = 15.0
        // MARK: - scrollView
        static let bottomContentScrollView: CGFloat = -50.0
        
        // MARK: - MainStackView
        static let topMainStackView: CGFloat = 10.0
        static let leadingMainStackView: CGFloat = 10.0
        static let trailingMainStackView: CGFloat = -leadingMainStackView
        static let bottomMainStackView: CGFloat = -topMainStackView
        static let spacingMainStackView: CGFloat = 10.0
        static let customSpacingCommonForProfileView: CGFloat = 0.0
        
        //MARK: - StackInCommonProfileView
        static let spacingCommonStackView: CGFloat = 10.0
        static let topCommonStackView: CGFloat = 15.0
        static let leadingCommonStackView: CGFloat = 15.0
        static let trailingCommonStackView: CGFloat = -leadingCommonStackView
        
        // MARK: - segmentControl
        static let heightSegmentedControl: CGFloat = 40.0
        
        // MARK: - Table
        static let tableEstimatedRowHeight: CGFloat = 100.0
        
        enum WorkExperienceCell {
            
            // MARK: - TableCell
            static let topMainView: CGFloat = 10.0
            static let bottomMainView: CGFloat = -topMainView
            static let topStackView: CGFloat = 15.0
            static let bottomStackView: CGFloat = -topStackView
            static let leadingStackView: CGFloat = 15.0
            static let trailingStackView: CGFloat = -leadingStackView
            static let spacingStackView: CGFloat = 5.0
        }
    }
    
    enum Interests {
        static let cornerRadius: CGFloat = 15.0
        // MARK: - scrollView
        static let bottomContentScrollView: CGFloat = -50.0
        
        // MARK: - segmentControl
        static let heightSegmentedControl: CGFloat = 40.0
        
        // MARK: - MainStackView
        static let topMainStackView: CGFloat = 10.0
        static let leadingMainStackView: CGFloat = 10.0
        static let trailingMainStackView: CGFloat = -leadingMainStackView
        static let bottomMainStackView: CGFloat = -topMainStackView
        static let spacingMainStackView: CGFloat = 10.0
        static let customSpacingCommonForProfileView: CGFloat = 0.0
        // MARK: - CommonLabel
        static let topCommonLabel: CGFloat = 15.0
        static let leadingCommonLabel: CGFloat = 15.0
        static let trailingCommonLabel: CGFloat = -leadingCommonLabel
        
        enum PhotoCell {
            // MARK: - CollectionCell
            static let spacing: CGFloat = 16.0
            static let itemHeight: CGFloat = 300.0
            static let countOfPhotoInRow: CGFloat = 1.0
            static let subtractFromWidthPhoto: CGFloat = 5.0
        }
    }
}
