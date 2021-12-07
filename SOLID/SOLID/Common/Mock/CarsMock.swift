//
//  CarsMock.swift
//  SOLID
//
//  Created by Alexandr Evtodiy on 04.12.2021.
//

import Foundation

final class CarsMock {
    
    // MARK: - Properties
    static let shared = CarsMock()
    let cars: [Car]
    
    // MARK: - Init
    private init() {
        
        let sedanAudi = TypeOfBody.sedan(1, AppImages.audiSedan, true)
        let coupeAudi = TypeOfBody.coupe(2, AppImages.audiCoupe, false)
        let hatchBackAudi = TypeOfBody.hatchBack(3, AppImages.audiHatchBack, false)
        let universalAudi = TypeOfBody.universal(4, AppImages.audiUniversal, false)
        let typesOfBodyAudi = [sedanAudi,
                               coupeAudi,
                               hatchBackAudi,
                               universalAudi]
        let firstCar = Car(makeOfCar: .Audi, typeOfBodies: typesOfBodyAudi)
        
        let sedanBMV = TypeOfBody.sedan(11, AppImages.bmwSedan, true)
        let coupeBMV = TypeOfBody.coupe(22, AppImages.bmwCoupe, false)
        let hatchBackBMV = TypeOfBody.hatchBack(33, AppImages.bmwHatchBack, false)
        let universalBMV = TypeOfBody.universal(44, AppImages.bmwUniversal, false)
        let typesOfBodyBMV = [sedanBMV,
                              coupeBMV,
                              hatchBackBMV,
                              universalBMV]
        let secondCar = Car(makeOfCar: .BMW, typeOfBodies: typesOfBodyBMV)
        
        let sedanFord = TypeOfBody.sedan(111, AppImages.fordSedan, true)
        let coupeFord = TypeOfBody.coupe(222, AppImages.fordCoupe, false)
        let hatchBackFord = TypeOfBody.hatchBack(333, AppImages.fordHatchBack, false)
        let universalFord = TypeOfBody.universal(444, AppImages.fordUniversal, false)
        let typesOfBodyFord = [sedanFord,
                               coupeFord,
                               hatchBackFord,
                               universalFord]
        let thirdCar = Car(makeOfCar: .Ford, typeOfBodies: typesOfBodyFord)
        
        let sedanHonda = TypeOfBody.sedan(1111, AppImages.hondaSedan, true)
        let coupeHonda = TypeOfBody.coupe(2222, AppImages.hondaCoupe, false)
        let hatchBackHonda = TypeOfBody.hatchBack(3333, AppImages.hondaHatchBack, false)
        let universalHonda = TypeOfBody.universal(4444, AppImages.hondaUniversal, false)
        let typesOfBodyHonda = [sedanHonda,
                                coupeHonda,
                                hatchBackHonda,
                                universalHonda]
        let fourthCar = Car(makeOfCar: .Honda, typeOfBodies: typesOfBodyHonda)
        
        let sedanLada = TypeOfBody.sedan(11111, AppImages.ladaSedan, true)
        let coupeLada = TypeOfBody.coupe(22222, AppImages.ladaCoupe, false)
        let hatchBackLada = TypeOfBody.hatchBack(33333, AppImages.ladaHatchBack, false)
        let universalLada = TypeOfBody.universal(44444, AppImages.ladaUniversal, false)
        let typesOfBodyLada = [sedanLada,
                               coupeLada,
                               hatchBackLada,
                               universalLada]
        let fifthCar = Car(makeOfCar: .Lada, typeOfBodies: typesOfBodyLada)
        
        cars = [firstCar,
                secondCar,
                thirdCar,
                fourthCar,
                fifthCar]
    }
    
}
