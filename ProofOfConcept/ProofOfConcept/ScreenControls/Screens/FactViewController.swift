//
//  FactViewController.swift
//  ProofOfConcept
//
//  Created by Sourabh Dubey on 19/11/21.
//

import UIKit


class FactViewController: BaseViewController<FactsViewModel>, ScreenProtocol, NavigationBarApperanceProtocol, FactViewControllerProtocol  {
    
    //MARK:- Global Variables
    private(set) var cellReuseIdentifier: String = "factTableViewCellIdentifier"
    var viewModel: FactsViewModelProtocol?
    var tableview: UITableView = UITableView()
    var titleName: String = "Facts" {
        didSet {
            self.title = titleName
        }
    }
    
    // MARK:- Life Cycle Methods
    override func loadView() {
        super.loadView()
        self.configureScreenOnLoad()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureScreenAfterLoad()
    }
    
    
}

private extension FactViewController {
    
    //MARK:- Private Methods
    /*
     MethodName :- ConfigureTableView
     Parameter :- None
     functionality :- Configure The Table View and register The Nib
     And add Anchor to cell
     */
    private func configureTableView() {
        tableview.dataSource = self
        tableview.delegate = self
        tableview.estimatedRowHeight = 100
        tableview.rowHeight = UITableView.automaticDimension
        tableview.register(FactTableViewCell.self, forCellReuseIdentifier: self.cellReuseIdentifier)
        
        view.addSubview(tableview)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func addBarButtonToNavigation() {

        let refreshButton = UIBarButtonItem(title: "refresh", style: .plain, target: self, action: #selector(refreshFactApi))
        refreshButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem  = refreshButton
    }
    
}

 extension FactViewController: UITableViewDataSource, UITableViewDelegate {
    //MARK:- Internal Methods
    
    //MARK:- Configuere Screen On Load
    func configureScreenOnLoad() {
        self.setNavgBarApperance(self)
        self.title = NSLocalizedString("Facts", comment: "")
    }
    
    //MARK:- Configuere Screen After Load
    func configureScreenAfterLoad() {
        self.configureTableView()
        self.addBarButtonToNavigation()
    }
    
    //MARK:- Selector Methods
    @objc func refreshFactApi() {
        
    }
    
    // MARK: - Table view data source
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let factCell = self.tableview.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier, for: indexPath) as? FactTableViewCell else {
            fatalError("cell Not found")
        }
        
        return factCell
    }
    
    //MARK:- Table view Delegate
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
}
