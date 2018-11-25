// BitcoinTransactionsController.swift
// CurrencyApp
//
// Created by Yerassyl Zhassuzakhov on 11/25/18.
//Copyright © 2018 Yerassyl Zhassuzakhov. All rights reserved.
//

import UIKit

class BitcoinTransactionsController: UIViewController {
    private let viewModel: BitcoinTransactionsViewModel
    private let cellId = "cellId"
    
    init(viewModel: BitcoinTransactionsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        getTransactions()
    }
    
    private func setupViews() {
        edgesForExtendedLayout = []
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        tableView.separatorStyle = .none
    }
    
    private func getTransactions() {
        let sv = UIViewController.displaySpinner(onView: view)
        viewModel.getTransactions()
        viewModel.completion = { [unowned self] _ in
            self.tableView.reloadData()
            UIViewController.removeSpinner(spinner: sv)
        }
    }
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.dataSource = self
        tv.delegate = self
        tv.register(TransactionCell.self, forCellReuseIdentifier: cellId)
        tv.rowHeight = 110
        
        return tv
    }()
        
}

extension BitcoinTransactionsController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.currentData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TransactionCell
        let transaction = viewModel.currentData[indexPath.row]
        cell.configureWithTransaction(transaction)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let transaction = TransactionViewModel(transaction: viewModel.currentData[indexPath.row])
        let vc = TransactionDetailsController(viewModel: BitcoinTransactionDetailsViewModel(transaction: transaction))
        navigationController?.pushViewController(vc, animated: true)
    }
}
