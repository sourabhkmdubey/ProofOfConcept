//
//  FactViewControllerProtocol.swift
//  ProofOfConcept
//
//  Created by Sourabh Dubey on 19/11/21.
//

import UIKit
import Foundation

protocol FactViewControllerProtocol {
    var cellReuseIdentifier: String {get}
    var tableview: UITableView {get set}
    var viewModel:FactsViewModelProtocol? {get set}
    var titleName: String {get set}
    func refreshFactApi()
}
