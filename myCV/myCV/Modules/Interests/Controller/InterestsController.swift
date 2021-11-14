//
//  InterestsController.swift
//  myCV
//
//  Created by Alexandr Evtodiy on 10.11.2021.
//

import UIKit

final class InterestsController: BaseViewController<InterestsView> {
    
    // MARK: - Properties
    private var typeOfInterests: TypeOfInterests = .interests
    private var person: Person?
    private var photoInterestsItems: [PhotoInterestsItem]? {
        get {
            person?.interests.photosInterests
        }
    }
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setTypeOfInterests()
        showViewsByTypeOfInterests()
        configure()
    }
    
    // MARK: - Configure
    private func configure() {
        configureMockData()
        configureSegmentControl()
        configureNavigationBar()
        configureCollectionView()
        guard let person = person else {return}
        rootView.configure(with: person)
    }
    private func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    private func configureSegmentControl() {
        rootView.segmentedControl.addTarget(self, action: #selector(changeTypeOfInterests), for: .valueChanged)
    }
    
    private func configureCollectionView() {
        rootView.photosInterestsCollectionView.register(PhotoInterestsCell.self)
        rootView.photosInterestsCollectionView.dataSource = self
        rootView.photosInterestsCollectionView.delegate = self
    }
    
    // MARK: - Private functions
    private func configureMockData () {
        person = PersonMock.shared.person
    }
    
    private func setTypeOfInterests() {
        switch rootView.segmentedControl.selectedSegmentIndex {
        case 0:
            typeOfInterests = .interests
        case 1:
            typeOfInterests = .photos
        default:
            break
        }
    }
    
    private func showViewsByTypeOfInterests() {
        switch typeOfInterests {
        case .interests:
            showInterestsInfo()
        case .photos:
            showPhotosInfo()
            rootView.photosInterestsCollectionView.reloadData()
        }
    }
    
    private func showInterestsInfo() {
        rootView.commonInterestsView.isHidden = false
        rootView.photosInterestsCollectionView.isHidden = true
    }
    
    private func showPhotosInfo() {
        rootView.commonInterestsView.isHidden = true
        rootView.photosInterestsCollectionView.isHidden = false
    }
    
    // MARK: - Actions
    @objc private func changeTypeOfInterests() {
        setTypeOfInterests()
        showViewsByTypeOfInterests()
    }
}

extension InterestsController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = photoInterestsItems?.count else { return 0 }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ofType: PhotoInterestsCell.self, for: indexPath)
        guard let photoInterestsItem = photoInterestsItems?[indexPath.row] else { return cell}
        let workExperienceViewModel = PhotoInterestsViewModelFactory.viewModel(from: photoInterestsItem)
        cell.configure(with: workExperienceViewModel)
        return cell
    }
}

extension InterestsController: UICollectionViewDelegate {
}

extension InterestsController: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: AppLayout.Interests.PhotoCell.spacing,
                            left: AppLayout.Interests.PhotoCell.spacing,
                            bottom: AppLayout.Interests.PhotoCell.spacing,
                            right: AppLayout.Interests.PhotoCell.spacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return AppLayout.Interests.PhotoCell.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return AppLayout.Interests.PhotoCell.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let photoInterestsItem = photoInterestsItems?[indexPath.row]
        else { return CGSize() }
        let height = photoInterestsItem.photo.size.height
        let width = photoInterestsItem.photo.size.width
        let ratio = height/width
        let widthCell = getWidthOfPhotoCollectionView(for: collectionView, spacing: AppLayout.Interests.PhotoCell.spacing)
        let heightCell = ratio * widthCell
        return CGSize(width: widthCell, height: heightCell)
    }
    
    func getWidthOfPhotoCollectionView(for collectionView: UICollectionView, spacing: CGFloat) -> CGFloat {
        let itemsInRow: CGFloat = AppLayout.Interests.PhotoCell.countOfPhotoInRow
        let width = collectionView.frame.width
        let totalSpacing: CGFloat = 2 * spacing + (itemsInRow - 1) * spacing
        let finalWidth = (width - totalSpacing) / itemsInRow
        return finalWidth - AppLayout.Interests.PhotoCell.subtractFromWidthPhoto
    }
}
