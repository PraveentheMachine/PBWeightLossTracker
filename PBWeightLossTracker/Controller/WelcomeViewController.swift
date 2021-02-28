//
//  WelcomeViewController.swift
//  PBWeightLossTracker
//
//  Created by Praveen Bandarage on 22/02/21.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    let scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configure()
    }
    
    
    private func configure(){
        //set up ScrollView
//        scrollView = view.bounds;
        view.addSubview(scrollView)
        view.backgroundColor = .white
        for x in 0..<3{
            let pageView = UIView(frame: CGRect(x: CGFloat(CGFloat(x)*view.frame.size.width), y: 0, width: view.frame.size.width, height: view.frame.size.height))
            scrollView.addSubview(pageView)
            //Add this
//            let label = UILabel(frame: CGRect(x: 10, y: 10, width: pageView.frame.size.width, height: <#T##CGFloat#>))
            let button = UIButton(frame: CGRect(x: 10, y: pageView.frame.size.height-110, width: pageView.frame.width-20, height: 50))
            button.layer.cornerRadius = 24 
            
            button.setTitle("Title", for: .normal)
            button.backgroundColor = .black
            button.setTitleColor(.white, for: .normal)
            scrollView.addSubview(pageView)
            button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
            pageView.addSubview(button)
            button.tag = x + 1;
        }
    }
    
    @objc func didTapButton(_ button: UIButton){
        guard button.tag < 3 else {
            
            return
        }
        scrollView.setContentOffset(CGPoint(x: view.frame.size.width*CGFloat(button.tag), y: 0), animated: true)
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
