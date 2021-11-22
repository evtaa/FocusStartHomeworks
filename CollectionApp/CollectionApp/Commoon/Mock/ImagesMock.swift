//
//  ImagesMock.swift
//  CollectionApp
//
//  Created by Alexandr Evtodiy on 18.11.2021.
//

import UIKit

final class ImagesMock {
    
    // MARK: - Properties
    static let shared = ImagesMock()
    let images: [Image]
    
    // MARK: - Init
    private init() {       
        let firstImage = Image(image: AppImages.ImagesCollection.firstImage ?? UIImage(),
                               name: AppText.ImagesCollection.firstName,
                               info: AppText.ImagesCollection.firstInfo)
        let secondImage = Image(image: AppImages.ImagesCollection.secondImage ?? UIImage(),
                                name: AppText.ImagesCollection.secondName,
                                info: AppText.ImagesCollection.secondInfo)
        let thirdImage = Image(image: AppImages.ImagesCollection.thirdImage ?? UIImage(),
                               name: AppText.ImagesCollection.thirdName,
                               info: AppText.ImagesCollection.thirdInfo)
        let fourthImage = Image(image: AppImages.ImagesCollection.fourthImage ?? UIImage(),
                                name: AppText.ImagesCollection.fourthName,
                                info: AppText.ImagesCollection.fourthInfo)
        let fifthImage = Image(image: AppImages.ImagesCollection.fifthImage ?? UIImage(),
                               name: AppText.ImagesCollection.fifthName,
                               info: AppText.ImagesCollection.fifthInfo)
        let sixthImage = Image(image: AppImages.ImagesCollection.sixthImage ?? UIImage(),
                               name: AppText.ImagesCollection.sixthName,
                               info: AppText.ImagesCollection.sixthInfo)
        let seventhImage = Image(image: AppImages.ImagesCollection.seventhImage ?? UIImage(),
                                 name: AppText.ImagesCollection.seventhName,
                                 info: AppText.ImagesCollection.seventhInfo)
        let eighthImage = Image(image: AppImages.ImagesCollection.eighthImage ?? UIImage(),
                                name: AppText.ImagesCollection.eighthName,
                                info: AppText.ImagesCollection.eighthInfo)
        let ninthImage = Image(image: AppImages.ImagesCollection.ninthImage ?? UIImage(),
                               name: AppText.ImagesCollection.ninthName,
                               info: AppText.ImagesCollection.ninthInfo)
        let tenthImage = Image(image: AppImages.ImagesCollection.tenthImage ?? UIImage(),
                               name: AppText.ImagesCollection.tenthName,
                               info: AppText.ImagesCollection.tenthInfo)
        let eleventhImage = Image(image: AppImages.ImagesCollection.eleventhImage ?? UIImage(),
                                  name: AppText.ImagesCollection.eleventhName,
                                  info: AppText.ImagesCollection.eleventhInfo)
        
        images = [firstImage,
                  secondImage,
                  thirdImage,
                  fourthImage,
                  fifthImage,
                  sixthImage,
                  seventhImage,
                  eighthImage,
                  ninthImage,
                  tenthImage,
                  eleventhImage]
    }
    
}
