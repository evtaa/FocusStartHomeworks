//
//  WorkExperienceViewModelFactory.swift
//  myCV
//
//  Created by Alexandr Evtodiy on 13.11.2021.
//

import Foundation

final class WorkExperienceViewModelFactory {
static func viewModel (from model: WorkExperienceItem) -> WorkExperienceItemViewModel {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM yyyy"
    let dateOfBeginString = dateFormatter.string(from: model.dateOfBegin)
    let dateOfEndString = dateFormatter.string(from: model.dateOfEnd)
    let countOfYears = model.dateOfEnd.years(from: model.dateOfBegin)
    let countOfYearsString = String(countOfYears)
    let countOfMonth = model.dateOfEnd.months(from: model.dateOfBegin) % 12
    let countOfMonthString = String(countOfMonth)
    let timePeriod: String
    if countOfYears == 0 {
        timePeriod = "\(dateOfBeginString) - \(dateOfEndString)   \(countOfMonthString) \(AppText.Profile.month)"
    } else if countOfMonth == 0 {
        timePeriod = "\(dateOfBeginString) - \(dateOfEndString)   \(countOfYearsString) \(AppText.Profile.year)"
    } else {
        timePeriod = "\(dateOfBeginString) - \(dateOfEndString)  \(countOfYearsString) \(AppText.Profile.year) \(countOfMonthString) \(AppText.Profile.month)"
    }
    let company = model.company
    let position = model.position
    let responsibilities = model.responsibilities
    return WorkExperienceItemViewModel(timePeriod: timePeriod, company: company, position: position, responsibilities: responsibilities)
    }
}



