//
//  NavigationBarApperanceProtocol.swift
//  ProofOfConcept
//
//  Created by Sourabh Dubey on 18/11/21.
//

import UIKit


protocol NavigationBarApperanceProtocol {
    func setNavgBarApperance(_ viewControllerProtocol:FactViewControllerProtocol)
    func removeNavgbarApperance(_ viewControllerProtocol:FactViewControllerProtocol)
}

extension NavigationBarApperanceProtocol {
    
    func setNavgBarApperance(_ viewControllerProtocol:FactViewControllerProtocol) {
        if let viewcontroller = viewControllerProtocol as? UIViewController {
            viewcontroller.navigationController?.setNavigationBarHidden(false, animated: true)
            viewcontroller.navigationController?.navigationBar.isTranslucent = false;
            viewcontroller.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
            viewcontroller.navigationController?.navigationBar.barTintColor = UIColor(named:"DarkBlue")
            viewcontroller.navigationController?.navigationBar.backItem?.backBarButtonItem?.tintColor = UIColor.white
            viewcontroller.navigationController?.navigationBar.barStyle = .black
        }
        
    }
    
    func removeNavgbarApperance(_ viewControllerProtocol:FactViewControllerProtocol) {
        if let viewcontroller = viewControllerProtocol as? UIViewController {
            viewcontroller.navigationController?.setNavigationBarHidden(true, animated: true)
            viewcontroller.navigationController?.navigationBar.barTintColor = UIColor.clear
        }
    }
}
