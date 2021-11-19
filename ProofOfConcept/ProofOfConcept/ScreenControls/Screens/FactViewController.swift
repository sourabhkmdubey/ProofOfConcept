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
    
    private func setUpViewModel() {
        if self.viewModel == nil {
            self.viewModel = FactsViewModel.init()
        }
    }
    
    private func reloadTheTableView() {
        if let viewModel = self.viewModel {
            viewModel.reloadListClosure = { [weak self] () in
                guard let weakSelf = self else {return}
                DispatchQueue.main.async {
                    weakSelf.titleName =  viewModel.getHeaderTitle()
                    weakSelf.tableview.reloadData()
                }
            }
        }
    }
    
    private func addBarButtonToNavigation() {

        let refreshButton = UIBarButtonItem(title: "refresh", style: .plain, target: self, action: #selector(refreshFactApi))
        refreshButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem  = refreshButton
    }
    
    
}

 extension FactViewController: UITableViewDataSource, UITableViewDelegate {
    //MARK:- Internal Methods
    
    // Configuere Screen On Load
    func configureScreenOnLoad() {
        self.setNavgBarApperance(self)
        self.title = NSLocalizedString("Facts", comment: "")
    }
    
    // Configuere Screen After Load
    func configureScreenAfterLoad() {
        self.configureTableView()
        self.setUpViewModel()
        self.reloadTheTableView()
        self.addBarButtonToNavigation()
    }
    
    @objc func refreshFactApi() {
        self.viewModel?.refreshFactApi()
    }
    
    
    // MARK: - Table view data source
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the Facts Details Counts
        return self.viewModel?.numberOfFactsCount() ?? 0
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let factCell = self.tableview.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier, for: indexPath) as? FactTableViewCell else {
            fatalError("cell Not found")
        }
        // Configure the cell...
        factCell.selectionStyle = .none
        factCell.imgeView.image = UIImage.init(named: "placeholder")
        factCell.titleLabel.text = self.viewModel?.getFactsDetailsTitle(indexPath.row)
        factCell.descriptionLabel.text = self.viewModel?.getFactsDetailsDesc(indexPath.row)
        
        return factCell
    }
    
    //MARK:- Table view Delegate
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if let strFactImageUrl = self.viewModel?.getFactsImage(indexPath.row) {
            self.viewModel?.getDownloadImage(strFactImageUrl, indexPath, handler: { image, indexPath, error in
                if error == nil, let factImage = image, let newIndexPath = indexPath {
                    DispatchQueue.main.async {
                        if let factCell = self.tableview.cellForRow(at: newIndexPath) as? FactTableViewCell {
                            factCell.imgeView.image = factImage
                        }
                    }
                }
            })
            
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if let strFactImageUrl = self.viewModel?.getFactsImage(indexPath.row) {
            self.viewModel?.slowDownloadImage(strFactImageUrl)
        }
    }
    
}
