//
//  BitcoinRateController.swift
//  CurrencyApp
//
//  Created by Yerassyl Zhassuzakhov on 11/24/18.
//  Copyright © 2018 Yerassyl Zhassuzakhov. All rights reserved.
//

import UIKit
import Charts

class BitcoinRateController: ScrollableController {
    private let bitcoinViewModel: BitcointRateViewModel
    private let currencyViewModel: CurrencyRateViewModel
    private var currentDateElement: DateElementType
    private (set) var timeInterval: TimePeriod = .week {
        didSet {
            self.getBitcoinRate()
        }
    }
    private (set) var currencyType: CurrencyType = .kzt {
        didSet {
            self.getCurrencyRate()
            self.getBitcoinRate()
        }
    }
    private let timeIntervals: [TimePeriod] = [.week, .month, .year]
    private let currencyTypes: [CurrencyType] = [.kzt, .usd, .eur]
    private (set) var timeIntervalIndex = 0 {
        didSet {
            guard timeIntervalIndex < timeIntervals.count else { return }
            let timeInterval = timeIntervals[timeIntervalIndex]
            self.currentDateElement = .date(Date().getDateElement(timeInterval: timeInterval))
            self.timeInterval = timeInterval
        }
    }
    private (set) var currencyTypeIndex = 0 {
        didSet {
            guard currencyTypeIndex < currencyTypes.count else { return }
            self.currencyType = currencyTypes[currencyTypeIndex]
        }
    }
    private var formatter: LineChartFormatter!
    private let xAxis = XAxis()
    
    init(bitcoinViewModel: BitcointRateViewModel, currencyViewModel: CurrencyRateViewModel) {
        self.bitcoinViewModel = bitcoinViewModel
        self.currencyViewModel = currencyViewModel
        self.currentDateElement = .date(Date().getDateElement(timeInterval: timeInterval))
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        getCurrencyRate()
        getBitcoinRate()
    }
    
    private func setupViews() {
        edgesForExtendedLayout = []
        view.backgroundColor = .white
        scrollViewContentView.addSubview(timeSegment)
        scrollViewContentView.addSubview(currencySegment)
        scrollViewContentView.addSubview(currencyRateLabel)
        scrollViewContentView.addSubview(lineChart)
        
        timeSegment.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(60)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(220)
        }
        currencySegment.snp.makeConstraints { (make) in
            make.top.equalTo(timeSegment.snp.bottom).offset(10)
            make.centerX.equalTo(timeSegment.snp.centerX)
            make.height.equalTo(40)
            make.width.equalTo(220)
        }
        currencyRateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(currencySegment.snp.bottom).offset(15)
            make.left.right.equalToSuperview()
            make.height.equalTo(100)
        }
        lineChart.snp.makeConstraints { (make) in
            make.top.equalTo(currencyRateLabel.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            let width = Constants.screenWidth
            make.width.equalTo(width * 0.8)
            make.height.equalTo(width * 1.1)
            make.bottom.equalTo(scrollViewContentView.snp.bottom).offset(-20)
        }
    }
    
    private func getCurrencyRate() {
        let sv = UIViewController.displaySpinner(onView: currencyRateLabel)
        currencyViewModel.getCurrecyRates(currency: currencyType)
        currencyViewModel.completion = { [unowned self] bpi in
            UIViewController.removeSpinner(spinner: sv)
            guard let currencyRate = bpi[self.currencyType.name] else { return }
            self.currencyRateLabel.text = currencyRate.prettyDescription
        }
    }
    
    private func getBitcoinRate() {
        let sv = UIViewController.displaySpinner(onView: view)
        bitcoinViewModel.getCurrencyData(currencyType: self.currencyType, date: currentDateElement)
        bitcoinViewModel.completion = { [unowned self] bpi in
            UIViewController.removeSpinner(spinner: sv)
            switch self.timeInterval {
            case .week:
                let dataByDays = bpi.map { $0.value }
                var xLabels = [String]()
                var yValues = [Double]()
                print(dataByDays.count)
                for i in 0..<dataByDays.count {
                    xLabels.append(Week(rawValue: "\(i + 1)")!.name)
                    yValues.append(dataByDays[i])
                }
                self.updateLineChart(xValues: xLabels, yValues: yValues)
                
            case .month:
                let dataByDays = bpi.map { $0.value }
                let dataByWeeks = dataByDays.chunked(into: 7)
                let averagedDataByWeeks = dataByWeeks.map { $0.average() }
                var xLabels = [String]()
                var yValues = [Double]()
                print(dataByWeeks.count)
                for i in 0..<averagedDataByWeeks.count {
                    xLabels.append("\(i + 1)")
                    yValues.append(averagedDataByWeeks[i])
                }
                print(xLabels)
                self.updateLineChart(xValues: xLabels, yValues: yValues)
                
            case .year:
                let dataByDays = bpi.map { $0.value }
                let dataByMonths = dataByDays.chunked(into: 30)
                let averagedByMonths = dataByMonths.map { $0.average() }
                var xLabels = [String]()
                var yValues = [Double]()
                print(dataByDays.count)
                for i in 0..<averagedByMonths.count {
                    xLabels.append(Year(rawValue: "\(i + 1)")!.name)
                    yValues.append(averagedByMonths[i])
                }
                self.updateLineChart(xValues: xLabels, yValues: yValues)
            }
        }
    }
    
    private func updateLineChart(xValues: [String], yValues: [Double]) {
        formatter = LineChartFormatter(values: xValues)
        var entries = [ChartDataEntry]()
        for i in 0..<xValues.count {
            let dataEntry = ChartDataEntry(x: Double(i + 1), y: yValues[i])
            entries.append(dataEntry)
            formatter.stringForValue(Double(i), axis: xAxis)
        }
        xAxis.valueFormatter = formatter
        let chartDataSet = LineChartDataSet(values: entries, label: nil)
        chartDataSet.colors = [.black]
        let lineChartData = LineChartData(dataSet: chartDataSet)
        lineChart.data = lineChartData
        lineChart.xAxis.valueFormatter = xAxis.valueFormatter
    }
    
    @objc private func segmentAction(_ sender: UISegmentedControl) {
        if sender.tag == 1 {
            timeIntervalIndex = sender.selectedSegmentIndex
        } else {
            currencyTypeIndex = sender.selectedSegmentIndex
        }
    }
    
    lazy var timeSegment: UISegmentedControl = {
        let sc = UISegmentedControl(items: timeIntervals.map { $0.name })
        sc.selectedSegmentIndex = timeIntervalIndex
        sc.tag = 1
        sc.tintColor = .mainGray
        sc.addTarget(self, action: #selector(segmentAction(_:)), for: .valueChanged)
        
        return sc
    }()
    
    lazy var currencySegment: UISegmentedControl = {
        let sc = UISegmentedControl(items: currencyTypes.map { $0.name })
        sc.selectedSegmentIndex = currencyTypeIndex
        sc.tag = 2
        sc.tintColor = .mainGray
        sc.addTarget(self, action: #selector(segmentAction(_:)), for: .valueChanged)
        
        return sc
    }()
    
    lazy var lineChart: LineChartView = {
        let lc = LineChartView(frame: .zero)
        lc.isUserInteractionEnabled = false
        lc.backgroundColor = .white
        
        return lc
    }()
    
    lazy var currencyRateLabel: UILabel = {
        let crl = UILabel()
        crl.textAlignment = .center
        crl.font = UIFont.systemFont(ofSize: 20)
        crl.textColor = .mainYellow
        crl.text = "Current rate of currency to bitcoin"
        crl.numberOfLines = 0
        
        return crl
    }()
}
