//
//  TransactionCell.swift
//  CurrencyApp
//
//  Created by Yerassyl Zhassuzakhov on 11/25/18.
//  Copyright © 2018 Yerassyl Zhassuzakhov. All rights reserved.
//

import UIKit

enum TransactionType: String {
    case buy = "0"
    case sell = "1"
}

class TransactionCell: UITableViewCell {
    var transactionType: TransactionType = .sell {
        willSet {
            transactionView.transactionTypeView.image =  newValue == .buy ? #imageLiteral(resourceName: "sell") : #imageLiteral(resourceName: "buy")
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(transactionView)
        
        transactionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func configureWithTransaction(_ transaction: Transaction) {
        transactionView.amountLabel.text = transaction.amount
        transactionView.dateLabel.text = transaction.date
        transactionType = TransactionType(rawValue: transaction.type)!
    }
    
    lazy var transactionView: TransactionView = {
        let tv = TransactionView(frame: .zero)
        
        return tv
    }()
}
