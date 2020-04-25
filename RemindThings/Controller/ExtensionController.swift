//
//  ExtensionController.swift
//  RemindThings
//
//  Created by NganHa on 4/19/20.
//  Copyright © 2020 Galaxy. All rights reserved.
//

import UIKit
// MARK: setIcon for TextField
extension UITextField{

    func setIcon(_ image: UIImage) {
          let iconView = UIImageView(frame:
                         CGRect(x: 10, y: 5, width: 20, height: 20))
          iconView.image = image
          let iconContainerView: UIView = UIView(frame:
                         CGRect(x: 20, y: 0, width: 30, height: 30))
          iconContainerView.addSubview(iconView)
        leftView = iconContainerView
       leftViewMode = .always
       }
    
    }


