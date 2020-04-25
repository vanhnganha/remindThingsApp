//
//  CategoryCell.swift
//  RemindThings
//
//  Created by NganHa on 4/25/20.
//  Copyright © 2020 Galaxy. All rights reserved.
//

import UIKit
import CircularProgressBar
class CategoryCell: UITableViewCell {

    @IBOutlet weak var progressBarView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//    func createProgressBar(){
//    var progress : Float = 0
//
//        SwiftProgressBar.addCircularProgressBar(view: self.progressBarView, type: 1)
//
//    SwiftProgressBar.setProgressColor(color: UIColor.red)
//
//    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
//
//        if progress <= 100{
//
//            progress = progress + 10
//
//            SwiftProgressBar.setProgress(progress: progress)
//
//        }else{
//
//            SwiftProgressBar.hideProgressBar()
//
//        }
//
//    }
//    }
    func createProgressBar(set progress: Float, with colorString: String){
           
               SwiftProgressBar.addCircularProgressBar(view: self.progressBarView, type: 1)

        SwiftProgressBar.setProgressColor(color: UIColor.init(hexString: colorString) ?? UIColor.orange)
       SwiftProgressBar.setProgress(progress: progress)
    }
    
    
}
