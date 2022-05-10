//
//  CustomerInfoTableViewCell.swift
//  Moneybox
//
//  Created by Mykola Rudenko on 10.05.2022.
//

import UIKit

class CustomerInfoTableViewCell: UITableViewCell {
    let viewModel = CustomerInfoViewModel()

    @IBOutlet weak var greatingLabel: UILabel!
    @IBOutlet weak var totalPlanValueLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    private func commonInit() {
        setupBindings()
        viewModel.setupProperties()
    }
    
    private func setupBindings() {
        viewModel.greatingText.bind(to: greatingLabel.reactive.text)
        viewModel.totalPlanText.bind(to: totalPlanValueLabel.reactive.text)
    }
    
}
