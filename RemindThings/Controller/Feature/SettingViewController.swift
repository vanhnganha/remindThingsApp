//
//  SettingViewController.swift
//  RemindThings
//
//  Created by NganHa on 4/22/20.
//  Copyright © 2020 Galaxy. All rights reserved.
//

import UIKit
import Firebase
class SettingViewController: UIViewController {
    
    
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var currentPassText: UITextField!
    @IBOutlet weak var newPassText: UITextField!
    @IBOutlet weak var newPass2Text: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        getUsername()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    //MARK: catch some error
    func checkinputError() -> Bool{
        if currentPassText.text!.isBlank || newPassText.text!.isBlank || newPass2Text.text!.isBlank {
            alertFail(with: "Bạn phải điền tất cả thông tin")
            return false
        }
       else if newPassText.text! != newPass2Text.text!{
            alertFail(with: "Mật khẩu mới phải giống mật khẩu nhập lại")
            return false
        }
        else {
            return true
        }
    }
    func alertFail(with note: String){
        let alert = UIAlertController(title: "Đổi mật khẩu thất bại", message: note, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            self.currentPassText.text = ""
            self.newPass2Text.text = ""
            self.newPassText.text = ""
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    func alertSuccess(){
    let alert = UIAlertController(title: "Đổi mật khẩu thành công", message: "", preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default) { (action) in
        self.currentPassText.text = ""
        self.newPass2Text.text = ""
        self.newPassText.text = ""
    }
    alert.addAction(action)
    present(alert, animated: true, completion: nil)    }
    
    //MARK: change Pass
    func changePass(){
    if let currentUser = Auth.auth().currentUser {
      // User is signed in.
        if currentPassText.text! == currentUser.value(forUndefinedKey: "password") as! String {
           if checkinputError() == true {
                currentUser.updatePassword(to: currentPassText.text!) { (error) in
                         if error != nil {
                            print("khong the update pass: \(error?.localizedDescription ?? "nothing")")
                         }
                }
                
            
            }
            alertSuccess()
         
        } else {
            alertFail(with: "Mật khẩu hiện tại không đúng")
        
        }
    }
    }
    
    func getUsername(){
       if let currentUser = Auth.auth().currentUser{
        usernameText.text = currentUser.email
        }
    }
    @IBAction func acceptPressed(_ sender: Any) {
        changePass()
    }
}
