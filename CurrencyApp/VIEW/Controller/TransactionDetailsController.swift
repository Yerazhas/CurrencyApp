//
//  TransactionDetailsController.swift
//  CurrencyApp
//
//  Created by Yerassyl Zhassuzakhov on 11/26/18.
//  Copyright © 2018 Yerassyl Zhassuzakhov. All rights reserved.
//

import UIKit

class TransactionDetailsController: UIViewController {
    private let viewModel: BitcoinTransactionDetailsViewModel
    
    init(viewModel: BitcoinTransactionDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel.completion = { [unowned self] transaction in
            self.transactionHeaderView.amountLabel.text = transaction.amount
            self.transactionHeaderView.dateLabel.text = transaction.date
            self.transactionHeaderView.transactionTypeView.image = TransactionType(rawValue: transaction.type)! == .sell ? #imageLiteral(resourceName: "sell") : #imageLiteral(resourceName: "buy")
            self.priceLabel.text = transaction.price
        }
        viewModel.getData()
    }
    
    private func setupViews() {
        edgesForExtendedLayout = []
        view.backgroundColor = .white
        view.addSubview(transactionHeaderView)
        view.addSubview(priceLabel)
        transactionHeaderView.snp.makeConstraints { (make) in
            make.right.top.left.equalToSuperview()
            make.height.equalTo(110)
        }
        priceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(transactionHeaderView.snp.bottom)
            make.left.equalTo(view.snp.left).offset(15)
        }
    }
    
    lazy var transactionHeaderView: TransactionView = {
        let thv = TransactionView(frame: .zero)
        
        return thv
    }()
    
    lazy var priceLabel: UILabel = {
        let pl = UILabel()
        pl.textAlignment = .left
        pl.textColor = .mainGray
        
        return pl
    }()
}
