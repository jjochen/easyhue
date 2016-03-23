import UIKit

extension UIStoryboard {
    
    class func main() -> UIStoryboard {
        return UIStoryboard(name: StoryboardNames.Main.rawValue, bundle: nil)
    }
    
    func viewControllerWithID(identifier:ViewControllerStoryboardIdentifier) -> UIViewController {
        return self.instantiateViewControllerWithIdentifier(identifier.rawValue)
    }
}