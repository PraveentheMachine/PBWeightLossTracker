//
//  Button.swift
//  PBWeightLossTracker
//
//  Created by Praveen Bandarage on 2/02/21.
//

import UIKit

class Button: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        backgroundColor = .red
        layer.cornerRadius = 12
        layer.masksToBounds = true //allow us to clip the bounds to our radius to
        self.translatesAutoresizingMaskIntoConstraints = false //add our own autolayout constraints to the button
//        self.setTitle("Add a Weight", for: .normal)
//        setTitleColor(.blue, for: .normal)
//        self.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
    }
}
