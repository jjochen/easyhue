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
import SwiftyHue

//check out: https://github.com/devxoul/RxTodo/blob/master/RxTodo/Sources/ViewControllers/TaskListViewController.swift

class BridgeSelectionViewController: UIViewController {
    
    internal var viewModel: BridgeSelectionViewModel?
    fileprivate var disposeBag = DisposeBag()
    
    // MARK: Outlets / Actions

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var refreshBarButtonItem: UIBarButtonItem!
    
    // MARK: - Live Cycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupBindings()
    }
    
    // MARK: - Bindings
    
    fileprivate func setupBindings()
    {
        guard let _ = viewModel else { return }
        
        _ = refreshBarButtonItem.rx.tap.bindTo(viewModel!.refreshTaps)
        
        viewModel!.availableBridges
            .drive(tableView.rx.items(cellIdentifier: TableViewCellreuseIdentifier.BridgeCell.rawValue, cellType: UITableViewCell.self)) { (_, bridgeInfo, cell) in
//                cell.viewModel = self.viewModel
                cell.textLabel?.text = bridgeInfo.friendlyName
                cell.detailTextLabel?.text = bridgeInfo.ip
            }
            .addDisposableTo(disposeBag)
        
        tableView
            .rx.modelSelected(HueBridge.self)
            .subscribe { hueBridge in
                print("\(hueBridge)")
            }
            .addDisposableTo(disposeBag)
        
        viewModel!.loading
            .map({ loading in
                return !loading
            })
            .drive(self.refreshBarButtonItem.rx.isEnabled)
            .addDisposableTo(disposeBag)
        
        viewModel!.loading
            .drive(SVProgressHUD.rx_animating)
            .addDisposableTo(disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue == .ShowBridgePushLink {
            guard let cell = sender as? UITableViewCell! else {return}
            guard let bridgePushLinkViewController = segue.destination as? BridgePushLinkViewController else {return}
            //bridgePushLinkViewController.viewModel = self.viewModel.bridgePushLinkViewModel()
        }
    }
}


extension BridgeSelectionViewController {
    class func instantiateFromStoryboard(_ storyboard: UIStoryboard) -> BridgeSelectionViewController {
        return storyboard.viewControllerWithID(.BridgeSelectionViewController) as! BridgeSelectionViewController
    }
}
