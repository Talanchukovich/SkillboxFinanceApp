//
//  ExpensCell.swift
//  FinanceApp
//
//  Created by Андрей Таланчук on 20.03.2021.
//

import UIKit

class ExpensCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: Keyes.shared.expensCell)
        createCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let expNameLabel = UILabel()
    let dateLabel = UILabel()
    let expLabel = UILabel()
    func createCell(){
        
        dateLabel.attributedText = NSAttributedString(string: dateLabel.text ?? "", attributes: TextAttributes.shared.cellLabelsAttributes)
        self.addSubview(dateLabel)
        dateLabel.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        expNameLabel.numberOfLines = 2
        expNameLabel.adjustsFontSizeToFitWidth = true
        expNameLabel.minimumScaleFactor = 0.8
        expNameLabel.attributedText = NSAttributedString(string: expNameLabel.text ?? "", attributes: TextAttributes.shared.cellLabelsAttributes)
        self.addSubview(expNameLabel)
        expNameLabel.snp.makeConstraints{make in
            make.left.equalToSuperview().offset(16)
            make.right.equalTo(dateLabel.snp.left).offset(-10)
            make.centerY.equalToSuperview()
        }
        
        expLabel.textAlignment = .center
        expLabel.adjustsFontSizeToFitWidth = true
        expLabel.minimumScaleFactor = 0.8
        expLabel.attributedText = NSAttributedString(string: expLabel.text ?? "", attributes: TextAttributes.shared.cellLabelsAttributes)
        self.addSubview(expLabel)
        expLabel.snp.makeConstraints{make in
            make.right.equalToSuperview().offset(-16)
            make.left.equalTo(dateLabel.snp.right).offset(60)
            make.centerY.equalToSuperview()
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        expNameLabel.text = nil
        dateLabel.text = nil
        expLabel.text = nil
    }
}
