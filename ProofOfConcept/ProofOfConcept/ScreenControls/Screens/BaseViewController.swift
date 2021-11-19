//
//  BaseViewController.swift
//  ProofOfConcept
//
//  Created by Sourabh Dubey on 19/11/21.
//

import UIKit

class BaseViewController<DataProcessor: BaseViewModel>: UIViewController {

    //MARK:- Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated);
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }


}
