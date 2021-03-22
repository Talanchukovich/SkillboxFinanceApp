//
//  CategoryCell.swift
//  FinanceApp
//
//  Created by Андрей Таланчук on 20.03.2021.
//

import UIKit

class CategoryCell: UITableViewCell {

    let categoryExpLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: Keyes.shared.categoryCell)
        createLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createLabel(){
        categoryExpLabel.numberOfLines = 2
        categoryExpLabel.adjustsFontSizeToFitWidth = true
        categoryExpLabel.minimumScaleFactor = 0.5
        categoryExpLabel.attributedText = NSAttributedString(string: categoryExpLabel.text ?? "", attributes: TextAttributes.shared.cellLabelsAttributes)
        self.addSubview(categoryExpLabel)
        categoryExpLabel.snp.makeConstraints{make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-55)
            make.centerY.equalToSuperview()
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        categoryExpLabel.text = nil
    }
}
