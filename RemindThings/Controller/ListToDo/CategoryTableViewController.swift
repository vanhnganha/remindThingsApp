//
//  ListToDoTableViewController.swift
//  RemindThings
//
//  Created by NganHa on 4/21/20.
//  Copyright © 2020 Galaxy. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework


class CategoryTableViewController: UITableViewController {
    
    let db = Firestore.firestore()
    var listThing = Array<Categogy>()
    var numDoneString:String = ""
    var percentNumDone: Float = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: K.TableCell.CategoryCell)
        loadList()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
  

    // MARK: FIREBASE/FIRESTORE
    func loadList(){
        let getList = db.collection("user").document(User.id).collection("category")
        getList.order(by: "date", descending: true).getDocuments { (querySnapshot, error) in
            if let err = error {
                        print("ERROR IN GETTING DOCUMENTS: \(err)")
                    } else {
                        print("CONGRATULATION TO LOAD LIST")
                        for document in querySnapshot!.documents {
                            print("\(document.documentID) => \(document.data())")
                            let doc = document.data()
                            let id = document.documentID
                           if let colorThing = doc["color"],let nameThing = doc["name"],let numThing = doc["num"],let dateThing = doc["date"]  {
                            let newColor = colorThing as! String
                            let newName = nameThing as! String
                           var newNum = numThing as! Int
                            let newDate = dateThing as! Timestamp
                            
                            // check how much things done
                            let getItem = self.db.collection("user").document(User.id).collection("category").document(id).collection("item")
                                   getItem.getDocuments { (querySnapshot, error) in
                                       if let err = error {
                                           print("ERROR IN GETTING DOCUMENTS: \(err)")
                                           } else {
                                           print("CONGRATULATION TO LOAD NUM OF LIST")
                                           var doneNum: Int = 0
                                           var numItemOfCategogy: Int = 0
                                           for document in querySnapshot!.documents {
                                               numItemOfCategogy += 1
                                               let doc = document.data()
                                               if let done = doc["done"]{
                                                   if done as! Bool == true {
                                                   doneNum += 1
                                                   }
                                               }
                                           }
                                        newNum = numItemOfCategogy
                                        let newCategory = Categogy(id: id, name: newName, color: newColor, totalNum: newNum, doneNum: doneNum, date: newDate, listChild: nil)
                                        self.listThing.append(newCategory)
                                        self.tableView.reloadData()
                                                       
                                       }
                            }
                            }
               
               
            }}}
    }
    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController.init(title: "Thêm mới việc cần làm", message: "", preferredStyle: .alert)
        var text =  UITextField()
        let action = UIAlertAction.init(title: "Thêm", style: .default) { (action) in
            
            
            let color = UIColor.randomFlat().hexValue()
            var newThing = Categogy(id: "", name: text.text!, color: color, totalNum: 0, doneNum: 0, date: Timestamp(), listChild: nil)
            
            var ref: DocumentReference? = nil
            ref = self.db.collection("user").document(User.id).collection("category").addDocument(data: [
                "name": newThing.name,
                "color": newThing.color,
                "num": newThing.totalNum,
                "date": newThing.date
                   ]) { (error) in
                       if let e = error{
                           print("error with saving new thing : \(e)")
                       } else {
                        newThing.id = ref?.documentID as! String
                         self.listThing.append(newThing)
                        self.tableView.reloadData()
                    }
                   }
        }
            
            alert.addTextField { (textfield) in
                textfield.placeholder = "Nhập việc cần làm mới"
                text = textfield
        }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
    

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return self.listThing.count
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        // #warning Incomplete implementation, return the number of rows
        return self.listThing.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.TableCell.CategoryCell, for: indexPath) as! CategoryCell
//        UIColor.randomFlat()
        let thing = listThing[indexPath.row]
        let color = thing.color
        percentNumDone = Float(thing.doneNum)/Float(thing.totalNum)
        cell.createProgressBar(with: percentNumDone, color: UIColor(hexString: color)!)
       
        cell.name.text = thing.name
        cell.status.text = "\(thing.doneNum)/\(thing.totalNum)"
        print(UIColor.randomFlat().hexValue())
        return cell
    }
    

   

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
  
    
}
