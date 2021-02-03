//
//  HomeScreenVC.swift
//  PBWeightLossTracker
//
//  Created by Praveen Bandarage on 2/02/21.
//

import UIKit
import Charts

class HomeScreenVC: UIViewController {
    
    
    lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.backgroundColor = UIColor(red: 0.09, green: 0.09, blue: 0.18, alpha: 1.00)
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.leftAxis.drawGridLinesEnabled = false
        chartView.pinchZoomEnabled = false
        chartView.doubleTapToZoomEnabled = false
        chartView.rightAxis.enabled = false
        
        let yAxis = chartView.leftAxis
        
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.setLabelCount(6, force: false)
        yAxis.labelTextColor = .white
        yAxis.axisLineColor = .white
        yAxis.labelPosition = .outsideChart
        
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .boldSystemFont(ofSize: 12)
        xAxis.setLabelCount(6, force: false)
//        xAxis.axisLineColor = .systemBlue
        xAxis.axisLineColor = .white
        xAxis.labelTextColor = .white
        xAxis.labelWidth = 0
        
        chartView.animate(xAxisDuration: 0.5)
        
        return chartView
    }()
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print("ENTRTY")
    }
    
    func setData(){
        print("BEING CALLEDC")
        let set1 = LineChartDataSet(entries: yValues, label: "WeightOfGorila")
        set1.mode = .cubicBezier
        set1.lineWidth = 3
        set1.drawCirclesEnabled = false
        set1.setColor(.white)
        set1.fill = Fill(color: .orange)
        set1.fillAlpha = 0.8
        set1.drawFilledEnabled = true
        set1.drawHorizontalHighlightIndicatorEnabled = false
        let data = LineChartData(dataSet: set1)
        data.setDrawValues(false)
        lineChartView.data = data
    }

    let yValues: [ChartDataEntry] = [
    
        ChartDataEntry(x: 0.0, y: 5.0),
        ChartDataEntry(x: 1.0, y: 16.0),
        ChartDataEntry(x: 2.0, y: 19.0),
        ChartDataEntry(x: 3.0, y: 14.0),
        ChartDataEntry(x: 4.0, y: 21.0),
        ChartDataEntry(x: 5.0, y: 19.0),
        ChartDataEntry(x: 6.0, y: 55.0)

    ]


    
    
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitle("Add Weight", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 9
        button.layer.masksToBounds = true
        return button
        
    }()
    
    private let progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.trackTintColor = .gray
        progressView.progressTintColor = .systemOrange
        return progressView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

        
    }
    
    let weightMeasurementLabel: UILabel = {
       let label = UILabel()
        label.text = "kg"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    let weightLabel: UILabel = {
       let label = UILabel()
        label.text = "65.0"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    let startingWeightMeasurementLabel: UILabel = {
       let label = UILabel()
        label.text = "kg"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    let startingWeightLabel: UILabel = {
       let label = UILabel()
        label.text = "91.0"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    let endingWeightMeasurementLabel: UILabel = {
       let label = UILabel()
        label.text = "kg"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    let endingWeightLabel: UILabel = {
       let label = UILabel()
        label.text = "50.0"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    
    
    
    private func setup(){
        
        view.backgroundColor = UIColor(red: 0.09, green: 0.09, blue: 0.18, alpha: 1.00)
//        view.addSubview(button)
        view.addSubview(progressView)
        view.addSubview(weightLabel)
        view.addSubview(startingWeightLabel)
        view.addSubview(startingWeightMeasurementLabel)
        view.addSubview(endingWeightLabel)
        view.addSubview(endingWeightMeasurementLabel)
        view.addSubview(lineChartView)
        
        
        setData()
        progressView.frame = CGRect(x: 20, y: 160, width: view.frame.size.width-40, height: 35)
        progressView.setProgress(0.5, animated: true)
        
        progressView.layer.cornerRadius = 8.0
        progressView.transform=CGAffineTransform(scaleX: 1.0, y: 7.0)
        progressView.clipsToBounds = true

        // Set the rounded edge for the inner bar
        progressView.layer.cornerRadius = 8
        progressView.clipsToBounds = true
        progressView.layer.sublayers![1].cornerRadius = 8
        progressView.subviews[1].clipsToBounds = true

        view.addSubview(weightMeasurementLabel)
        weightMeasurementLabel.centerXAnchor.constraint(equalTo: progressView.centerXAnchor, constant: 68).isActive = true
        weightMeasurementLabel.bottomAnchor.constraint(equalTo: progressView.topAnchor, constant: -20).isActive = true
        weightMeasurementLabel.font = weightMeasurementLabel.font.withSize(22.5)
//        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
//        button.center = view.center
//        button.frame = CGRect(x:0,y:150,width: 220, height: 55)
        
        startingWeightLabel.bottomAnchor.constraint(equalTo: weightMeasurementLabel.topAnchor, constant: 12).isActive = true
        startingWeightLabel.leadingAnchor.constraint(equalTo: progressView.leadingAnchor).isActive = true
        startingWeightLabel.font = startingWeightLabel.font.withSize(25)
        startingWeightMeasurementLabel.trailingAnchor.constraint(equalTo: startingWeightLabel.trailingAnchor, constant: 20).isActive = true
        startingWeightMeasurementLabel.centerYAnchor.constraint(equalTo: startingWeightLabel.centerYAnchor).isActive = true
        
        
        endingWeightLabel.bottomAnchor.constraint(equalTo: weightMeasurementLabel.topAnchor, constant: 12).isActive = true
        endingWeightLabel.trailingAnchor.constraint(equalTo: progressView.trailingAnchor,constant: -20).isActive = true
        endingWeightLabel.font = startingWeightLabel.font.withSize(25)
        endingWeightMeasurementLabel.trailingAnchor.constraint(equalTo: endingWeightLabel.trailingAnchor, constant: 20).isActive = true
        endingWeightMeasurementLabel.centerYAnchor.constraint(equalTo: endingWeightLabel.centerYAnchor).isActive = true
        
        
        
        weightLabel.bottomAnchor.constraint(equalTo: weightMeasurementLabel.bottomAnchor ,constant: 12).isActive = true
        weightLabel.centerXAnchor.constraint(equalTo: progressView.centerXAnchor, constant: -12).isActive = true
//        weightLabel.translatesAutoresizingMaskIntoConstraints = false
//        weightLabel.trailingAnchor.constraint(equalTo: weightMeasurementLabel.leadingAnchor, constant: -3).isActive = true
//        weightLabel.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 60).isActive = true
        weightLabel.font = weightLabel.font.withSize(65)
        
        lineChartView.translatesAutoresizingMaskIntoConstraints = false
        lineChartView.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -250).isActive = true
        lineChartView.widthAnchor.constraint(equalTo: progressView.widthAnchor).isActive = true
        lineChartView.leadingAnchor.constraint(equalTo: progressView.leadingAnchor).isActive = true
        lineChartView.trailingAnchor.constraint(equalTo: progressView.trailingAnchor).isActive = true
        lineChartView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
    }
    
    @objc private func didTapButton(){
        print("BUTTON TAPPED")
    }
}


//    func setCorner(withRadius:Int, borderWidth:Int = 0, color: UIColor = .clear){
//        self.layer.cornerRadius = radius
//        self.layer.borderColor = color
//        self.layer.borderWidth = borderWidth
//        self.clipsToBounds = true
//    }
//}
