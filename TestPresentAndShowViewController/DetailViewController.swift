//
//  DetailViewController.swift
//  TestPresentAndShowViewController
//
//  Created by Steven on 3/23/16.
//  Copyright © 2016 Steven. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var expanationLabel: UILabel!
    
    var explanation = ""
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        expanationLabel.text = explanation
    }
    
    @IBAction func doneButtonDidTouched(sender: AnyObject) {
        if navigationController != nil {
            navigationController!.popViewControllerAnimated(true)
        } else {
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
