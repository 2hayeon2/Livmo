//
//  BlockAddViewController.swift
//  Livmo
//
//  Created by hayeon lee on 5/4/25.
//

import UIKit

class BlockAddViewController: UIViewController, AlertDisplayable {
    
    private lazy var titleSectionLabel: DSLabel = {
        let v = DSLabel()
        v.setup(style: .title)
        v.text = "Title"
        return v
    }()
    private lazy var textField : DSTextField = {
        let v = DSTextField()
        v.setup()
        v.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return v
    }()
    private lazy var timeSectionLabel: DSLabel = {
        let v = DSLabel()
        v.setup(style: .title)
        v.text = "Time"
        return v
    }()
    private lazy var timeButton1: DSButton = {
        let v = DSButton()
        v.setup(size: .medium, style: .secondaryOutline)
        v.setTitle("10m", for: .normal)
        v.tag = 10
        v.addTarget(self, action: #selector(handleTimeButtonTapped(_:)), for: .touchUpInside)
        return v
    }()
    private lazy var timeButton2: DSButton = {
        let v = DSButton()
        v.setup(size: .medium, style: .secondaryOutline)
        v.tag = 30
        v.setTitle("30m", for: .normal)
        v.addTarget(self, action: #selector(handleTimeButtonTapped(_:)), for: .touchUpInside)
        return v
    }()
    private lazy var timeButton3: DSButton = {
        let v = DSButton()
        v.setup(size: .medium, style: .secondaryOutline)
        v.tag = 60
        v.setTitle("1h", for: .normal)
        v.addTarget(self, action: #selector(handleTimeButtonTapped(_:)), for: .touchUpInside)
        return v
    }()
    private lazy var bottomButton: DSButton = {
        let v = DSButton()
        v.setup(size: .large, style: .primary)
        v.setTitle("Create", for: .normal)
        v.addTarget(self, action: #selector(handleBottomButtonTapped(_:)), for: .touchUpInside)
        return v
    }()
    
    private var inputText: String?
    private var inputTime: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Create Block"
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        view.addSubview(titleSectionLabel)
        view.addSubview(textField)
        view.addSubview(timeSectionLabel)
        view.addSubview(timeButton1)
        view.addSubview(timeButton2)
        view.addSubview(timeButton3)
        view.addSubview(bottomButton)
        
        NSLayoutConstraint.activate([
            titleSectionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleSectionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleSectionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            textField.topAnchor.constraint(equalTo: titleSectionLabel.bottomAnchor, constant: 16),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textField.heightAnchor.constraint(equalToConstant: 42),
            
            timeSectionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 32),
            timeSectionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            timeSectionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            timeButton1.topAnchor.constraint(equalTo: timeSectionLabel.bottomAnchor, constant: 16),
            timeButton1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            timeButton1.widthAnchor.constraint(equalToConstant: 80),
            
            timeButton2.topAnchor.constraint(equalTo: timeButton1.topAnchor),
            timeButton2.leadingAnchor.constraint(equalTo: timeButton1.trailingAnchor, constant: 8),
            timeButton2.widthAnchor.constraint(equalTo: timeButton1.widthAnchor),
            
            timeButton3.topAnchor.constraint(equalTo: timeButton1.topAnchor),
            timeButton3.leadingAnchor.constraint(equalTo: timeButton2.trailingAnchor, constant: 8),
            timeButton3.widthAnchor.constraint(equalTo: timeButton1.widthAnchor),
            
            bottomButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            bottomButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bottomButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            bottomButton.heightAnchor.constraint(equalToConstant: DS.Button.Size.large.height)
        ])
    }
    
    @objc func handleTimeButtonTapped(_ sender: UIButton) {
        let minutes = sender.tag
        self.inputTime = minutes
        timeButton1.isSelected = minutes == 10
        timeButton2.isSelected = minutes == 30
        timeButton3.isSelected = minutes == 60
    }
    
    @objc func handleBottomButtonTapped(_ sender: UIButton) {
        guard let title = inputText else {
            showAlert(title: "Add title", message: "")
            return
        }
        guard let time = inputTime else {
            showAlert(title: "Add time", message: "")
            return
        }
        
        showAlert(title: "Add block",
                  message: "",
                  showCancel: true,
                  afterDefault: { [weak self] in
            self?.saveBlock(title: title, time: time)
        })
    }
    
    @objc func textFieldDidChange(_ sender: UITextField) {
        inputText = sender.text
    }
    
    private func saveBlock(title: String, time: Int) {
        let block = Block(uid: UUID().uuidString,
                          title: title,
                          tagList: [Tag(title: "\(time)")])
        DB.shared.saveBlock(block)
        Log.info("Save Success!")
    }
}

#if DEBUG
import SwiftUI

struct BlockAddViewController_Preview: PreviewProvider {
    static var previews: some View {
        NavigationViewWrapper()
            .previewDevice("iPhone 15 Pro")
    }

    struct NavigationViewWrapper: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UINavigationController {
            let vc = BlockAddViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.setNavigationBarHidden(false, animated: false)
            return nav
        }

        func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
    }
}
#endif


protocol AlertDisplayable {
    func showAlert(title: String,
                   message: String,
                   showCancel: Bool,
                   afterCancel: (() -> Void)?,
                   afterDefault: (() -> Void)?)
}

extension AlertDisplayable where Self: UIViewController {
    func showAlert(title: String,
                   message: String,
                   showCancel: Bool = false,
                   afterCancel: (() -> Void)? = nil,
                   afterDefault: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if showCancel {
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { _ in
                afterCancel?()
            }))
        }
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
            afterDefault?()
        }))
        self.navigationController?.present(alert, animated: true)
    }
}
