//
//  HomeViewController.swift
//  TestPresentAndShowViewController
//
//  Created by Steven on 3/23/16.
//  Copyright © 2016 Steven. All rights reserved.
//

import UIKit

let kStyleCellPresentation = "kPresentationStyleCell"
let kStyleCellTransition = "kTransitionStyleCell"
let kActionCell = "kActionCell"

let kPresentationFullScreen = "FullScreen"
let kPresentationPageSheet = "PageSheet"
let kPresentationFormSheet = "FormSheet"
let kPresentationCurrentContext = "CurrentContext"
let kPresentationOverFullScreen = "OverFullScreen"
let kPresentationOverCurrentContext = "OverCurrentContext"
let kPresentationPopover = "Popover"

let kTransitionCoverVertical = "CoverVertical"
let kTransitionFlipHorizontal = "FlipHorizontal"
let kTransitionCrossDissolve = "CrossDissolve"
let kTransitionPartialCurl = "PartialCurl"

let kHintTestIniPadLandscape = "Hint: Test in iPad + Landscape orientation"
let kHintTestIniPad = "Hint: Test in iPad"

let kExplanationPresentationFullScreen = "Detail view controller covers the screen, and the views of Home view controller are removed after the presentation completes. Since view.backgroundColor of Detail view controller is clear, so part of view is black"
let kExplanationPresentationOverFullScreen = "Detail view controller covers the screen, and the views of Home view controller are NOT removed from the view hierarchy when the presentation finishes. So if Detail view controller does not fill the screen with opaque content, the underlying content shows through."

class HomeViewController: UITableViewController {

    let cellNames = [
        kActionCell,
        kStyleCellPresentation,
        kStyleCellTransition]
    let presentationStyles = [
        kPresentationFullScreen,
        kPresentationPageSheet,
        kPresentationFormSheet,
        kPresentationCurrentContext,
        kPresentationOverFullScreen,
        kPresentationOverCurrentContext,
        kPresentationPopover
    ]
    let transitionStyles = [
        kTransitionCoverVertical,
        kTransitionFlipHorizontal,
        kTransitionCrossDissolve,
        kTransitionPartialCurl
    ]
    
    var selectedPresentationStyle: UIModalPresentationStyle = .FullScreen
    var selectedTransitionStyle: UIModalTransitionStyle = .CoverVertical
    var explanation = ""
    weak var hintLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
    }
    
    func initDetailViewController() -> UIViewController {
        let controller = storyboard!.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        controller.modalPresentationStyle = selectedPresentationStyle
        controller.modalTransitionStyle = selectedTransitionStyle
        controller.explanation = explanation
        
        if selectedPresentationStyle == .Popover {
            controller.preferredContentSize = CGSizeMake(CGRectGetWidth(view.frame)/3, CGRectGetHeight(view.frame)/3)
            controller.popoverPresentationController?.sourceRect = CGRectMake(100, 10, 64, 64)
            controller.popoverPresentationController?.sourceView = view
        }
        
        switch selectedPresentationStyle {
        case .Popover:
            controller.preferredContentSize = CGSizeMake(CGRectGetWidth(view.frame)/3, CGRectGetHeight(view.frame)/3)
            controller.popoverPresentationController?.sourceRect = CGRectMake(100, 10, 64, 64)
            controller.popoverPresentationController?.sourceView = view
        
        default:
            break
        }
        
        return controller
    }
    
    // MARK: UITableView

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellNames.count
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellName = cellNames[indexPath.row]
        
        if cellName == kActionCell {
            return actionCell()
        }
        
        return styleCellWithIndexPath(indexPath, styleType: cellName)
    }
    
    func styleCellWithIndexPath(indexPath: NSIndexPath, styleType: String) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("StyleCell") as! StyleCell
        weak var weakSelf = self
        
        if styleType == kStyleCellPresentation {
            cell.titleLabel.text = "Presentation Style"
            cell.pickerOptions = presentationStyles
            cell.didSelectOption = { (selectedOption) in
                var hint = ""
                weakSelf?.explanation = ""
                
                switch selectedOption {
                case kPresentationFullScreen:
                    weakSelf?.selectedPresentationStyle = .FullScreen
                    weakSelf?.explanation = kExplanationPresentationFullScreen
                case kPresentationPageSheet:
                    weakSelf?.selectedPresentationStyle = .PageSheet
                    hint = kHintTestIniPadLandscape
                case kPresentationFormSheet:
                    weakSelf?.selectedPresentationStyle = .FormSheet
                    hint = kHintTestIniPadLandscape
                case kPresentationCurrentContext:
                    weakSelf?.selectedPresentationStyle = .CurrentContext
                    weakSelf?.definesPresentationContext = true
                case kPresentationOverFullScreen:
                    weakSelf?.selectedPresentationStyle = .OverFullScreen
                    weakSelf?.explanation = kExplanationPresentationOverFullScreen
                case kPresentationOverCurrentContext:
                    weakSelf?.selectedPresentationStyle = .OverCurrentContext
                    weakSelf?.definesPresentationContext = true
                case kPresentationPopover:
                    weakSelf?.selectedPresentationStyle = .Popover
                    hint = kHintTestIniPad
                    
                default:
                    weakSelf?.selectedPresentationStyle = .FullScreen
                }
                
                weakSelf?.hintLabel?.text = hint
            }

        } else if styleType == kStyleCellTransition {
            cell.titleLabel.text = "Transition Style"
            cell.pickerOptions = transitionStyles
            cell.didSelectOption = { (selectedOption) in
                switch selectedOption {
                case kTransitionCoverVertical:
                    weakSelf?.selectedTransitionStyle = .CoverVertical
                case kTransitionFlipHorizontal:
                    weakSelf?.selectedTransitionStyle = .FlipHorizontal
                case kTransitionCrossDissolve:
                    weakSelf?.selectedTransitionStyle = .CrossDissolve
                case kTransitionPartialCurl:
                    weakSelf?.selectedTransitionStyle = .PartialCurl
                    
                default:
                    weakSelf?.selectedTransitionStyle = .CoverVertical
                }
            }
        }

        return cell
    }
    
    func actionCell() -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ActionCell") as! ActionCell
        hintLabel = cell.hintLabel
        
        weak var weakSelf = self
        
        cell.handlePresentButtonTouched = {
            weakSelf?.presentViewController((weakSelf?.initDetailViewController())!, animated: true, completion: nil)
        }
        cell.handleShowButtonTouched = {
            weakSelf?.showViewController((weakSelf?.initDetailViewController())!, sender: weakSelf)
        }
        cell.handleShowDetailButtonTouched = {
            weakSelf?.showDetailViewController((weakSelf?.initDetailViewController())!, sender: weakSelf)
        }

        return cell
    }
}
