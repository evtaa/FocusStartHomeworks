//
//  PersonalInfoMock.swift
//  myCV
//
//  Created by Alexandr Evtodiy on 12.11.2021.
//

import Foundation
import UIKit

final class PersonMock {
    // MARK: - Properties
    static let shared = PersonMock()
    var person: Person
    
    // MARK: - Init
    private init() {
        let educationDateFormatter = DateFormatter()
        educationDateFormatter.dateFormat = "yyyy"
        let workExperienceDateFormatter = DateFormatter()
        workExperienceDateFormatter.dateFormat = "MM.yyyy"
        
        // MARK: - PersonalInfo
        let endFirstEducationItem = educationDateFormatter.date(from: AppText.Person.PersonalInfo.endFirstEducationItem) ?? Date()
        let endSecondEducationItem = educationDateFormatter.date(from: AppText.Person.PersonalInfo.endSecondEducationItem) ?? Date()
        let endThirdEducationItem = educationDateFormatter.date(from: AppText.Person.PersonalInfo.endThirdEducationItem) ?? Date()
        
        let firstEducationItem = EducationItem(
            dateOfEnd: endFirstEducationItem,
            headerInfo: AppText.Person.PersonalInfo.firstHeaderInfoOfEducationItem,
            info: AppText.Person.PersonalInfo.firstInfoOfEducationItem)
        let secondEducationItem = EducationItem(
            dateOfEnd: endSecondEducationItem,
            headerInfo: AppText.Person.PersonalInfo.secondHeaderInfoOfEducationItem,
            info: AppText.Person.PersonalInfo.secondInfoOfEducationItem)
        let thirdEducationItem = EducationItem(
            dateOfEnd: endThirdEducationItem,
            headerInfo: AppText.Person.PersonalInfo.thirdHeaderInfoOfEducationItem,
            info: AppText.Person.PersonalInfo.thirdInfoOfEducationItem)
        let educationItems = [thirdEducationItem, secondEducationItem, firstEducationItem]
        
        let personalInfo = PersonalInfo(avatar: AppImages.Person.PersonalInfo.avatar ?? UIImage(),
                                        name: AppText.Person.PersonalInfo.name,
                                        age: Int(AppText.Person.PersonalInfo.age) ?? 0,
                                        address: AppText.Person.PersonalInfo.address,
                                        mobile: AppText.Person.PersonalInfo.mobile,
                                        nationality: AppText.Person.PersonalInfo.nationality,
                                        email: AppText.Person.PersonalInfo.email,
                                        educationItems: educationItems)
        
        // MARK: - Profile
        let startFirstWorkExperienceItem = workExperienceDateFormatter.date(from: AppText.Person.Profile.startFirstWorkExperienceItem) ?? Date()
        let endFirstWorkExperienceItem = workExperienceDateFormatter.date(from: AppText.Person.Profile.endFirstWorkExperienceItem) ?? Date()
        let startSecondWorkExperienceItem = workExperienceDateFormatter.date(from: AppText.Person.Profile.startSecondWorkExperienceItem) ?? Date()
        let endSecondWorkExperienceItem = workExperienceDateFormatter.date(from: AppText.Person.Profile.endSecondWorkExperienceItem) ?? Date()
        let startThirdWorkExperienceItem = workExperienceDateFormatter.date(from: AppText.Person.Profile.startThirdWorkExperienceItem) ?? Date()
        let endThirdWorkExperienceItem = workExperienceDateFormatter.date(from: AppText.Person.Profile.endThirdWorkExperienceItem) ?? Date()
        
        let firstWorkExperienceItem = WorkExperienceItem(dateOfBegin: startFirstWorkExperienceItem,
                                                         dateOfEnd: endFirstWorkExperienceItem,
                                                         company: AppText.Person.Profile.firstCompanyOfWorkExperienceItem,
                                                         position: AppText.Person.Profile.firstPositionOfWorkExperienceItem,
                                                         responsibilities: AppText.Person.Profile.firstResponsibilitiesOfWorkExperienceItem)
        let secondWorkExperienceItem = WorkExperienceItem(dateOfBegin: startSecondWorkExperienceItem,
                                                          dateOfEnd: endSecondWorkExperienceItem,
                                                          company: AppText.Person.Profile.secondCompanyOfWorkExperienceItem,
                                                          position: AppText.Person.Profile.secondPositionOfWorkExperienceItem,
                                                          responsibilities: AppText.Person.Profile.secondResponsibilitiesOfWorkExperienceItem)
        let thirdWorkExperienceItem = WorkExperienceItem(dateOfBegin: startThirdWorkExperienceItem,
                                                         dateOfEnd: endThirdWorkExperienceItem,
                                                         company: AppText.Person.Profile.thirdCompanyOfWorkExperienceItem,
                                                         position: AppText.Person.Profile.thirdPositionOfWorkExperienceItem,
                                                         responsibilities: AppText.Person.Profile.thirdResponsibilitiesOfWorkExperienceItem)
        let workExperienceItems = [thirdWorkExperienceItem, secondWorkExperienceItem, firstWorkExperienceItem]
        
        let profile = Profile(demoProfile: AppText.Person.Profile.demoProfile,
                              info: AppText.Person.Profile.info,
                              additionalInfo: AppText.Person.Profile.additionalInfo,
                              workExperience: workExperienceItems)
        
        // MARK: - Interests
        let firstPhotoInterestsItem = PhotoInterestsItem(photo: AppImages.Person.Interests.firstPhoto ?? UIImage())
        let secondPhotoInterestsItem = PhotoInterestsItem(photo: AppImages.Person.Interests.secondPhoto ?? UIImage())
        let thirdPhotoInterestsItem = PhotoInterestsItem(photo: AppImages.Person.Interests.thirdPhoto ?? UIImage())
        let fourthPhotoInterestsItem = PhotoInterestsItem(photo: AppImages.Person.Interests.fourthPhoto ?? UIImage())
        let fifthPhotoInterestsItem = PhotoInterestsItem(photo: AppImages.Person.Interests.fifthPhoto ?? UIImage())
        let sixthPhotoInterestsItem = PhotoInterestsItem(photo: AppImages.Person.Interests.sixthPhoto ?? UIImage())
        let seventhPhotoInterestsItem = PhotoInterestsItem(photo: AppImages.Person.Interests.seventhPhoto ?? UIImage())
        let eighthPhotoInterestsItem = PhotoInterestsItem(photo: AppImages.Person.Interests.eighthPhoto ?? UIImage())
        let ninthPhotoInterestsItem = PhotoInterestsItem(photo: AppImages.Person.Interests.ninthPhoto ?? UIImage())
        let tenthPhotoInterestsItem = PhotoInterestsItem(photo: AppImages.Person.Interests.tenthPhoto ?? UIImage())
        let eleventhPhotoInterestsItem = PhotoInterestsItem(photo: AppImages.Person.Interests.eleventhPhoto ?? UIImage())
        let twelfthPhotoInterestsItem = PhotoInterestsItem(photo: AppImages.Person.Interests.twelfthPhoto ?? UIImage())
        let thirteenthPhotoInterestsItem = PhotoInterestsItem(photo: AppImages.Person.Interests.thirdPhoto ?? UIImage())
        let fourteenthPhotoInterestsItem = PhotoInterestsItem(photo: AppImages.Person.Interests.fourthPhoto ?? UIImage())
        let fifteenthPhotoInterestsItem = PhotoInterestsItem(photo: AppImages.Person.Interests.fifthPhoto ?? UIImage())
        
        let photoInterestsItems = [firstPhotoInterestsItem,
                                   secondPhotoInterestsItem,
                                   thirdPhotoInterestsItem,
                                   fourthPhotoInterestsItem,
                                   fifthPhotoInterestsItem,
                                   sixthPhotoInterestsItem,
                                   seventhPhotoInterestsItem,
                                   eighthPhotoInterestsItem,
                                   ninthPhotoInterestsItem,
                                   tenthPhotoInterestsItem,
                                   eleventhPhotoInterestsItem,
                                   twelfthPhotoInterestsItem,
                                   thirteenthPhotoInterestsItem,
                                   fourteenthPhotoInterestsItem,
                                   fifteenthPhotoInterestsItem]
        
        let interests = Interests(interests: AppText.Person.Interests.interestsInfo,
                                  photosInterests: photoInterestsItems)
        
        person = Person(personalInfo: personalInfo,
                        profile: profile,
                        interests: interests)
    }
}

