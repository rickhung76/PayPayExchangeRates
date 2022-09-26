//
//  CurrencyTableViewCell.swift
//  PayPayExchangeRates
//
//  Created by RickH on 2022/9/26.
//

import UIKit
import SnapKit

class CurrencyTableViewCell: UITableViewCell {
    
    private lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20.0, weight: .semibold)
        label.textAlignment = .left
        label.textColor = .systemGray5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20.0, weight: .medium)
        label.textAlignment = .right
        label.textColor = .systemGray6
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var seperater: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    private func setupViews() {
        contentView.addSubview(countryLabel)
        countryLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(32)
            make.height.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.2)
        }
        contentView.addSubview(amountLabel)
        amountLabel.snp.makeConstraints { make in
            make.left.equalTo(countryLabel.snp.right)
            make.height.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(32)
        }
        contentView.addSubview(seperater)
        seperater.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.left.right.equalToSuperview().inset(32)
            make.bottom.equalToSuperview()
        }
        backgroundColor = .clear
    }
    
    func setup(_ viewModel: CurrencyTableViewCellVM) {
        countryLabel.text = viewModel.country
        amountLabel.text = viewModel.amount
    }
}

extension UITableViewCell {
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
}
