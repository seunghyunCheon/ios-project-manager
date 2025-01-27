//
//  PlanCell.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/19.
//

import UIKit
import Combine

final class PlanCell: UICollectionViewListCell {
    private let titleLabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }()
    
    private let bodyLabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .systemGray
        label.numberOfLines = 3
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }()
    
    private let dateLabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }()
    
    private let stackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private var viewModel: PlanCellViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContentLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func provide(viewModel: PlanCellViewModel) {
        self.viewModel = viewModel
        bindViewModelToView()
    }
    
    private func bindViewModelToView() {
        viewModel?.$title
            .sink { [weak self] title in
                self?.titleLabel.text = title
            }
            .store(in: &cancellables)
        
        viewModel?.$body
            .sink { [weak self] body in
                self?.bodyLabel.text = body
            }
            .store(in: &cancellables)
        
        viewModel?.$date
            .sink { [weak self] date in
                self?.dateLabel.text = date
            }
            .store(in: &cancellables)
        
        viewModel?.$isDateExpired
            .sink { [weak self] state in
                guard let state else { return }
                
                self?.dateLabel.textColor = state ? .systemRed : .black
            }
            .store(in: &cancellables)
    }
    
    private func configureContentLayout() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(bodyLabel)
        stackView.addArrangedSubview(dateLabel)
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
