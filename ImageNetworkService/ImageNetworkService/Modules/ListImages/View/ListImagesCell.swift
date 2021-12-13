//
//  ListImagesCell.swift
//  ImageNetworkService
//
//  Created by Alexandr Evtodiy on 09.12.2021.
//

import UIKit

protocol IListImagesCell: UITableViewCell {
    var pauseButtonTouchUpInsideHandler: ((ListImagesCell) -> Void)? { get set }
    var resumeButtonTouchUpInsideHandler: ((ListImagesCell) -> Void)? { get set }
    func configure(with download: IDownloadViewModel)
}

class ListImagesCell: UITableViewCell {
    
    // MARK: - Properties
    var pauseButtonTouchUpInsideHandler: ((ListImagesCell) -> Void)?
    var resumeButtonTouchUpInsideHandler: ((ListImagesCell) -> Void)?
    
    //MARK: - Handlers
    var pauseOrResumeButtonTouchUpInsideHandler: (() -> Void)?
    
    // MARK: - Subviews
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageWebView,
                                                       loadView])
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
    
    private let loadView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let progressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let progressView: UIProgressView = {
        let view = UIProgressView()
        view.progress = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var pauseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(AppText.ListImages.Cell.pauseButton, for: .normal)
        button.setTitleColor(AppColors.ListCars.Cell.textButtonColor, for: .normal)
        button.backgroundColor = AppColors.ListCars.Cell.buttonColor
        button.layer.masksToBounds = true
        button.layer.cornerRadius = AppLayout.ListImages.Cell.cornerRadiusButton
        button.addTarget(self, action: #selector(pauseButtonTouchUpInside), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureLayoutLoadView()
        configureLayoutContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ConfigureUI
    private func configureLayoutLoadView() {
        let safeArea = loadView.safeAreaLayoutGuide
        loadView.addSubview(progressLabel)
        loadView.addSubview(progressView)
        loadView.addSubview(pauseButton)
        NSLayoutConstraint.activate([
            progressLabel.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            progressLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            progressLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
                        
            progressView.topAnchor.constraint(equalTo: progressLabel.bottomAnchor,
                                              constant: AppLayout.ListImages.Cell.topProgressiveView),
            progressView.leadingAnchor.constraint(equalTo: progressLabel.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: progressLabel.trailingAnchor),
            
            pauseButton.topAnchor.constraint(equalTo: progressView.bottomAnchor,
                                             constant: AppLayout.ListImages.Cell.topButton),
            pauseButton.leadingAnchor.constraint(equalTo: progressLabel.leadingAnchor),
            pauseButton.trailingAnchor.constraint(equalTo: progressLabel.trailingAnchor),
            pauseButton.heightAnchor.constraint(equalToConstant: AppLayout.ListImages.Cell.heightButton)
        ])
    }
    
    private func configureLayoutContentView() {
        let safeArea = contentView.safeAreaLayoutGuide
        contentView.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            
            imageWebView.heightAnchor.constraint(equalToConstant: AppLayout.ListImages.Cell.heightImageWebView),
            loadView.heightAnchor.constraint(equalToConstant: AppLayout.ListImages.Cell.heightImageWebView),
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
    
    // MARK: Actions
    @objc func pauseButtonTouchUpInside() {
        if(pauseButton.titleLabel?.text == AppText.ListImages.Cell.pauseButton) {
            pauseButtonTouchUpInsideHandler?(self)
        } else {
            resumeButtonTouchUpInsideHandler?(self)
        }
    }
}

// MARK:  - IListImagesCell
extension ListImagesCell: IListImagesCell {
    func configure(with download: IDownloadViewModel) {
        imageWebView.image = download.image
        progressView.progress = download.progress
        
        if download.downloaded {
            loadView.isHidden = true
            imageWebView.isHidden = false
        } else {
            loadView.isHidden = false
            imageWebView.isHidden = true
            pauseButton.setTitle(AppText.ListImages.Cell.pauseButton, for: .normal)
            progressLabel.text = AppText.ListImages.Cell.loading
        }
        if !download.downloaded && !download.isDownloading {
            loadView.isHidden = false
            imageWebView.isHidden = true
            pauseButton.setTitle(AppText.ListImages.Cell.resumeButton, for: .normal)
        }
    }
}
