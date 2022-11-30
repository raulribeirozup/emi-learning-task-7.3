//
//  LivrosViewController.swift
//  LearningTask-7.3
//
//  Created by rafael.rollo on 16/05/2022.
//

import UIKit

class LivrosViewController: UICollectionViewController {

    var livrosAPI: LivrosAPI?
    var livros: [Livro] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTheme()
        carregaLivros()
    }
    
    private func carregaLivros() {
        guard let livrosAPI = livrosAPI else { return }
        livros = livrosAPI.carregaLivros()
    }
    
}

// MARK: - UICollectionViewDataSource implementations
extension LivrosViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        livros.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LivroViewCell", for: indexPath) as? LivroViewCell else {
            fatalError("Couldn't load LivroViewCell")
        }
        
        let livro = livros[indexPath.row]
        
        cell.livroImageView.image = UIImage(named: livro.titulo)
        cell.tituloLabel.text = livro.titulo
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TituloSectionHeaderView", for: indexPath)
    }
}

extension LivrosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
                fatalError("Esperado que a lista de livros trabalhe com base em UICollectionViewFlowLayout")
            }
            
            let itemsPerLine: CGFloat = 2
            
            let sectionMargins = flowLayout.sectionInset
            let itemsSpacing = flowLayout.minimumInteritemSpacing
            
            let utilArea = collectionView.bounds.width - (sectionMargins.left + sectionMargins.right) - itemsSpacing * (itemsPerLine - 1)
            
            let itemWidth = utilArea / itemsPerLine
            
            return CGSize(width: itemWidth, height: itemWidth * 1.67)
        }
}
