//
//  HomeViewController.swift
//  RemindThings
//
//  Created by NganHa on 4/19/20.
//  Copyright © 2020 Galaxy. All rights reserved.
//

import UIKit
import Firebase
class HomeViewController: UIViewController {
   
    @IBOutlet weak var btnTodoList: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
      // tabBarController?.tabBar.layer.zPosition = 0

        // Do any additional setup after loading the view.
        getUserId()
       
    }
    func getUserId(){
        if let user = Auth.auth().currentUser{
            User.id = user.uid
        }
         print("THE USER ID IS \(User.id)")
    }
   
    
    @IBAction func todoListPressed(_ sender: UIButton) {
        //performSegue(withIdentifier: K.Segue.homeToList, sender: self)
    }
    
    
    
    

  
}
