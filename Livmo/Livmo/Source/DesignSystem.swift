//
//  DesignSystem.swift
//  Livmo
//
//  Created by hayeon lee on 5/4/25.
//

import UIKit

typealias DS = DesignSystem

struct DesignSystem {
    struct Color {
        static let text: UIColor = .label
        static let background: UIColor = .systemBackground
        static let primary: UIColor = .systemBlue
        static let secondary: UIColor = .systemGray
        static let accent: UIColor = .systemOrange
        static let error: UIColor = .systemRed
        static let success: UIColor = .systemGreen
        static let warning: UIColor = .systemYellow
        static let placeholder: UIColor = .secondaryLabel
        static let tag: UIColor = .label.withAlphaComponent(0.65)
    }
}


extension DesignSystem {
    struct Label {
        enum Style {
            case title
            case subtitle
            case tag
//            case body
//            case callout
//            case caption
//            case footnote
//            case subheadline
            
            var font: UIFont {
                switch self {
                case .title:
                    return .systemFont(ofSize: 32, weight: .bold)
                case .subtitle:
                    return .systemFont(ofSize: 24, weight: .semibold)
                case .tag:
                    return .systemFont(ofSize: 24)
                }
            }
            
            var color: UIColor {
                switch self {
                case .title:
                    return DS.Color.text
                case .subtitle:
                    return DS.Color.secondary
                case .tag:
                    return DS.Color.tag
                }
            }
        }
    }
}

extension DesignSystem {
    struct Button {
        enum Size {
            case medium
            case large
            
            var titleFont: UIFont {
                switch self {
                case .medium:
                    return .systemFont(ofSize: 20, weight: .regular)
                case .large:
                    return .systemFont(ofSize: 24, weight: .semibold)
                }
            }
            
            var cornerRadius: CGFloat {
                switch self {
                case .medium:
                    return 8
                case .large:
                    return 10
                }
            }
            
            var height: CGFloat {
                switch self {
                case .medium:
                    return 32
                case .large:
                    return 44
                }
            }
        }
        
        enum Style {
            case primary
            case secondary
            case primaryOutline
            case secondaryOutline
           
            func textColor(state: UIControl.State) -> UIColor {
                switch self {
                case .primary:
                    return state.contains(.highlighted) ? .white : .white
                case .secondary:
                    return state.contains(.highlighted) ? .white : .black
                case .primaryOutline:
                    return state.contains(.highlighted) ? .white : .systemBlue
                case .secondaryOutline:
                    if state.contains(.highlighted) {
                        return .darkGray.withAlphaComponent(0.5)
                    } else if state.contains(.selected) {
                        return .white
                    } else {
                        return .darkGray
                    }
                }
            }

            func backgroundColor(state: UIControl.State) -> UIColor {
                switch self {
                case .primary:
                    return state.contains(.highlighted) ? UIColor.systemBlue.withAlphaComponent(0.8) : .systemBlue
                case .secondary:
                    return state.contains(.highlighted) ? UIColor.gray.withAlphaComponent(0.8) : .gray
                case .primaryOutline:
                    return state.contains(.highlighted) ? .systemBlue : .clear
                case .secondaryOutline:
                    if state.contains(.highlighted) {
                        return .clear
                    } else if state.contains(.selected) {
                        return .systemBlue
                    } else {
                        return .clear
                    }
                }
            }

            func borderColor(state: UIControl.State) -> UIColor {
                switch self {
                case .primary:
                    return .clear
                case .secondary:
                    return .clear
                case .primaryOutline:
                    return state.contains(.highlighted) ? .clear : .systemBlue
                case .secondaryOutline:
                    if state.contains(.highlighted) {
                        return .darkGray.withAlphaComponent(0.5)
                    } else if state.contains(.selected) {
                        return .clear
                    } else {
                        return .darkGray
                    }
                }
            }
        }
    }
}
