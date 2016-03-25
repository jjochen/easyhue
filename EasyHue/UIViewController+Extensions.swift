//
//  UIViewController+Extensions.swift
//  EasyHue
//
//  Created by Jochen Pfeiffer on 25.03.16.
//  Copyright © 2016 Jochen Pfeiffer. All rights reserved.
//

extension UIViewController {
    
    func loadViewProgrammatically() {
        self.beginAppearanceTransition(true, animated: false)
        self.endAppearanceTransition()
    }
    
    func performSegue(identifier:SegueIdentifier) {
        performSegueWithIdentifier(identifier.rawValue, sender: self)
    }
    
    func findChildViewControllerOfType(klass: AnyClass) -> UIViewController? {
        for child in childViewControllers {
            if child.isKindOfClass(klass) {
                return child
            }
        }
        return nil
    }
}
