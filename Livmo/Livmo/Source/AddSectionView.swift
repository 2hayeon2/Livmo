//
//  AddSectionView.swift
//  Livmo
//
//  Created by hayeon lee on 5/4/25.
//

import UIKit

class AddSectionView: CodeBaseView {
    private lazy var containerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.clipsToBounds = true
        v.layer.borderColor = UIColor.systemGray.cgColor
        v.layer.borderWidth = 1
        v.layer.cornerRadius = 8
        return v
    }()
    
    private lazy var addLabel: DSLabel = {
        let v = DSLabel()
        v.setup(style: .subtitle)
        v.text = "+ Add morning section"
        return v
    }()
    
    override func setup() {
        super.setup()
        
        self.addSubview(containerView)
        containerView.addSubview(addLabel)
        
        containerView.matchConstraints(with: self)
        addLabel.matchCenterConstraint(with: containerView)
    }
}


#if DEBUG
import SwiftUI

struct AddSectionView_Preview: PreviewProvider {
    static var previews: some View {
        NavigationViewWrapper()
            .frame(width: 400, height: 400)
            .previewDevice("iPhone 15 Pro")
    }

    struct NavigationViewWrapper: UIViewRepresentable {
        func makeUIView(context: Context) -> some UIView {
            let v = AddSectionView()
            return v
        }
        
        func updateUIView(_ uiView: UIViewType, context: Context) {
            return
        }
    }
}
#endif
