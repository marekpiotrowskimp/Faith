//
//  GenreBooksTableCellView.swift
//  Faith
//
//  Created by Marek Piotrowski on 11/04/2021.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxGesture

class GenreBooksCellViewModel {
    var isExpanded = false
    var data: BookKey
    init (data: BookKey) {
        self.data = data
    }
}

class GenreBooksTableCellView: UITableViewCell {
    private struct Consts {
        static let marginLeft = 16
        static let marginRight = 8
        static let marginTopBottom = 8
    }
    private var expandAction: (() -> Void)?
    private var viewModel: GenreBooksCellViewModel?
    private var disposeBag = DisposeBag()
    static let cellIndentfier = "GenreBooks"
    private let titleCell = UILabel()
    private let imageExpand = UIImageView(image: UIImage(named: "expand_down"))
    private let chapters = BibleChapters { number in
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createUI()
        bindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createUI() {
        selectionStyle = .none
        titleCell.font = FaithFonts.Normal
        contentView.addSubview(titleCell)
        
        titleCell.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Consts.marginLeft)
            make.top.equalToSuperview().offset(Consts.marginTopBottom)
        }
        
        imageExpand.isUserInteractionEnabled = true 
        contentView.addSubview(imageExpand)
        
        imageExpand.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-Consts.marginRight)
            make.top.equalToSuperview().offset(Consts.marginTopBottom)
            make.height.equalTo(24)
            make.width.equalTo(imageExpand.snp.height)
        }
        
        contentView.addSubview(chapters)
        
        chapters.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(titleCell.snp.bottom).offset(Consts.marginTopBottom)
            make.bottom.equalToSuperview().offset(-Consts.marginTopBottom)
        }
    }
    
    private func bindings() {
        imageExpand.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
            guard let self = self,
                  let viewModel = self.viewModel else { return }
            viewModel.isExpanded = viewModel.isExpanded ? false : true
            self.showChapters()
            self.expandAction?()
        }).disposed(by: disposeBag)
    }
    
    private func showChapters() {
        guard let viewModel = self.viewModel else { return }
        if viewModel.isExpanded {
            self.chapters.createUI(chapters: viewModel.data.c)
            self.imageExpand.image = UIImage(named: "expand_up")
        } else {
            self.chapters.clearView()
            self.imageExpand.image = UIImage(named: "expand_down")
        }
    }
    
    func setupCell(viewModel: GenreBooksCellViewModel, expandAction: @escaping () -> Void) {
        self.expandAction = expandAction
        self.viewModel = viewModel
        titleCell.text = viewModel.data.n
        showChapters()
    }
}


class BibleChapters: UIView {
    private var disposeBag = DisposeBag()
    
    init(selectedChapterAction: @escaping (Int) -> Void) {
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func clearView() {
        subviews.forEach { number in
            number.removeFromSuperview()
        }
    }
    
    func createUI(chapters: Int) {
        clearView()
        for c in 1...chapters {
            addChapter(chapter: c)
        }
        
        self.subviews.last?.snp.makeConstraints({ make in
            make.bottom.equalToSuperview().offset(-8)
        })
    }
    
    private func addChapter(chapter: Int) {
        let number = UILabel()
        number.font = FaithFonts.Small
        number.textAlignment = .center
        number.text = "[\(chapter)]"
        
        addSubview(number)
        
        number.rx.tapGesture().when(.recognized).subscribe(onNext: { _ in
            self.subviews.forEach { view in
                view.backgroundColor = .white
            }
            number.backgroundColor = .lightGray
        }).disposed(by: disposeBag)
        
        let params = getChapterParams(chapter: chapter)
        number.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(params.offsetY)
            make.leading.equalToSuperview().offset(params.offsetX)
            make.width.height.equalTo(params.size)
        }
    }
    
    private func getChapterParams(chapter: Int) -> (offsetX: Int, offsetY: Int, size: Int) {
        let marginLeft = 16
        let size = Int( (Int(UIScreen.main.bounds.width) - marginLeft) / 10)
        let y = (chapter - 1) / 10
        let x = (chapter - 1) % 10
        return (x * size + marginLeft, y * size, size)
    }
}
