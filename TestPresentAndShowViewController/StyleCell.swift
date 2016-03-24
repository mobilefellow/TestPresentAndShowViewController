//
//  StyleCell.swift
//  TestPresentAndShowViewController
//
//  Created by Steven on 3/23/16.
//  Copyright © 2016 Steven. All rights reserved.
//

import UIKit

class StyleCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!

    var pickerOptions = [""] {
        didSet {
            pickerView.selectRow(0, inComponent: 0, animated: false)
            pickerView.reloadAllComponents()
        }
    }
    var didSelectOption: ((String) -> ())?

    // MARK: UIPickerView

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerOptions.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerOptions[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        didSelectOption?(pickerOptions[row])
    }
}
