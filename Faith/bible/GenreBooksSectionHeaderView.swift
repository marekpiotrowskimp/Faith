//
//  GenreBooksSectionHeaderView.swift
//  Faith
//
//  Created by Marek Piotrowski on 11/04/2021.
//

import Foundation
import UIKit
import SnapKit

class GenreBooksSectionHeaderView: UITableViewHeaderFooterView {
    private let margin = 8
    static let headerIndentfier = "HeaderGenreBooks"
    private let titleLabel = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        creatUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func creatUI() {
        titleLabel.font = FaithFonts.Big
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(margin)
            make.bottom.equalToSuperview().offset(-margin)
        }
    }
    
    func setupHeader(_ data: GenreBooks) {
        titleLabel.text = data.genre.name
    }
    
}
