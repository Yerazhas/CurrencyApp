//
//  TransactionView.swift
//  CurrencyApp
//
//  Created by Yerassyl Zhassuzakhov on 11/26/18.
//  Copyright © 2018 Yerassyl Zhassuzakhov. All rights reserved.
//

import UIKit

@objcMembers class TransactionView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .white
        addSubview(amountLabel)
        addSubview(dateLabel)
        addSubview(transactionTypeView)
        
        amountLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
        }
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(amountLabel.snp.bottom).offset(10)
            make.left.equalTo(amountLabel.snp.left)
        }
        transactionTypeView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
            make.height.width.equalTo(40)
        }
    }
    
    lazy var amountLabel: UILabel = {
        let al = UILabel()
        al.textAlignment = .left
        al.font = UIFont.systemFont(ofSize: 37)
        al.textColor = .mainGray
        
        return al
    }()
    
    lazy var dateLabel: UILabel = {
        let dl = UILabel()
        dl.textAlignment = .left
        dl.textColor = .mainYellow
        
        return dl
    }()
    
    lazy var transactionTypeView: UIImageView = {
        let ttv = UIImageView()
        
        return ttv
    }()
}
