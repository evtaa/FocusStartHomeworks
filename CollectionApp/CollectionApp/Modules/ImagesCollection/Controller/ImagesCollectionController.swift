//
//  ImagesCollectionController.swift
//  CollectionApp
//
//  Created by Alexandr Evtodiy on 18.11.2021.
//

import UIKit

typealias DataSource = UICollectionViewDiffableDataSource <Section , Image>
typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Image>

enum Section {
    case main
}

final class ImagesCollectionController: BaseViewController<ImagesCollectionView> {
    
    // MARK: - Properties
    private var images: [Image]?
    private lazy var dataSource = makeDataSource()
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        applySnapshot()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        applySnapshot()
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
        let vc = DetailInfoController(image: image)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Rotate orientation
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        applySnapshot()
    }
    
    // MARK: - DiffableDataSource
    func makeDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: rootView.collectionView,
                                    cellProvider: { (collectionView, indexPath, image) -> ImageCollectionCell? in
                                        let cell = collectionView.dequeueReusableCell(ofType: ImageCollectionCell.self, for: indexPath)
                                        
                                        let ratio = image.image.size.height/image.image.size.width
                                        let widthCell = self.getWidthOfPhotoCollectionView(for: collectionView, spacing: AppLayout.ImageCell.spacing)
                                        let heightLabel = self.getLabelTextSize(text: image.name, font: AppFonts.smallSystem, maxWidthLabel: widthCell).height
                                        let heightImageForCell = ceil(ratio * widthCell)
                                        cell.configureConstraint(heightImage: heightImageForCell, heightLabel: heightLabel)
                                        
                                        cell.configure(with: ImageViewModelFactory.viewModel(from: image))
                                        return cell
                                    })
        return dataSource
    }
    
    func applySnapshot () {
        guard let images = images else {return}
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(images)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
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
        guard let imagesItem = dataSource.itemIdentifier(for: indexPath)
        else {return CGSize()}
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
        guard let image = dataSource.itemIdentifier(for: indexPath)
        else {return}
        goToDetailInfo(image: image)
    }
}
