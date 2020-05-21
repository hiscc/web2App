//
//  ViewController.swift
//  iOS
//
//  Created by cc his on 2020/5/3.
//  Copyright © 2020 demo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var accountField: UITextField!
  @IBOutlet weak var smsBtn: UIButton!
  @IBOutlet weak var smsField: UITextField!
  
  @IBOutlet weak var accountSubmit: UIButton!

  @IBOutlet weak var StView: UIStackView!
  @IBOutlet weak var loginView: UIView!
  
  
  @IBAction func login(_ sender: UIButton) {
    
//    let val:String = loginAccount.text ?? "dsd"
//    print(val)
    let alertController = UIAlertController(title: "hello", message: "with me", preferredStyle: UIAlertController.Style.alert)
    
    alertController.addAction(UIAlertAction(title: "ok?", style: UIAlertAction.Style.cancel, handler: nil))
    present(alertController, animated: true, completion: nil)
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    self.loginView.clipRectCorner(direction: [.topLeft,.topRight,.bottomLeft, .bottomRight], cornerRadius: 8.0)

//    self.loginView.layer.borderColor = UIColor.
//    self.loginView.layer.borderWidth = 1
    self.loginView.layer.masksToBounds = true
    self.loginView.layer.cornerRadius = 4
    
    self.accountSubmit.layer.cornerRadius = 4
    self.smsBtn.layer.cornerRadius = 4
    
//
//    let icon = UIImage(named: "banner")
//    let imgview = UIImageView(frame: CGRect(x: 40, y: 40, width: 200, height: 200))
//    imgview.image = icon
//
//    self.view.addSubview(imgview)
    
  }


}



