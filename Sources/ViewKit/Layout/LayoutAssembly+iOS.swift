#if canImport(UIKit)
import UIKit

extension LayoutAssemblyHAnchor {
    var anchor: NSLayoutXAxisAnchor {
        switch attribute {
        case .leading:
            return item.safeAreaLayoutGuide.leadingAnchor
        case .trailing:
            return item.safeAreaLayoutGuide.trailingAnchor
        case .hcenter:
            return item.safeAreaLayoutGuide.centerXAnchor
        }
    }
}

extension LayoutAssemblyVAnchor {
    var anchor: NSLayoutYAxisAnchor {
        switch attribute {
        case .top:
            return item.safeAreaLayoutGuide.topAnchor
        case .bottom:
            return item.safeAreaLayoutGuide.bottomAnchor
        case .vcenter:
            return item.safeAreaLayoutGuide.centerYAnchor
        case .baseline:
            return item.firstBaselineAnchor
        }
    }
}

extension LayoutAssemblyDimensionAnchor {
    var anchor: NSLayoutDimension {
        switch attribute {
        case .width:
            return item.safeAreaLayoutGuide.widthAnchor
        case .height:
            return item.safeAreaLayoutGuide.heightAnchor
        }
    }
}

extension LayoutAssembly {
    func constraint() -> NSLayoutConstraint {
        switch self {
        case let .h(first, second, relation):
            return first.anchor.anchorWithOffset(to: second.anchor).constraint(relation: relation)
        case let .v(first, second, relation):
            return first.anchor.anchorWithOffset(to: second.anchor).constraint(relation: relation)
        case let .dimension(first, second, relation):
            if let second = second {
                return first.anchor.constraint(other: second.anchor, relation: relation)
            } else {
                return first.anchor.constraint(relation: relation)
            }
        }
    }
}

extension LayoutAssemblyPriority {
    var priority: UILayoutPriority {
        switch self {
        case .low: return .defaultLow
        case .high: return .defaultHigh
        case .required: return .required
        }
    }
}

extension NSLayoutDimension {
    func constraint(relation: LayoutAssemblyRelation) -> NSLayoutConstraint {
        let c: NSLayoutConstraint
        switch relation.op {
        case .equal:
            c = constraint(equalToConstant: CGFloat(relation.constant))
        case .lessThanEqual:
            c = constraint(lessThanOrEqualToConstant: CGFloat(relation.constant))
        case .greaterThanEqual:
            c = constraint(greaterThanOrEqualToConstant: CGFloat(relation.constant))
        }
        c.priority = relation.priority.priority
        return c
    }
    
    func constraint(other: NSLayoutDimension, relation: LayoutAssemblyRelation) -> NSLayoutConstraint {
        let c: NSLayoutConstraint
        switch relation.op {
        case .equal:
            c = constraint(equalTo: other, multiplier: 1.0, constant: CGFloat(relation.constant))
        case .lessThanEqual:
            c = constraint(lessThanOrEqualTo: other, multiplier: 1.0, constant: CGFloat(relation.constant))
        case .greaterThanEqual:
            c = constraint(greaterThanOrEqualTo: other, multiplier: 1.0, constant: CGFloat(relation.constant))
        }
        c.priority = relation.priority.priority
        return c
    }
}

extension Array where Element == LayoutAssembly {
    func constraints() -> [NSLayoutConstraint] {
        return map { $0.constraint() }
    }
}
#endif
