//
//  AppViewController.swift
//  EasyHue
//
//  Created by Jochen Pfeiffer on 24.03.16.
//  Copyright © 2016 Jochen Pfeiffer. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AppViewController: UIViewController {
   
    var viewModel: AppViewModel?
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // This is the embed segue
        guard let navigtionController = segue.destinationViewController as? UINavigationController else { return }
        guard let bridgeSelectionViewController = navigtionController.topViewController as? BridgeSelectionViewController else { return }
        
        bridgeSelectionViewController.viewModel = self.viewModel?.bridgeSelectionViewModel()
    }
}

extension AppViewController {
    class func instantiateFromStoryboard(storyboard: UIStoryboard) -> AppViewController {
        return storyboard.viewControllerWithID(.AppViewController) as! AppViewController
    }
}