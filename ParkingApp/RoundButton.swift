//
//  RoundButton.swift
//  ParkingApp
//
//  Created by jakub skrzypczynski on 14/03/2017.
//  Copyright © 2017 test project. All rights reserved.
//

import UIKit
import MapKit

class RoundButton: UIButton {
    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.shadowRadius = 20
        self.layer.shadowOpacity = 0.5
        self.layer.shadowColor = UIColor.black.cgColor
    }
}
