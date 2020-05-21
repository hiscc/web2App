//
//  Color+Ext.swift
//  iOS
//
//  Created by cc his on 2020/5/6.
//  Copyright © 2020 demo. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
  convenience init(_ red: Int, _ green: Int, _ blue: Int, _ alpha: CGFloat = 1.0){
    let redVal = CGFloat(red) / 255
    let greenVal = CGFloat(green) / 255
    let blueVal = CGFloat(blue) / 255
    self.init(red: redVal, green: greenVal, blue: blueVal, alpha: alpha)
  }
}
