//
//  ListImagesCell.swift
//  ImageNetworkService
//
//  Created by Alexandr Evtodiy on 09.12.2021.
//

import UIKit

protocol IListImagesCell: UITableViewCell {
    func configure(with download: IDownloadViewModel)
}

class ListImagesCell: UITableViewCell {
    // MARK: - Subviews
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageWebView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = AppLayout.ListImages.Cell.spacingMainStackView
        return stackView
    }()
    
    private let imageWebView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureLayoutContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ConfigureUI
    private func configureLayoutContentView() {
        let safeArea = contentView.safeAreaLayoutGuide
        contentView.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            
            imageWebView.heightAnchor.constraint(equalToConstant: AppLayout.ListImages.Cell.heightImageWebView),
            mainStackView.heightAnchor.constraint(equalToConstant: AppLayout.ListImages.Cell.heightImageWebView),
            mainStackView.topAnchor.constraint(equalTo: safeArea.topAnchor,
                                               constant: AppLayout.ListImages.Cell.topMainStackView),
            mainStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
                                                   constant: AppLayout.ListImages.Cell.leadingMainStackView),
            mainStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,
                                                    constant: AppLayout.ListImages.Cell.trailingMainStackView),
            mainStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,
                                                  constant: AppLayout.ListImages.Cell.bottomTopMainStackView),
        ])
    }
}

// MARK:  - IListImagesCell
extension ListImagesCell: IListImagesCell {
    func configure(with download: IDownloadViewModel) {
        imageWebView.image = download.image
    }
}
