//
//  Extension.swift
//  Livmo
//
//  Created by hayeon lee on 5/4/25.
//

import UIKit

extension UIButton {
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        let image = UIImage(color: color)
        setBackgroundImage(image, for: state)
    }
}

extension UIImage {
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        UIGraphicsBeginImageContext(size)
        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}

extension UIView {
    func matchCenterConstraint(with view: UIView) {
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func matchConstraints(with view: UIView, constant: CGFloat = 0, safeArea: Bool = false) {
        if safeArea {
            NSLayoutConstraint.activate([
                self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: constant),
                self.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: constant),
                self.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -constant),
                self.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -constant)
            ])
        } else {
            NSLayoutConstraint.activate([
                self.topAnchor.constraint(equalTo: view.topAnchor, constant: constant),
                self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant),
                self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant),
                self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constant)
            ])
        }
    }
    
    func addSizeConstraint(constant: CGFloat) {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: constant),
            self.widthAnchor.constraint(equalToConstant: constant)
        ])
    }
    
    func addSizeConstraint(_ size: CGSize) {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: size.height),
            self.widthAnchor.constraint(equalToConstant: size.width)
        ])
    }
}
