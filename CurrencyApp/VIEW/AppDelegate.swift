//
//  AppDelegate.swift
//  CurrencyApp
//
//  Created by Yerassyl Zhassuzakhov on 11/24/18.
//  Copyright © 2018 Yerassyl Zhassuzakhov. All rights reserved.
//

import UIKit
import SnapKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let tabBarController = UITabBarController()
        let bitcoinTitle = "Bitcoin"
        let transactionsTitle = "Transactions"
        
        // first view controller
        let networkManager = NetworkManager(parser: CustomParser())
        let bitcoinViewModel = BitcointRateViewModel(networkManager: networkManager)
        let currencyViewModel = CurrencyRateViewModel(networkManager: networkManager)
        let bitcoinVC = BitcoinRateController(bitcoinViewModel: bitcoinViewModel, currencyViewModel: currencyViewModel)
        bitcoinVC.title = bitcoinTitle
        
        // second view controller
        let bitcoinTransactionsViewModel = BitcoinTransactionsViewModel(networkManager: networkManager)
        let transactionVC = BitcoinTransactionsController(viewModel: bitcoinTransactionsViewModel)
        transactionVC.title = transactionsTitle
        
        bitcoinVC.tabBarItem = UITabBarItem(title: bitcoinTitle, image: #imageLiteral(resourceName: "bitcoin").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "bitcoin").withRenderingMode(.alwaysOriginal))
        transactionVC.tabBarItem = UITabBarItem(title: transactionsTitle, image: #imageLiteral(resourceName: "transaction").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "transaction").withRenderingMode(.alwaysOriginal))
        
        let viewControllers = [bitcoinVC.inNavigation(), transactionVC.inNavigation()]
        tabBarController.tabBar.tintColor = .mainGray
        tabBarController.viewControllers = viewControllers
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }
}

