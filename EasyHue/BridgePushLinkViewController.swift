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
    fileprivate var disposeBag = DisposeBag()
    
    @IBOutlet weak var progressView: UIProgressView!
    
    // MARK: - Live Cycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupBindings()
    }

    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        self.viewModel?.startPushLinking()
    }
    
    // MARK: - Bindings
    
    fileprivate func setupBindings()
    {
        self.viewModel?.pushLinkProgress
            .bindTo(self.progressView.rx.progress)
            .addDisposableTo(disposeBag)
    }
}


extension BridgePushLinkViewController
{
    class func instantiateFromStoryboard(_ storyboard: UIStoryboard) -> BridgePushLinkViewController
    {
        return storyboard.viewControllerWithID(.BridgePushLinkViewController) as! BridgePushLinkViewController
    }
}

