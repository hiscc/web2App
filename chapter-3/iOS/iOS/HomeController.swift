//
//  HomeController.swift
//  iOS
//
//  Created by cc his on 2020/5/4.
//  Copyright © 2020 demo. All rights reserved.
//

import UIKit


class HomeController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats And Deli", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
  
 
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return restaurantNames.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cellId = "cellItem"
    
//    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
//    cell.textLabel?.text = restaurantNames[indexPath.row]
//    cell.imageView?.image = UIImage(named: "banner")
    
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! cellItem
    
    cell.title?.text = restaurantNames[indexPath.row]
    cell.subtitle?.text = restaurantNames[indexPath.row]
    cell.title?.textColor = UIColor(0,0,125)
    
    cell.img?.image = UIImage(named: "banner")
   
    
    return cell
  }
  
 
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let menus = UIAlertController(title: "choose one?", message: "you can choose one", preferredStyle: .alert)
    
    let cancelOpt = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    menus.addAction(cancelOpt)
    
    
    let checkInAction = UIAlertAction(title: "check in", style: .default, handler: {
      (action: UIAlertAction!) -> Void in
      let cell = tableView.cellForRow(at: indexPath)
      
      if cell?.accessoryType == .checkmark {
        cell?.accessoryType = .none
      } else {
        cell?.accessoryType = .checkmark
      }

    })
    menus.addAction(checkInAction)
    present(menus, animated: true, completion: nil)
    
    tableView.deselectRow(at: indexPath, animated: false)
  }
  
//  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//    print(indexPath.row)
//    let likeAction = UIContextualAction(style: .destructive, title:  "delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
//        print(indexPath.row)
//        self.restaurantNames.remove(at: indexPath.row)
////        success(false)
//
//    })
//    likeAction.backgroundColor = UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0)
//
//    return UISwipeActionsConfiguration(actions: [likeAction])
//
//  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  
  override func viewDidLoad(){
     super.viewDidLoad()
    navigationController?.navigationBar.prefersLargeTitles = true
//     print("dddddd")
     
   }
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "cellItem" {
      print("cellItem")
//      if let indexPath = tableView.indexPathForSelectedRow {
//        let destinationController = segue.destination as! DetailController
//        destinationController.label?.text = indexPath.row
//      }
    }
  }
}
