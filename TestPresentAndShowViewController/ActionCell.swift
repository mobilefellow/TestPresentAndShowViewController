//
//  StyleCell.swift
//  TestPresentAndShowViewController
//
//  Created by Steven on 3/23/16.
//  Copyright © 2016 Steven. All rights reserved.
//

import UIKit

class ActionCell: UITableViewCell {

    @IBOutlet weak var hintLabel: UILabel!
    
    var handlePresentButtonTouched: (() -> ())?
    var handleShowButtonTouched: (() -> ())?
    var handleShowDetailButtonTouched: (() -> ())?
    
    // MARK: UI Action
    
    @IBAction func presentButtonDidTouched(sender: AnyObject) {
        handlePresentButtonTouched?()
    }
    
    
    @IBAction func showButtonDidTouched(sender: AnyObject) {
        handleShowButtonTouched?()
    }
    
    
    @IBAction func showDetailButtonDidTouched(sender: AnyObject) {
        handleShowDetailButtonTouched?()
    }
}
