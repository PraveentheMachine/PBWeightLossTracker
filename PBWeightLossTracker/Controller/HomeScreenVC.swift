//
//  HomeScreenVC.swift
//  PBWeightLossTracker
//
//  Created by Praveen Bandarage on 2/02/21.
//

import UIKit
import Charts
import RealmSwift

class HomeScreenVC: UIViewController {
    
    let realm = try! Realm() //Needed for initalisation of Realm
    var weightObjects : Results<WeightObject>? //Collection used to store weighted objects gathered from Realm
    

    let halfCircleForProgress = CAShapeLayer()
    
    var progressViewRec: RectangleView?  //The top view of the controller which houses the progress half circle and associated labels/fields
    var chartViewRec: RectangleView? //Middle view which stores the chart representing the data
    let addWeightButton = UIButton() //Bottom portion of view controller which handles the adding of new weight and subsequent
    var weightTextField: UITextField?
    
    
    let screenSize: CGRect = UIScreen.main.bounds //Used to calculate dimensions across multiple devices



    lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        
        //charview speicif configurations
        chartView.backgroundColor = .white
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.pinchZoomEnabled = false
        chartView.doubleTapToZoomEnabled = false
        chartView.rightAxis.enabled = false
        chartView.chartDescription?.enabled = false
        chartView.animate(xAxisDuration: 0.5)
        
        //Y-Axis configurations
        let yAxis = chartView.leftAxis
        
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.setLabelCount(6, force: false)
        yAxis.labelTextColor = .gray
        yAxis.axisLineColor = .gray
        yAxis.labelPosition = .outsideChart
        
        //X axis configurations
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .boldSystemFont(ofSize: 12)
        xAxis.setLabelCount(6, force: false)
        xAxis.axisLineColor = .gray
        xAxis.labelTextColor = .gray
        xAxis.labelWidth = 0

        
        return chartView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        while(weightObjects?.count==nil){
            self.weightObjects = realm.objects(WeightObject.self)
        }
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print("ENTRTY")
    }
    
    func setChart(){
        print("WE Start HERE")
   
        while(self.weightObjects?.count == nil){
        self.weightObjects = self.realm.objects(WeightObject.self)
        }
    
        print(Realm.Configuration.defaultConfiguration.fileURL!)

        if(weightObjects?.count == 0 || weightObjects?.count == nil){
            print("YOU SHALL NOT PASS")
           
        }
        else{
        print("WE GOT HERE2")
        while(self.weightObjects?.count == nil){
        self.weightObjects = self.realm.objects(WeightObject.self)
        }
        print("WE GOT HERE3 \(weightObjects?.count)")
        
        
        let currentDate = weightObjects?[0].dateOfEntry
        print(currentDate)
        let string = getCurrentDate(date: (weightObjects?[0].dateOfEntry)!)
        
        let currentDateTest = string
       
        let currentWeightTest: Double = weightObjects?[0].weight ?? 0.0

        let months = [currentDateTest,currentDateTest]
        
//        print(totalw?.count)
        let unitsSold = [currentWeightTest,currentWeightTest]
        
            lineChartView.setBarChartData(xValues: months, yValues: unitsSold)
        
        }
    }
    
    private func getCurrentDate(date: Date) -> String{
        let currentDateTime = date
        
        
        //Initilaising
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        
        let dateString = formatter.string(from: currentDateTime)
        print(dateString)
        return dateString
    }
    
    
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitle("Add Weight", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 9
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont(name: Fonts.monsterratebold, size: 20.0)
        return button
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressViewRec = RectangleView(xPosition: 22, yPosition: Int(screenSize.height*0.085), rectangleHeight: Int(screenSize.height*0.33))
        chartViewRec = RectangleView(xPosition: 22, yPosition: Int(screenSize.height*0.45), rectangleHeight: Int(screenSize.height*0.33))
        setup()

        
    }
    
    let currentWeight: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: Fonts.monsterratebold, size: 48)
        label.text = "85.5kg"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
//        label.font = label.font.withSize(45)
        return label
    }()
    

    private func setupProgressCount(){
        let center = CGPoint(x: (progressViewRec!.frame.minX+progressViewRec!.frame.maxX)/2, y: (progressViewRec?.frame.height)! * 0.95)
        let circularPath = UIBezierPath(arcCenter: center, radius:(progressViewRec?.frame.width)!/2.6, startAngle: .pi, endAngle: 2 * .pi, clockwise: true)
        
        //create my track layer
        let trackLayer = CAShapeLayer()
        trackLayer.path = circularPath.cgPath
        
        trackLayer.strokeColor = UIColor(red: 0.86, green: 0.87, blue: 0.88, alpha: 1.00).cgColor
        trackLayer.lineWidth = 30
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = .round
        view.layer.addSublayer(trackLayer)
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.white.cgColor, UIColor.black.cgColor]
        halfCircleForProgress.path = circularPath.cgPath
        halfCircleForProgress.strokeColor = UIColor.systemPink.cgColor
        halfCircleForProgress.lineWidth = 30
        halfCircleForProgress.fillColor = UIColor.clear.cgColor
        halfCircleForProgress.lineCap = .round
        view.layer.addSublayer(halfCircleForProgress)
//        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        halfCircleForProgress.strokeEnd = 0
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 74.00/95.00
        basicAnimation.duration = 2
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        halfCircleForProgress.add(basicAnimation, forKey: "ur")
        
    }
    private func setup(){
        
        view.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.98, alpha: 1.00)
//        view.addSubview(progressView)

        view.addSubview(progressViewRec!)
        view.addSubview(chartViewRec!)
        view.addSubview(addWeightButton)
        
        
