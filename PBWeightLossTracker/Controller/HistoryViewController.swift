//
//  HistoryViewController.swift
//  PBWeightLossTracker
//
//  Created by Praveen Bandarage on 2/02/21.
//

import UIKit
import RealmSwift
class HistoryViewController: UITableViewController {
    let realm = try! Realm()
    var weightsAdded : Results<WeightObject>?
   

   
    
    func loadWeights(){
        while weightsAdded?.count==nil {
            print("YOLO")
                    
                self.weightsAdded = self.realm.objects(WeightObject.self)
        }
        weightsAdded = realm.objects(WeightObject.self).sorted(byKeyPath: "dateOfEntry", ascending: false)
        tableView.reloadData()
        
    }
       override func viewWillAppear(_ animated: Bool) {
        print("VIEW WILL APPEAR")
        loadWeights()
       }
    override func viewDidLoad() {
      
        super.viewDidLoad()
        
        print("WE DONE")
        loadWeights()

        navigationItem.title = "WeightLossHistory"
        tableView.register(MyCell.self, forCellReuseIdentifier: "cellID")
        //UIColor(red: 0.17, green: 0.17, blue: 0.29, alpha: 1.00)
        

        tableView.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.98, alpha: 1.00)
//        tableView.register(Header.self, forHeaderFooterViewReuseIdentifier: "headerID")
//        tableView.sectionHeaderHeight = 50
        tableView.tableFooterView = UIView()
        
        tableView.allowsSelection = false
        
    
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weightsAdded?.count ?? 3
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
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! MyCell
        let stringT = getCurrentDate(date: (weightsAdded?[indexPath.row].dateOfEntry)!)
        myCell.nameLabel.text = stringT
        myCell.myTableViewController = self
        myCell.layer.cornerRadius = 14
        myCell.layer.masksToBounds = true
            myCell.weightLabel.text = String(weightsAdded?[indexPath.row].weight ?? 0.0)
        if(indexPath.row == 0){
            myCell.changeLabel.text = "Starting Weight"
        }
        return myCell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerID")
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
//    func deleteCell(cell: UITableViewCell){
//        if let deletionIndexPath  = tableView.indexPath(for: cell){
//            weights.remove(at: deletionIndexPath.row)
//            tableView.deleteRows(at:[deletionIndexPath] , with: .automatic)
//
//        }
//    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
 
    
    
    
}


class MyCell: UITableViewCell {
    
    var myTableViewController: HistoryViewController?
    
    override var frame: CGRect {
            get {
                return super.frame
            }
            set (newFrame) {
                var frame = newFrame
                
                let newWidth = frame.width * 0.98 // get 80% width here
                let space = (frame.width - newWidth) / 2
                frame.size.width = newWidth
                frame.origin.x += space

                super.frame = frame

            }
        }

    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add Weight", for: .normal)
        button.backgroundColor = .purple
        return button
    }()
    
    let nameLabel: UILabel = {
       let label = UILabel()
        label.text = "ASDA"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0.30, green: 0.30, blue: 0.37, alpha: 1.00)
        return label
    }()
    
    let weightMeasurementLabel: UILabel = {
       let label = UILabel()
        label.text = "kg"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemPink
        return label
    }()
    let weightLabel: UILabel = {
       let label = UILabel()
      
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemPink
        return label
    }()
    
    
    
    
    let changeLabel: UILabel = {
       let label = UILabel()
        label.text = "Change in Weight"
        label.textColor = .orange
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.isUserInteractionEnabled = true

        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    func setupViews(){
       
        //border added to give illusion of spacing between cells
        self.layer.borderColor  = UIColor(red: 0.96, green: 0.96, blue: 0.98, alpha: 1.00).cgColor
        self.layer.borderWidth = 5
        

        //label's background colour
        self.backgroundColor = .white
        addSubview(nameLabel)
        addSubview(changeLabel)
        addSubview(weightMeasurementLabel)
        addSubview(weightLabel)
//        actionButton.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        
        //UIColor(red: 0.17, green: 0.17, blue: 0.29, alpha: 1.00)
        

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 40).isActive = true
//        nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 20).isActive = true
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        
        
        changeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2.5).isActive = true
        changeLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        
        weightMeasurementLabel.translatesAutoresizingMaskIntoConstraints = false
        weightMeasurementLabel.leadingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: 350).isActive = true
        weightMeasurementLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 40).isActive = true
        
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        weightLabel.trailingAnchor.constraint(equalTo: weightMeasurementLabel.leadingAnchor, constant: -3).isActive = true
        weightLabel.bottomAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 60).isActive = true
        weightLabel.font = weightLabel.font.withSize(45)

    
    }
    
   
    
    @objc func handleButton(){
        print("")
    }
}
