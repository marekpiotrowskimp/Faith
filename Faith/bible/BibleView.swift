//
//  BibleView.swift
//  Faith
//
//  Created by Marek Piotrowski on 05/04/2021.
//

import Foundation
import UIKit
import RxSwift
import RxDataSources
import RxCocoa

class BibleView: UIView {
    private let segmentView = UISegmentedControl(items: ["Old Testament", "New Testament"])
    let tableView = UITableView()
    let dataSource = BibleBooksDataSource { (table, data) -> UITableViewCell in
        let cell = table.dequeueReusableCell(withIdentifier: GenreBooksTableCellView.cellIndentfier) as? GenreBooksTableCellView
        cell?.setupCell(viewModel: data, expandAction: {
            table.reloadData()
        })
        return cell ?? UITableViewCell()
    } headerAction: { (table, data) -> UITableViewHeaderFooterView in
        let header = table.dequeueReusableHeaderFooterView(withIdentifier: GenreBooksSectionHeaderView.headerIndentfier) as? GenreBooksSectionHeaderView
        header?.setupHeader(data)
        return header ?? UITableViewHeaderFooterView()
    }
    
    init() {
        super.init(frame: CGRect.zero)
        createUI()
        setupBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createUI() {
        segmentView.translatesAutoresizingMaskIntoConstraints = false
        segmentView.backgroundColor = .white
        segmentView.setTitleTextAttributes([.foregroundColor: UIColor.black, NSAttributedString.Key.font: FaithFonts.Normal], for: .normal)
        segmentView.selectedSegmentIndex = 0
        addSubview(segmentView)
        segmentView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
        }
        
        tableView.register(GenreBooksTableCellView.self, forCellReuseIdentifier: GenreBooksTableCellView.cellIndentfier)
        tableView.register(GenreBooksSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: GenreBooksSectionHeaderView.headerIndentfier)
        tableView.delegate = dataSource
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(segmentView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupBindings() {
        
    }
}

class BibleBooksDataSource:  NSObject, RxTableViewDataSourceType, UITableViewDataSource, UITableViewDelegate {
    typealias Element = [GenreBooks]
    typealias CellAction = (UITableView, GenreBooksCellViewModel) -> UITableViewCell
    typealias HeaderAction = (UITableView, GenreBooks) -> UITableViewHeaderFooterView
    
    private var data = Element()
    private let cellSetupAction: CellAction
    private let headerSetupAction: HeaderAction
    
    init(cellAction: @escaping CellAction, headerAction: @escaping HeaderAction) {
        cellSetupAction = cellAction
        headerSetupAction = headerAction
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerSetupAction(tableView, data[section])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data[section].bookKeys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cellSetupAction(tableView, data[indexPath.section].bookKeys[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, observedEvent: Event<Element>) {
        data = observedEvent.element ?? Element()
        tableView.reloadData()
    }
}
