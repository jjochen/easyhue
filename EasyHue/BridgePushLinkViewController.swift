//
//  BridgePushLinkViewController.swift
//  EasyHue
//
//  Created by Jochen Pfeiffer on 24.02.16.
//  Copyright © 2016 Jochen Pfeiffer. All rights reserved.
//

import UIKit
import ReactiveCocoa

class BridgePushLinkViewController: UIViewController
{
    internal var viewModel: BridgePushLinkViewModel?
    
    @IBOutlet weak var progressView: UIProgressView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupBindings()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel?.startPushLinking()
    }
    
    // MARK: - RAC Bindings
    
    func setupBindings()
    {
         viewModel?.pushLinkProgress.producer.observeOn(UIScheduler()).startWithNext {
                self.progressView.progress = $0
        }
    }

  
}

