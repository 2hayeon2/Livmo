//
//  View.swift
//  Livmo
//
//  Created by hayeon lee on 5/4/25.
//

import UIKit

class CodeBaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 400, height: 400)
    }
    
    func setup() {}
}

class CodeBaseLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CodeBaseButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CodeBaseTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DSTextField: CodeBaseTextField {
    func setup() {
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.systemGray.cgColor
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
    }
}

class DSLabel: CodeBaseLabel {
    func setup(style: DesignSystem.Label.Style) {
        self.textColor = style.color
        self.font = style.font
    }
}

class DSButton: CodeBaseButton {
    func setup(size: DesignSystem.Button.Size, style: DesignSystem.Button.Style) {
        clipsToBounds = true
        layer.cornerRadius = size.cornerRadius
        titleLabel?.font = size.titleFont
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
        
        setTitleColor(style.textColor(state: .normal), for: .normal)
        setTitleColor(style.textColor(state: .highlighted), for: .highlighted)
        setTitleColor(style.textColor(state: .selected), for: .selected)
        
        setBackgroundColor(style.backgroundColor(state: .normal), for: .normal)
        setBackgroundColor(style.backgroundColor(state: .highlighted), for: .highlighted)
        setBackgroundColor(style.backgroundColor(state: .selected), for: .selected)

        layer.borderWidth = 1
        layer.borderColor = style.borderColor(state: .normal).cgColor
    }
}
