//
//  AppText.swift
//  myCV
//
//  Created by Alexandr Evtodiy on 10.11.2021.
//

import Foundation

enum AppText {
    
    static var nowDate: String {
        get{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM.yyyy"
            let nowDateString = dateFormatter.string(from: Date())
            return nowDateString
        }
    }
    
    // MARK: - MainTabBarController
    enum Tabs {
        static let personalInfo = "personalInfo".localized()
        static let profile = "profile".localized()
        static let interests = "interests".localized()
    }
    
    // MARK: - Person
    enum Person {
        enum PersonalInfo {
            static let name = "name".localized()
            static let age = "age".localized()
            static let address = "address".localized()
            static let mobile = "mobile".localized()
            static let nationality = "nationality".localized()
            static let email = "email".localized()
            
            static let firstHeaderInfoOfEducationItem = "firstHeaderInfoOfEducationItem".localized()
            static let firstInfoOfEducationItem = "firstInfoOfEducationItem".localized()
            static let secondHeaderInfoOfEducationItem = "secondHeaderInfoOfEducationItem".localized()
            static let secondInfoOfEducationItem = "secondInfoOfEducationItem".localized()
            static let thirdHeaderInfoOfEducationItem = "thirdHeaderInfoOfEducationItem".localized()
            static let thirdInfoOfEducationItem = "thirdInfoOfEducationItem".localized()
            
            static let endFirstEducationItem = "2010"
            static let endSecondEducationItem = "2012"
            static let endThirdEducationItem = "2021"
        }
        enum Profile {
            static let demoProfile  = "demoProfile".localized()
            static let info  = "info".localized()
            static let additionalInfo  = "additionalInfo".localized()
            
            static let firstCompanyOfWorkExperienceItem = "firstCompanyOfWorkExperienceItem".localized()
            static let firstPositionOfWorkExperienceItem = "firstPositionOfWorkExperienceItem".localized()
            static let firstResponsibilitiesOfWorkExperienceItem = "firstResponsibilitiesOfWorkExperienceItem".localized()
            static let secondCompanyOfWorkExperienceItem = "secondCompanyOfWorkExperienceItem".localized()
            static let secondPositionOfWorkExperienceItem = "secondPositionOfWorkExperienceItem".localized()
            static let secondResponsibilitiesOfWorkExperienceItem = "secondResponsibilitiesOfWorkExperienceItem".localized()
            static let thirdCompanyOfWorkExperienceItem = "thirdCompanyOfWorkExperienceItem".localized()
            static let thirdPositionOfWorkExperienceItem = "thirdPositionOfWorkExperienceItem".localized()
            static let thirdResponsibilitiesOfWorkExperienceItem = "thirdResponsibilitiesOfWorkExperienceItem".localized()
            
            static let startFirstWorkExperienceItem = "09.2009"
            static let endFirstWorkExperienceItem = "09.2010"
            static let startSecondWorkExperienceItem = "09.2010"
            static let endSecondWorkExperienceItem = "09.2015"
            static let startThirdWorkExperienceItem = "09.2015"
            static let endThirdWorkExperienceItem = nowDate
        }
        enum Interests {
            static let interestsInfo = "interestsInfo".localized()
        }
    }
    
    // MARK: - PersonalInfoController
    enum PersonalInfo {
        static let segmentCommon = "segmentCommon".localized()
        static let segmentEducation = "segmentEducation".localized()
        static let nameIs = "nameIs".localized()
        static let ageIs = "ageIs".localized()
        static let addressIs = "addressIs".localized()
        static let mobileIs = "mobileIs".localized()
        static let nationalityIs = "nationalityIs".localized()
        static let emailIs = "emailIs".localized()
    }
    
    // MARK: - ProfilelInfoController
    enum Profile {
        static let segmentProfile = "segmentProfile".localized()
        static let segmentWorkExperience = "segmentWorkExperience".localized()
        static let year = "year".localized()
        static let month = "month".localized()
    }
    
    enum Interests {
        static let segmentCommon = "segmentInterests".localized()
        static let segmentPhoto = "segmentPhoto".localized()
    }
}
