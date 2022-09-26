//
//  CurrencyViewController.swift
//  PayPayExchangeRates
//
//  Created by RickH on 2022/9/24.
//

import UIKit
import SnapKit
import Combine

class CurrencyViewController: UIViewController {
    
    let viewModel = CurrencyViewModel()
    
    private var canncellable = Set<AnyCancellable>()
    
    private lazy var amountTextfield: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.textAlignment = .right
        textField.keyboardType = .decimalPad
        
        let toolbar: UIToolbar = UIToolbar(
            frame: .init(
                x: 0,
                y: 0,
                width: UIScreen.main.bounds.width,
                height: 50)
        )
        toolbar.barStyle = .default
        
        let space = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        let done = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(amountTextfieldFinishEditing)
        )
        
        let items = [space, done]
        toolbar.items = items
        toolbar.sizeToFit()
        textField.inputAccessoryView = toolbar
        textField.font = .systemFont(ofSize: 35.0, weight: .bold)
        textField.adjustsFontSizeToFitWidth = true
        textField.textColor = .systemGray2
        textField.delegate = self
        textField.text = viewModel.amount
        return textField
    }()
    
    private lazy var countryTextfield: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.inputView = pickerView
        textField.inputAccessoryView = pickerView.toolbar
        textField.textAlignment = .center
        textField.textColor = .systemGray
        textField.font = .systemFont(ofSize: 26.0, weight: .bold)
        textField.text = viewModel.pickedCountry
        return textField
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.dataSource = self
        table.delegate = self
        table.register(
            CurrencyTableViewCell.self,
            forCellReuseIdentifier: CurrencyTableViewCell.reuseIdentifier
        )
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
        setupSubviews()
        setupObservers()
    }
    
    @objc
    func amountTextfieldFinishEditing() {
        amountTextfield.resignFirstResponder()
        if let text = amountTextfield.text {
            viewModel.amount = text
        }
    }
}

private extension CurrencyViewController {
    
    func setupObservers() {
        viewModel.$currencyCellVM.sink { [weak self] _ in
            print("sink")
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.tableView.reloadData()
            }
        }.store(in: &canncellable)
    }
    
    func setupSubviews() {
        view.addSubview(amountTextfield)
        amountTextfield.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(72)
        }
        
        view.addSubview(countryTextfield)
        countryTextfield.snp.makeConstraints { make in
            make.top.equalTo(amountTextfield.snp.bottom).offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.width.equalTo(120)
            make.height.equalTo(60)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(countryTextfield.snp.bottom).offset(16)
        }
    }
}

extension CurrencyViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        64
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.currencyCellVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellVM = viewModel.currencyCellVM[indexPath.row]
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CurrencyTableViewCell.reuseIdentifier,
            for: indexPath
        ) as! CurrencyTableViewCell
        cell.setup(cellVM)
        return cell
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
        viewModel.pickedCountry = dataSelected
    }
    
    func didTapCancel() {
        countryTextfield.resignFirstResponder()
    }
}

extension CurrencyViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == amountTextfield {
            textField.text = nil
        }
    }
}
