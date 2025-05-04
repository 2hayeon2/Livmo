//
//  BlockView.swift
//  Livmo
//
//  Created by hayeon lee on 5/4/25.
//

import UIKit

class BlockView: CodeBaseView {
    private lazy var containerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.clipsToBounds = true
        v.layer.cornerRadius = 16
        v.backgroundColor = .green.withAlphaComponent(0.5)
        return v
    }()
    
    private lazy var titleLabel: DSLabel = {
        let v = DSLabel()
        v.setup(style: .tag)
        v.text = "책 1장 읽기"
        return v
    }()
    
    override func setup() {
        super.setup()
        
        self.addSubview(containerView)
        containerView.addSubview(titleLabel)
        
        containerView.matchConstraints(with: self)
        titleLabel.matchConstraints(with: containerView, constant: 16)
    }
}


#if DEBUG
import SwiftUI

struct BlockView_Preview: PreviewProvider {
    static var previews: some View {
        NavigationViewWrapper()
            .frame(width: 400, height: 400)
            .previewDevice("iPhone 15 Pro")
    }

    struct NavigationViewWrapper: UIViewRepresentable {
        func makeUIView(context: Context) -> some UIView {
            let v = BlockView()
            return v
        }
        
        func updateUIView(_ uiView: UIViewType, context: Context) {
            return
        }
    }
}
#endif

