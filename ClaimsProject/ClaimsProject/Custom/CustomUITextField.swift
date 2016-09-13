//
//  CustomUITextField.swift
//  ClaimsProject
//
//  Created by Lijauco, Carlo Cedric on 07/09/2016.
//  Copyright © 2016 arvato. All rights reserved.
//

import UIKit

class CustomUITextField: UITextField {

    @IBInspectable var paddingLeft: CGFloat = 20
    @IBInspectable var paddingRight: CGFloat = 0

    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectMake(bounds.origin.x + paddingLeft, bounds.origin.y,
            bounds.size.width - paddingLeft - paddingRight, bounds.size.height);
    }

    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return textRectForBounds(bounds)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //self.addShadow()

    }

    private func addShadow(){
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 2
        self.layer.shadowOffset = CGSizeMake(3.0, 3.0)
    }
}
