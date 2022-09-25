//
//  CurrencyViewController.swift
//  PayPayExchangeRates
//
//  Created by RickH on 2022/9/24.
//

import UIKit
import SnapKit

class CurrencyViewController: UIViewController {
    
    let viewModel = CurrencyViewModel()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .yellow
        return label
    }()
    
    private lazy var countryTextfield: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .blue
        textField.inputView = pickerView
        textField.inputAccessoryView = pickerView.toolbar
        textField.textAlignment = .center
        return textField
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .red
        table.dataSource = self
        return table
    }()
    
    private lazy var pickerView: ToolbarPickerView = {
        let picker = ToolbarPickerView()
        picker.dataSource = self
        picker.delegate = self
        picker.toolbarDelegate = self
        picker.reloadAllComponents()
        return picker
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getExchangeRate()
        setupSubviews()
    }
    
    @objc
    func countryBtnTapped() {
        pickerView.selectRow(1, inComponent: 0, animated: true)
        
    }
}

private extension CurrencyViewController {
    func setupSubviews() {
        view.addSubview(amountLabel)
        amountLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(64)
        }
        
        view.addSubview(countryTextfield)
        countryTextfield.snp.makeConstraints { make in
            make.top.equalTo(amountLabel.snp.bottom).offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.width.equalTo(180)
            make.height.equalTo(64)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(countryTextfield.snp.bottom).offset(16)
        }
    }
}

extension CurrencyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension CurrencyViewController: UIPickerViewDelegate, UIPickerViewDataSource, ToolbarPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        viewModel.pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        viewModel.pickerData[row]
    }
    
    func didTapDone() {
        let row = pickerView.selectedRow(inComponent: 0)
        let dataSelected = viewModel.pickerData[row]
        countryTextfield.text = dataSelected
        countryTextfield.resignFirstResponder()
    }
    
    func didTapCancel() {
        countryTextfield.resignFirstResponder()
    }
}
