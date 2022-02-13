//
//  ViewController.swift
//  CompositionalLayoutUsingCollectionView
//
//  Created by Sivaram Yadav on 2/11/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    func setupCollectionView() {
//        let searchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let searchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: getCompositionalLayout())
        let rect = self.view.bounds
        searchCollectionView.frame = CGRect(origin: rect.origin, size: rect.size)
        searchCollectionView.dataSource = self
        searchCollectionView.delegate = self
        searchCollectionView.backgroundColor = .white
        searchCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        self.view.addSubview(searchCollectionView)
    }

    func getCompositionalLayout() -> UICollectionViewCompositionalLayout{
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1/3)
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 1, leading: 1, bottom: 1, trailing: 1
        )
        
        
        
        // --------- Group 1 -------------

        let group1Item1 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1)))
        group1Item1.contentInsets = NSDirectionalEdgeInsets(
            top: 1, leading: 1, bottom: 1, trailing: 1
        )
        
        let nestedNestedGroup1Item1 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1)))
        nestedNestedGroup1Item1.contentInsets = NSDirectionalEdgeInsets(
            top: 1, leading: 1, bottom: 1, trailing: 1
        )
        
        let nestedNestedGroup1 = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/2)), subitems: [nestedNestedGroup1Item1])
        

        // --------- Nested Group 1 Indide Group 1 -------------
        let nestedGroup1Item1 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/2)))
        nestedGroup1Item1.contentInsets = NSDirectionalEdgeInsets(
            top: 1, leading: 1, bottom: 1, trailing: 1
        )
        
        let nestedGroup1 = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1)), subitems: [nestedGroup1Item1, nestedNestedGroup1])
        
        let group1 = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/3)), subitems: [group1Item1, nestedGroup1])
        
        // --------- Group 2 -------------

        let group2Item1 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1)))
        group2Item1.contentInsets = NSDirectionalEdgeInsets(
            top: 1, leading: 1, bottom: 1, trailing: 1
        )

        let group2 = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/3)), subitems: [group2Item1])

        
        // --------- Container Group -------------
        
        let containerGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(600)
            ),
            subitems: [item, group1, group2]
        )
        
        let section = NSCollectionLayoutSection(group: containerGroup)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 80
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath)
        cell.backgroundColor = .random
        
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegate {
    
}

extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0.4...1),
            green: .random(in: 0.4...1),
            blue: .random(in: 0.4...1), alpha: 1
        )
    }
}
