//
//  BridgeSelectionViewController.swift
//  EasyHue
//
//  Created by Jochen Pfeiffer on 19.03.16.
//  Copyright © 2016 Jochen Pfeiffer. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SVProgressHUD

class BridgeSelectionViewController: UIViewController {
    
    internal var viewModel: BridgeSelectionViewModel?
    private var disposeBag = DisposeBag()
    
    // MARK: Outlets

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Live Cycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupBindings()
    }
    
    // MARK: - Bindings
    
    private func setupBindings()
    {
        viewModel?.availableBridges
            .drive(tableView.rx_itemsWithCellIdentifier(TableViewCellreuseIdentifier.BridgeCell.rawValue, cellType: UITableViewCell.self)) { (_, bridgeInfo, cell) in
                cell.textLabel?.text = bridgeInfo.id
                cell.detailTextLabel?.text = bridgeInfo.ip
            }
            .addDisposableTo(disposeBag)
        
        tableView
            .rx_modelSelected(BridgeInfo)
            .subscribeNext { bridgeInfo in
                print("\(bridgeInfo)")
            }
            .addDisposableTo(disposeBag)

        viewModel?.loading
            .driveNext { loading in
                if loading {
                    SVProgressHUD.showWithStatus("Searching for Bridges...")
                }
                else {
                    SVProgressHUD.dismiss()
                }
            }
            .addDisposableTo(disposeBag)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue == .ShowBridgePushLink {
            let cell = sender as! UITableViewCell!
            let bridgePushLinkViewController = segue.destinationViewController as! BridgePushLinkViewController
//            bridgePushLinkViewController.viewModel = self.viewModel.bridgePushLinkViewModel()
        }
    }
}


extension BridgeSelectionViewController {
    class func instantiateFromStoryboard(storyboard: UIStoryboard) -> BridgeSelectionViewController {
        return storyboard.viewControllerWithID(.BridgeSelectionViewController) as! BridgeSelectionViewController
    }
}