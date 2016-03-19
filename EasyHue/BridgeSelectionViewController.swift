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
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel?.searchForBridgeLocal()
    }
    
    // MARK: - Bindings
    
    private func setupBindings()
    {
        viewModel?.availableBridges
            .drive(tableView.rx_itemsWithCellIdentifier("BridgeCell", cellType: UITableViewCell.self)) { (_, element, cell) in
                cell.textLabel?.text = element.0.description
                cell.detailTextLabel?.text = element.1.description
            }
            .addDisposableTo(disposeBag)
        

    }
    
}