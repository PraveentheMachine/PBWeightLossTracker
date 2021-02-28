

import UIKit
class tabViewController: UITabBarController {
    
    
    override func viewDidLoad() {
        let homeScreenVC = HomeScreenVC()
        let historyV2 = HistoryViewController()
        historyV2.title = "Weight Log"
        homeScreenVC.title = "Home"
        
       
        
        setViewControllers([homeScreenVC,historyV2], animated: true)
        
    }
//    
//    override func viewDidLayoutSubviews() {
//        if(Core.shared.isNewUser()){
//            //do onboaridng
//            print("Being done")
//            let vc = WelcomeViewController();
//            vc.modalPresentationStyle = .fullScreen
//            vc.view.backgroundColor = .white
//            present(vc, animated: true)
//        }
//    }
}



class Core{
    static let shared = Core()
    
    func isNewUser() -> Bool{
        
        return !UserDefaults.standard.bool(forKey: "isNewUser")
    }
    
    func setIsNotNewUser(){
        UserDefaults.standard.set(true,forKey: "isNewUser")
    }
}

//
//import UIKit
//import Charts
//
//class ViewController: UIViewController {
//
//    var weightLossChart = LineChartView()
//    let button = Button()
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//            super.viewDidAppear(animated)
//
//        let tabBarVC = UITabBarController()
//        let trackerVC = TrackerViewController()
//        let currentView = trackerVC.view
//        currentView?.addSubview(button)
//
//        //Adding constraints programatically
//        NSLayoutConstraint.activate([button.centerXAnchor.constraint(equalTo: currentView!.centerXAnchor),
//                                     button.centerYAnchor.constraint(equalTo: currentView!.centerYAnchor),
//                                     button.widthAnchor.constraint(equalToConstant: 200),
//                                     button.heightAnchor.constraint(equalToConstant: 200)
//
//
//
//
//        ])
//        let trackerVC2 = TrackerViewController2()
//
//        //We need to set the titles here because the titles only load when the ViewController is loaded
//        trackerVC.title = "AAA"
//        trackerVC2.title = "WeightLog"
//
//        tabBarVC.setViewControllers([trackerVC,trackerVC2], animated: true)
//        tabBarVC.modalPresentationStyle = .fullScreen
//        present(tabBarVC, animated: true)
//        // Do any additional setup after loading the view.
//    }
//
//    @objc func handleButton(){
//        print("ADSKDLKAJDLK")
//    }
//
//
//}
//
//
//
//
//
//class TrackerViewController: UIViewController {
//     override func viewDidLoad() {
//        view.backgroundColor = UIColor(red: 0.09, green: 0.09, blue: 0.18, alpha: 1.00)
//
//    }
//
//}
//
//class TrackerViewController2: UIViewController {
//     override func viewDidLoad() {
//        view.backgroundColor = UIColor(red: 0.119, green: 0.19, blue: 0.18, alpha: 1.00)
//
//
//    }
//
//}
//
