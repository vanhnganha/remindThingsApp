//
//  ItemTableViewController.swift
//  RemindThings
//
//  Created by NganHa on 5/3/20.
//  Copyright © 2020 Galaxy. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework
class ItemTableViewController: SwipeTableViewController {
    let db = Firestore.firestore()
    var listItem = Array<Item>()
    var category: Categogy?{
        didSet{
            loadItems()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    // MARK: FIREBASE
    func loadItems(){
        let getItems = db.collection("user").document(User.id).collection("category").document(category!.id).collection("item")
        getItems.order(by: "date", descending: true).getDocuments() { (querySnapshot, error) in
            if let e = error{
                print("Have some error in \(e)")
                }
            else {
                for document in querySnapshot!.documents {
                   let doc = document.data()
                    let id = document.documentID
                    if let nameItem = doc["name"], let doneItem = doc["done"], let dateItem = doc["date"]{
                       let newName = nameItem as! String
                        let newDone = doneItem as! Bool
                        let newDate = dateItem as! Timestamp
                        let newItem = Item(id: id, name: newName, date: newDate, done: newDone)
                       self.listItem.append(newItem)
                    }
                }
                self.tableView.reloadData()
            }
        }
        
        }
    //MARK: Table resource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if self.listItem.count >= 1 {
            return self.listItem.count
        }
        else {
            return 1
            }
        
}
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if listItem.count >= 1 {
            let item = listItem[indexPath.row]
            cell.textLabel?.text = item.name
            let color = UIColor(hexString: category!.color)?.darken(byPercentage: CGFloat(indexPath.row) / CGFloat (listItem.count))
            cell.backgroundColor = color
            cell.textLabel?.textColor = ContrastColorOf(color!, returnFlat: true)
            cell.tintColor = ContrastColorOf(color!, returnFlat: true)
                
            cell.accessoryType = item.done ? .checkmark : .none
            
        }
        else {
            cell.textLabel?.text = "Chưa có việc nào được thêm"
        }
        

        return cell
    }
    
    //MARK: table delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if listItem.count >= 1{
            var item = listItem[indexPath.row]
            let changeItem = db.collection("user").document(User.id).collection("categoy").document(category!.id).collection("item").document(item.id)
            changeItem.updateData(["done" : !item.done]) { (error) in
                if let e = error {
                    print("LOI \(e)")
                }
                else {
                    item.done = !item.done
                    tableView.reloadData()
                }
            }
        }
    }
  
    
    

   

}
