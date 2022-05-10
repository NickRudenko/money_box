//
//  AccountViewController.swift
//  Moneybox
//
//  Created by Mykola Rudenko on 09.05.2022.
//

import Foundation
import Bond
import UIKit

class AccountViewController: UIViewController {
    let viewModel: AccountViewModel
    
    private lazy var moneyboxesTableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MoneyboxTableViewCell", bundle: nil), forCellReuseIdentifier: "moneyboxTableViewCell")
        tableView.register(UINib(nibName: "CustomerInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "customerInfoView")
        return tableView
    }()
    
    init(viewModel: AccountViewModel = AccountViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        loadViewIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.navigationItem.setHidesBackButton(true, animated: false)
        setupConstraints()
        setupBindings()
        viewModel.fetchMoneyboxes()
    }
    
    private func setupConstraints() {
       view.addSubview(moneyboxesTableView)
        NSLayoutConstraint.activate([
            moneyboxesTableView.topAnchor.constraint(equalTo: view.topAnchor),
            moneyboxesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            moneyboxesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moneyboxesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupBindings() {
        viewModel.moneyboxes.bind(to: self) {this, _ in
            this.moneyboxesTableView.reloadData()
        }
    }
}

extension AccountViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customerInfoView") as! CustomerInfoTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.moneyboxes.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moneyboxTableViewCell", for: indexPath) as! MoneyboxTableViewCell
        let item = viewModel.moneyboxes.value[indexPath.row]
        cell.viewModel.model = item
        return cell
    }
}

extension AccountViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = moneyboxesTableView.cellForRow(at: indexPath) as? MoneyboxTableViewCell
        guard let item = cell?.viewModel.model else { return }
    }
}
