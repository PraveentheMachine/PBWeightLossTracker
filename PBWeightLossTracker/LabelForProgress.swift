//
//  LabelForProgress.swift
//  PBWeightLossTracker
//
//  Created by Praveen Bandarage on 4/02/21.
//

import UIKit

class ProgressLabel: UILabel {
    var weight: String
     init(frame: CGRect, string: String){
        self.weight = string
        super.init(frame: frame)
        text = string
        
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
