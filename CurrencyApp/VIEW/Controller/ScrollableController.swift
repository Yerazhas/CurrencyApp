//
//  ScrollableController.swift
//  CurrencyApp
//
//  Created by Yerassyl Zhassuzakhov on 11/25/18.
//  Copyright © 2018 Yerassyl Zhassuzakhov. All rights reserved.
//

import UIKit

class ScrollableController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(scrollViewContentView)
        
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.snp.edges)
        }
        
        scrollViewContentView.snp.makeConstraints { (make) in
            make.edges.equalTo(scrollView.snp.edges)
            make.width.equalTo(view.snp.width)
        }
    }
    
    lazy var scrollViewContentView: UIView = {
        let sv = UIView(frame: view.frame)
        
        return sv
    }()
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView(frame: view.frame)
        
        return sv
    }()
}
