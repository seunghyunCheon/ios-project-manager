//
//  ChangeWorkStateViewController.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/29.
//

import UIKit
import Combine

final class ChangeWorkStateViewController: UIViewController {
    private let stackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        
        return stackView
    }()
    
    private let firstButton = {
        let button = UIButton()
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .white
        
        return button
    }()
    
    private let secondButton = {
        let button = UIButton()
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .white
        
        return button
    }()
    
    private let viewModel: ChangeWorkStateViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: ChangeWorkStateViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        configureLayout()
        configureButtonAction()
        bindViewModelToView()
    }
    
    private func configureLayout() {
        self.view.addSubview(stackView)
        stackView.addArrangedSubview(firstButton)
        stackView.addArrangedSubview(secondButton)
        
        let safe = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -5),
            stackView.topAnchor.constraint(equalTo: safe.topAnchor, constant: 5),
            stackView.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -5)
        ])
    }
    
    private func configureButtonAction() {
        firstButton.addTarget(
            self,
            action: #selector(firstButtonTapped),
            for: .touchUpInside
        )
        
        secondButton.addTarget(
            self,
            action: #selector(secondButtonTapped),
            for: .touchUpInside
        )
    }
    
    @objc
    private func firstButtonTapped() {
        viewModel.changeWorkState(buttonIndex: .first)
        self.dismiss(animated: true)
    }
    
    @objc
    private func secondButtonTapped() {
        viewModel.changeWorkState(buttonIndex: .second)
        self.dismiss(animated: true)
    }
    
    private func bindViewModelToView() {
        viewModel.$firstText
            .sink { firstText in
                self.firstButton.setTitle(firstText, for: .normal)
            }
            .store(in: &cancellables)
        
        viewModel.$secondText
            .sink { secondText in
                self.secondButton.setTitle(secondText, for: .normal)
            }
            .store(in: &cancellables)
    }
}
