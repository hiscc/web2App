//
//  cellItem.swift
//  iOS
//
//  Created by cc his on 2020/5/5.
//  Copyright © 2020 demo. All rights reserved.
//

import Foundation
import UIKit

class cellItem : UITableViewCell {
  
  @IBOutlet weak var img: UIImageView! {
    didSet {
      img.layer.cornerRadius = img.bounds.width / 2
    }
  }
  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var subtitle: UILabel!
  
}
