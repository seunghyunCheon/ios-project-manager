//
//  DoneViewController.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/24.
//

import UIKit

final class DoneViewController: UIViewController, TaskCollectionViewController {
    let mode: WorkState = .done
    private lazy var collectionView = UICollectionView(frame: .zero,
                                                       collectionViewLayout: collectionViewLayout())
    lazy var viewModel: any CollectionViewModel = DoneCollectionViewModel(
        collectionView: collectionView,
        cellReuseIdentifier: TaskCell.identifier
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureRootView()
        configureCollectionViewLayout()
        configureCollectionView()
    }
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { _, layoutEnvironment in
            var config = UICollectionLayoutListConfiguration(appearance: .grouped)
            config.headerMode = .supplementary
            
            let section = NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
            section.interGroupSpacing = 10

            return section
        }

        return layout
    }
    
    private func configureNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(presentDetailView)
        )
    }
    
    private func configureRootView() {
        view.backgroundColor = .systemGray4
        view.addSubview(collectionView)
    }
    
    private func configureCollectionViewLayout() {
        collectionView.register(
            HeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HeaderView.identifier
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let safe = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: safe.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safe.bottomAnchor)
        ])
    }
    
    private func configureCollectionView() {
        collectionView.register(TaskCell.self, forCellWithReuseIdentifier: TaskCell.identifier)
        collectionView.isScrollEnabled = false
        
        do {
            collectionView.dataSource = try viewModel.makeDataSource() as? UICollectionViewDataSource
            viewModel.applySnapshot()
        } catch {
            print(error.localizedDescription)
        }
        
        collectionView.delegate = self
    }
    
    @objc
    private func presentDetailView() {
        let detailViewController = DetailViewController(task: nil, mode: .create)
        detailViewController.delegate = self
        self.present(detailViewController, animated: true)
    }
}

extension DoneViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let task = viewModel.task(at: indexPath)
        let detailViewController = DetailViewController(task: task, mode: .update)
        detailViewController.delegate = self
        
        self.present(detailViewController, animated: true)
    }
}

extension DoneViewController: TaskFetchDelegate {
    func fetchTaskList() {
        self.viewModel.updateSnapshot()
        self.viewModel.applySnapshot()
    }
    
    func updateTaskCell(id: UUID?) {
        guard let id else { return }
        self.viewModel.updateTask(id: id)
    }
}
