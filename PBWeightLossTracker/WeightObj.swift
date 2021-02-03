//
//  WeightObj.swift
//  PBWeightLossTracker
//
//  Created by Praveen Bandarage on 2/02/21.
//

import Foundation
import RealmSwift


//Class which stores the weight and the date of an entry which is stored to Realm. This object is utilised by Realm and displayed in both the WeighLog and Graph tracking a user's weight
class WeightObject: Object{
    @objc dynamic var weight = 0.0
    @objc dynamic var Date = 1/1/1
//    @objc dynamic var Date : Date:

    
}
