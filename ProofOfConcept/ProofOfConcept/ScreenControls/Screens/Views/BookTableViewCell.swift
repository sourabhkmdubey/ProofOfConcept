//
//  FactTableViewCell.swift
//  ProofOfConcept
//
//  Created by Sourabh Dubey on 18/11/21.
//

import UIKit

class FactTableViewCell: UITableViewCell, FactTableViewCellProtocol {

    //MARK:- Global Varibales
    var titleLabel:UILabel = UILabel()
    var descriptionLabel:UILabel = UILabel()
    var imgeView:UIImageView = UIImageView()
    
    //MARK:- Life Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: Initalizers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let marginGuide = contentView.layoutMarginsGuide
        
        contentView.addSubview(imgeView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        
        self.setUpImageViewContraint(marginGuide)
        self.setUpTitleContraint(marginGuide)
        self.setUpDescriptionContraint(marginGuide)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

private extension FactTableViewCell {
    
    private func setUpTitleContraint(_ marginGuide: UILayoutGuide) {
        // configure titleLabel
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: imgeView.bottomAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
    }
    
    private func setUpDescriptionContraint(_ marginGuide: UILayoutGuide) {
        // configure descriptionLabel
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont(name: "Avenir-Fact", size: 12)
        descriptionLabel.textColor = UIColor.lightGray
    }
    
    private func setUpImageViewContraint(_ marginGuide: UILayoutGuide) {
        // configure imgeView
        imgeView.translatesAutoresizingMaskIntoConstraints = false
        imgeView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        imgeView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor).isActive = true
        imgeView.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        imgeView.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        imgeView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        imgeView.contentMode = .scaleAspectFit
    }
}
