//
//  IncomeCell.swift
//  FinanceApp
//
//  Created by Андрей Таланчук on 22.02.2021.
//

import UIKit
import SnapKit

class IncomeCell: UITableViewCell {
    
    let dateLabel = UILabel()
    let moneyLabel = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: Keyes.shared.incomeCell)
        createLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func createLabels(){
        
        moneyLabel.numberOfLines = 0
        moneyLabel.attributedText = NSAttributedString(string: moneyLabel.text ?? "", attributes: TextAttributes.shared.cellLabelsAttributes)
        dateLabel.attributedText = NSAttributedString(string: dateLabel.text ?? "Error atributedText", attributes: TextAttributes.shared.cellLabelsAttributes)
        
        self.addSubview(dateLabel)
        self.addSubview(moneyLabel)
        
        dateLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        moneyLabel.snp.makeConstraints{ make in
            make.left.equalToSuperview().offset(200)
            make.centerY.equalToSuperview()
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        dateLabel.text = nil
        moneyLabel.text = nil
    }
}
