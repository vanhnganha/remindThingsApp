//
//  HomeViewController.swift
//  RemindThings
//
//  Created by NganHa on 4/19/20.
//  Copyright © 2020 Galaxy. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var btnTodoList: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
       tabBarController?.tabBar.layer.zPosition = 0

        // Do any additional setup after loading the view.
    }
   
    
    @IBAction func todoListPressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.Segue.homeToList, sender: self)
    }
    
    
    
    

  
}
