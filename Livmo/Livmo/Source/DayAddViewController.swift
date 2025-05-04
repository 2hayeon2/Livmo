//
//  DayAddViewController.swift
//  Livmo
//
//  Created by hayeon lee on 5/4/25.
//

import UIKit

class DayAddViewController: UIViewController, AlertDisplayable {
    
    private lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.bouncesHorizontally = false
        v.bouncesVertically = true
        v.showsHorizontalScrollIndicator = false
        v.isScrollEnabled = true
        return v
    }()
    
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
        v.text = "Sections"
        return v
    }()
    private lazy var 아침SectionView: SectionView = {
        let v = SectionView()
        v.title = "+ Add 아침 section"
        return v
    }()
    private lazy var 오전SectionView: SectionView = {
        let v = SectionView()
        v.title = "+ Add 오전 section"
        return v
    }()
    private lazy var 오후SectionView: SectionView = {
        let v = SectionView()
        v.title = "+ Add 오후 section"
        return v
    }()
    private lazy var 저녁SectionView: SectionView = {
        let v = SectionView()
        v.title = "+ Add 저녁 section"
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
        
        navigationItem.title = "Create Day"
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        
        view.addSubview(scrollView)
        scrollView.addSubview(titleSectionLabel)
        scrollView.addSubview(textField)
        scrollView.addSubview(timeSectionLabel)
        scrollView.addSubview(아침SectionView)
        scrollView.addSubview(오전SectionView)
        scrollView.addSubview(오후SectionView)
        scrollView.addSubview(저녁SectionView)
        scrollView.addSubview(bottomButton)
        
        scrollView.matchConstraints(with: view, safeArea: true)
        
        NSLayoutConstraint.activate([
            titleSectionLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),
            titleSectionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleSectionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            textField.topAnchor.constraint(equalTo: titleSectionLabel.bottomAnchor, constant: 16),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textField.heightAnchor.constraint(equalToConstant: 42),
            
            timeSectionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 32),
            timeSectionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            timeSectionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            아침SectionView.topAnchor.constraint(equalTo: timeSectionLabel.bottomAnchor, constant: 16),
            아침SectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            아침SectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            아침SectionView.heightAnchor.constraint(equalToConstant: 100),
            
            오전SectionView.topAnchor.constraint(equalTo: 아침SectionView.bottomAnchor, constant: 16),
            오전SectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            오전SectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            오전SectionView.heightAnchor.constraint(equalToConstant: 100),
            
            오후SectionView.topAnchor.constraint(equalTo: 오전SectionView.bottomAnchor, constant: 16),
            오후SectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            오후SectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            오후SectionView.heightAnchor.constraint(equalToConstant: 100),
            
            저녁SectionView.topAnchor.constraint(equalTo: 오후SectionView.bottomAnchor, constant: 16),
            저녁SectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            저녁SectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            저녁SectionView.heightAnchor.constraint(equalToConstant: 100),
            
            bottomButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            bottomButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bottomButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            bottomButton.heightAnchor.constraint(equalToConstant: DS.Button.Size.large.height)
        ])
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

struct DayAddViewController_Preview: PreviewProvider {
    static var previews: some View {
        NavigationViewWrapper()
            .previewDevice("iPhone 15 Pro")
    }

    struct NavigationViewWrapper: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UINavigationController {
            let vc = DayAddViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.setNavigationBarHidden(false, animated: false)
            return nav
        }

        func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
    }
}
#endif
