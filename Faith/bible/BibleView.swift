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
    let tabelView = UITableView()
    let dataSource = BibleBooksDataSource { (table, data) -> UITableViewCell in
        let cell = table.dequeueReusableCell(withIdentifier: GenreBooksTableCellView.cellIndentfier)
        cell?.textLabel?.text = data.n
        return cell ?? UITableViewCell()
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
        addSubview(segmentView)
        segmentView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
        }
        
        tabelView.register(GenreBooksTableCellView.self, forCellReuseIdentifier: GenreBooksTableCellView.cellIndentfier)
        addSubview(tabelView)
        tabelView.snp.makeConstraints { make in
            make.top.equalTo(segmentView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupBindings() {
        
    }
}


class BibleBooksDataSource:  NSObject, RxTableViewDataSourceType, UITableViewDataSource {
    typealias Element = [GenreBooks]
    typealias CellAction = (UITableView, BookKey) -> UITableViewCell
    
    private var data = Element()
    private let cellSetupAction: CellAction
    
    init(cellAction: @escaping CellAction) {
        cellSetupAction = cellAction
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        data.count
    }
    
    private func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        UITableViewHeaderFooterView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data[section].1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cellSetupAction(tableView, data[indexPath.section].1[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, observedEvent: Event<Element>) {
        data = observedEvent.element ?? Element()
        tableView.reloadData()
    }
}
