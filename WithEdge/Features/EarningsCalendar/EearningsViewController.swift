//
//  EearningsViewController.swift
//  WithEdge
//
//  Created by Max zam on 21/07/2025.
//

import UIKit
import Combine

class EarningsCalendarViewController: UIViewController {
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String>
    typealias DataSource = UITableViewDiffableDataSource<EarningsSection, StockEarnings>
    
    private let viewModel: EarningsViewModel
    private var cancellables: Set<AnyCancellable> = []
    private var dataSource: DataSource!
    
    enum EarningsSection {
        case main
    }
    
    private var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    init(viewModel: EarningsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func configureDataSource() {
        dataSource = DataSource(tableView: tableView) { tableView, indexPath, earnings in
            let cell = tableView.dequeueReusableCell(withIdentifier: "EarningCell", for: indexPath)
            cell.textLabel?.text = "\(earnings.stock.symbol) - \(earnings.date)"
            var config = cell.defaultContentConfiguration()
            config.text = earnings.stock.symbol
            config.secondaryText = earnings.date
            cell.contentConfiguration = config
            
            return cell
        }
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Earningcell")
    }
    
    private func setupUI() {
        title = "Earnings Calendar"
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func bindViewModel() {
        viewModel.$earnings
                .receive(on: RunLoop.main)
                .sink { [weak self] earnings in
                    self?.updateDataSource(with: earnings)
                }
                .store(in: &cancellables)
        }
    
    private func updateDataSource(with earnings: [StockEarnings]) {
        var snapshot = NSDiffableDataSourceSnapshot<EarningsSection, StockEarnings>()
        snapshot.appendSections([.main])
        snapshot.appendItems(earnings)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
