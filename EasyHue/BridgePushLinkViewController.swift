//
//  BridgePushLinkViewController.swift
//  EasyHue
//
//  Created by Jochen Pfeiffer on 24.02.16.
//  Copyright © 2016 Jochen Pfeiffer. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BridgePushLinkViewController: UIViewController
{
    internal var viewModel: BridgePushLinkViewModel?
    private var disposeBag = DisposeBag()
    
    @IBOutlet weak var progressView: UIProgressView!
    
    // MARK: - Live Cycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupBindings()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel?.startPushLinking()
    }
    
    // MARK: - Bindings
    
    private func setupBindings()
    {
        viewModel?.pushLinkProgress
            .subscribeNext { pushLinkProgress in
                self.progressView.progress = pushLinkProgress
            }
            .addDisposableTo(disposeBag)
    }
}


extension BridgePushLinkViewController {
    class func instantiateFromStoryboard(storyboard: UIStoryboard) -> BridgePushLinkViewController {
        return storyboard.viewControllerWithID(.BridgePushLinkViewController) as! BridgePushLinkViewController
    }
}