//        blueView.translatesAutoresizingMaskIntoConstraints = false
//        blueView.heightAnchor.constraint(equalToConstant: screenSize.height*0.93).isActive = true
//        blueView.yPosition = 100
//        blueView.backgroundColor = .black
        chartViewRec!.addSubview(lineChartView)
        setupProgressCount()
        progressViewRec!.addSubview(currentWeight)

        currentWeight.translatesAutoresizingMaskIntoConstraints = false
        currentWeight.centerYAnchor.constraint(equalTo: progressViewRec!.centerYAnchor).isActive =  true
        currentWeight.centerXAnchor.constraint(equalTo: progressViewRec!.centerXAnchor).isActive = true
        
        let beginningWeight = ProgressLabel(frame: UIView().frame, string: "64.0")
        view.addSubview(beginningWeight)
        beginningWeight.translatesAutoresizingMaskIntoConstraints = false
        beginningWeight.topAnchor.constraint(equalTo: progressViewRec!.bottomAnchor, constant: screenSize.height * -0.082).isActive = true
        beginningWeight.leadingAnchor.constraint(equalTo: progressViewRec!.leadingAnchor, constant: (screenSize.width*0.0760)).isActive = true
        
        let goalWeight = ProgressLabel(frame: UIView().frame, string: "94.0")
        view.addSubview(goalWeight)
        
        goalWeight.translatesAutoresizingMaskIntoConstraints = false
        goalWeight.topAnchor.constraint(equalTo: progressViewRec!.bottomAnchor, constant: screenSize.height * -0.082).isActive = true
        goalWeight.trailingAnchor.constraint(equalTo: progressViewRec!.trailingAnchor, constant: (screenSize.width * -0.0740)).isActive = true
        
        addWeightButton.translatesAutoresizingMaskIntoConstraints = false
        addWeightButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        addWeightButton.widthAnchor.constraint(equalTo: chartViewRec!.widthAnchor).isActive = true
        addWeightButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addWeightButton.topAnchor.constraint(equalTo: chartViewRec!.bottomAnchor, constant: screenSize.height*0.05).isActive = true
        addWeightButton.backgroundColor = .systemPink
        addWeightButton.layer.cornerRadius = 25
        addWeightButton.setTitle("Add Weight", for: .normal)
        


        setChart()


        lineChartView.translatesAutoresizingMaskIntoConstraints = false
        lineChartView.topAnchor.constraint(equalTo: chartViewRec!.topAnchor,constant: 25).isActive = true
        lineChartView.widthAnchor.constraint(equalTo: chartViewRec!.widthAnchor,constant: -10).isActive = true
        lineChartView.leadingAnchor.constraint(equalTo: chartViewRec!.leadingAnchor).isActive = true
        lineChartView.trailingAnchor.constraint(equalTo: chartViewRec!.trailingAnchor,constant: -10).isActive = true
        lineChartView.heightAnchor.constraint(equalTo: chartViewRec!.heightAnchor, constant: -10).isActive = true
        addWeightButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
//
    }
    
    @objc private func didTapButton(){
        let alertController = UIAlertController(title: "Add your weight in KG", message: nil, preferredStyle: .alert)
        alertController.addTextField(configurationHandler: weightTextFieldHandler)
        
        let submitAction = UIAlertAction(title: "Submit Weight", style: .default, handler: {_ in
        alertController.dismiss(animated: true, completion: nil)

            //Need to handle invalid inputs
            
            do{
                try self.realm.write{
                    let newWeightObj = WeightObject()
                    let weight = Double((self.weightTextField?.text)!)
                    newWeightObj.weight = weight!
                    newWeightObj.dateOfEntry = Date()
                    self.realm.add(newWeightObj)
                    }
                }
            catch{
                
            }
                
            })
            
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alertController.addAction(submitAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }

    
    //push to another view controller
    func okHandler(alert: UIAlertAction){
//        alert.dismi
    }
    
    func weightTextFieldHandler(textField: UITextField){
        weightTextField = textField
        weightTextField?.placeholder = "JJJJJJJ"
    }
    
    
    public func convertDateToString() -> String{
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"
       return dateFormatter.string(from: date)
       
    }
}





//Mark


extension LineChartView {

    private class BarChartFormatter: NSObject, IAxisValueFormatter {
        
        var labels: [String] = []
        
        func stringForValue(_ value: Double, axis: AxisBase?) -> String {
            return labels[Int(value)]
        }
        
        init(labels: [String]) {
            super.init()
            self.labels = labels
        }
    }
    
    func setBarChartData(xValues: [String], yValues: [Double]) {
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<yValues.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: yValues[i])
            
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = LineChartDataSet(entries: dataEntries)
        let chartData = LineChartData(dataSet: chartDataSet)
        chartDataSet.setColor(.systemPink)
        chartDataSet.fill = Fill(CGColor: UIColor.systemPink.cgColor)
        
        chartDataSet.mode = .horizontalBezier
        chartDataSet.lineWidth = 3
               chartDataSet.drawCirclesEnabled = true
        chartDataSet.fillAlpha = 0.8
               chartDataSet.drawFilledEnabled = false
        chartDataSet.circleColors = [NSUIColor(cgColor: UIColor.systemPink.cgColor)]
//        let arrayWithNoOptionals = xValues.compactMap { $0 }

        let chartFormatter = BarChartFormatter(labels: xValues)
        let xAxis = XAxis()
        xAxis.granularityEnabled = true
        self.xAxis.setLabelCount(xValues.count, force: true)


        xAxis.granularity = 1
        xAxis.valueFormatter = chartFormatter
        self.xAxis.valueFormatter = xAxis.valueFormatter
    
        
        self.data = chartData
    }
}
