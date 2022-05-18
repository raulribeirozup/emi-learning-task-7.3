//
//  Theme.swift
//  LearningTask-7.3
//
//  Created by rafael.rollo on 16/05/2022.
//

import UIKit

protocol ThemeConfigurable: UIViewController {
    func applyTheme()
}

extension ThemeConfigurable {
    func applyTheme() {
        configureStatusBar()
        configureNavigationItem()
    }
    
    private func configureStatusBar() {
        navigationController?.setStatusBar(backgroundColor: .texasRose)
        navigationController?.navigationBar.barStyle = .black
    }
    
    private func configureNavigationItem() {
        let titleView = UIImageView(image: .init(named: "LogoTypo"))
        titleView.tintColor = .white
        titleView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = titleView
    }
}

extension UIViewController: ThemeConfigurable {}

extension UINavigationController {
    fileprivate func setStatusBar(backgroundColor: UIColor) {
        let statusBarFrame: CGRect
        
        if #available(iOS 13.0, *) {
            statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        } else {
            statusBarFrame = UIApplication.shared.statusBarFrame
        }
        
        let statusBarView = UIView(frame: statusBarFrame)
        statusBarView.backgroundColor = backgroundColor
        
        view.addSubview(statusBarView)
    }
}

extension UIColor {
    static var texasRose: UIColor = .init(named: "Texas Rose") ?? .systemOrange
}

