//
//  ImagesCollectionController.swift
//  CollectionApp
//
//  Created by Alexandr Evtodiy on 18.11.2021.
//

import UIKit

final class ImagesCollectionController: BaseViewController<ImagesCollectionView> {
    
    // MARK: - Properties
    private var images: [Image]?
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        rootView.collectionView.reloadData()
    }
    
    // MARK: - Configure
    private func configure() {
        configureMockData()
        configureNavigationBar()
        configureCollectionView()
    }
    
    private func configureNavigationBar() {
        title = AppText.NavigationBar.album
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: AppFonts.systemBold]
    }
    
    private func configureCollectionView() {
        rootView.collectionView.register(ImageCollectionCell.self)
        rootView.collectionView.dataSource = self
        rootView.collectionView.delegate = self
    }
    
    // MARK: - Private functions
    private func configureMockData () {
        images = ImagesMock.shared.images
    }
    
    private func getWidthOfPhotoCollectionView(for collectionView: UICollectionView, spacing: CGFloat) -> CGFloat {
        let itemsInRow: CGFloat = AppLayout.ImageCell.countOfPhotoInRow
        let width = collectionView.frame.width
        let totalSpacing: CGFloat = 2 * spacing + (itemsInRow - 1) * spacing
        let finalWidth = (width - totalSpacing) / itemsInRow
        return finalWidth - AppLayout.ImageCell.subtractFromWidthPhoto
    }
    
    private func getLabelTextSize(text: String, font: UIFont, maxWidthLabel: CGFloat) -> CGSize {
        let textBlock = CGSize(width: maxWidthLabel, height: CGFloat.greatestFiniteMagnitude)
        let rect = text.boundingRect(with: textBlock, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        let width = Double(rect.size.width)
        let height = Double(rect.size.height)
        let size = CGSize(width: ceil(width), height: ceil(height))
        return size
    }
    
    // MARK: - Navigation
    private func goToDetailInfo(image: Image) {
        let vc = DetailInfoAssembler.assemble(with: image)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Rotate orientation
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        rootView.collectionView.performBatchUpdates(nil, completion: nil)
    }
}

extension ImagesCollectionController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = images?.count else { return 0 }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ofType: ImageCollectionCell.self, for: indexPath)
        guard let image = images?[indexPath.row] else { return cell}
        let imageViewModel = ImageViewModelFactory.viewModel(from: image)
        let ratio = image.image.size.height/image.image.size.width
        let widthCell = getWidthOfPhotoCollectionView(for: collectionView, spacing: AppLayout.ImageCell.spacing)
        let heightLabel = getLabelTextSize(text: image.name, font: AppFonts.smallSystem, maxWidthLabel: widthCell).height
        let heightImageForCell = ceil(ratio * widthCell)
        cell.configureConstraint(heightImage: heightImageForCell, heightLabel: heightLabel)
        cell.configure(with: imageViewModel)
        return cell
    }
}

extension ImagesCollectionController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: AppLayout.ImageCell.spacing,
                            left: AppLayout.ImageCell.spacing,
                            bottom: AppLayout.ImageCell.spacing,
                            right: AppLayout.ImageCell.spacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return AppLayout.ImageCell.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return AppLayout.ImageCell.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let imagesItem = images?[indexPath.row]
        else { return CGSize() }
        let ratio = imagesItem.image.size.height/imagesItem.image.size.width
        let widthCell = getWidthOfPhotoCollectionView(for: collectionView, spacing: AppLayout.ImageCell.spacing)
        let heightLabel = getLabelTextSize(text: imagesItem.name, font: AppFonts.smallSystem, maxWidthLabel: widthCell).height
        let heightImageForCell = ceil(ratio * widthCell)
        if let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionCell {
            cell.configureConstraint(heightImage: heightImageForCell, heightLabel: heightLabel)
        }
        let heightCell = heightImageForCell + AppLayout.ImageCell.topLabel + heightLabel
        return CGSize(width: widthCell, height: heightCell)
    }
}

extension ImagesCollectionController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let image = images?[indexPath.row]
        else {return}
        goToDetailInfo(image: image)
    }
}
