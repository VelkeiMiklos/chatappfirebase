//
//  CustomTextField.swift
//  ChatAppFirebase
//
//  Created by Velkei Miklós on 2017. 11. 01..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

    override func awakeFromNib() {

        //placeholder-nek fehér szín beállítása
        let placeholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedStringKey.foregroundColor : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)])
        //beállítani
        self.attributedPlaceholder = placeholder
        super.awakeFromNib()
    }
    
    let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 5);
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    
}
