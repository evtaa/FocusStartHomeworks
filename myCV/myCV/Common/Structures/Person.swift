//
//  Person.swift
//  myCV
//
//  Created by Alexandr Evtodiy on 10.11.2021.
//

import Foundation
import UIKit

struct Person {
    let personalInfo: PersonalInfo
    let profile: Profile
    let interests: Interests
}

// MARK: - Personal info
struct PersonalInfo {
    let avatar: UIImage
    let name: String
    let age: Int
    let address: String
    let mobile: String
    let nationality: String
    let email: String
    let educationItems: [EducationItem]
}

struct EducationItem {
    let dateOfEnd: Date
    let headerInfo: String
    let info: String
}

// MARK: - Profile
struct Profile {
    let demoProfile: String
    let info: String
    let additionalInfo: String
    let workExperience: [WorkExperienceItem]
}

struct WorkExperienceItem {
    let dateOfBegin: Date
    let dateOfEnd: Date
    let company: String
    let position: String
    let responsibilities: String
}

// MARK: - Interests
struct Interests {
    let interests: String
    let photosInterests: [PhotoInterestsItem]
}

struct PhotoInterestsItem {
    let photo: UIImage
}
