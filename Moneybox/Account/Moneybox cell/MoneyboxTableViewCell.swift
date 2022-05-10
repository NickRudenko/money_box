//
//  MoneyboxTableViewCell.swift
//  Moneybox
//
//  Created by Mykola Rudenko on 09.05.2022.
//

import UIKit

class MoneyboxTableViewCell: UITableViewCell {
    let viewModel = MoneyboxCellViewModel()

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var planLabel: UILabel!
    @IBOutlet weak var moneyboxLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupBindings()
    }
    
    private func setupBindings() {
        viewModel.generalTitleText.bind(to: titleLabel.reactive.text)
        viewModel.planValueText.bind(to: planLabel.reactive.text)
        viewModel.moneyboxText.bind(to: moneyboxLabel.reactive.text)
    }
    
}
