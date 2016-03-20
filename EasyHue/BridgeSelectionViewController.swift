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

class BridgeSelectionViewController: ViewController {
    
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
            .drive(tableView.rx_itemsWithCellIdentifier("BridgeCell", cellType: UITableViewCell.self)) { (_, bridge, cell) in
                cell.textLabel?.text = bridge.id
                cell.detailTextLabel?.text = bridge.ip
            }
            .addDisposableTo(disposeBag)
        
        tableView
            .rx_modelSelected(BridgeInfo)
            .subscribeNext { bridge in
                print("\(bridge.id)")
            }
            .addDisposableTo(disposeBag)

//        viewModel?.loading
//            .driveNext { loading in
//                if loading {
//                    HUD.show(.Progress)
//                }
//                else if HUD.isVisible {
//                    HUD.hide()
//                }
//            }
//            .addDisposableTo(disposeBag)
    }
    
}