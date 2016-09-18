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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // This is the embed segue
        guard let navigtionController = segue.destination as? UINavigationController else { return }
        guard let bridgeSelectionViewController = navigtionController.topViewController as? BridgeSelectionViewController else { return }
        
        bridgeSelectionViewController.viewModel = self.viewModel?.bridgeSelectionViewModel()
    }
}

extension AppViewController {
    class func instantiateFromStoryboard(_ storyboard: UIStoryboard) -> AppViewController {
        return storyboard.viewControllerWithID(.AppViewController) as! AppViewController
    }
}
