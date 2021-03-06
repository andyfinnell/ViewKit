import Foundation

public enum HorizontalAnchor {
    case leadingGuide
    case trailingGuide
    case centerGuide
    case leading(NativeViewable)
    case trailing(NativeViewable)
    case center(NativeViewable)
    
    fileprivate func lower(other: HorizontalAnchor) -> LayoutAssemblyHAnchor {
        switch self {
        case .leadingGuide:
            guard let s = other.view?.superview else {
                fatalError("misconfigured constraint has no views")
            }
            return LayoutAssemblyHAnchor(item: s, attribute: .leading)
        case .trailingGuide:
            guard let s = other.view?.superview else {
                fatalError("misconfigured constraint has no views")
            }
            return LayoutAssemblyHAnchor(item: s, attribute: .trailing)
        case .centerGuide:
            guard let s = other.view?.superview else {
                fatalError("misconfigured constraint has no views")
            }
            return LayoutAssemblyHAnchor(item: s, attribute: .hcenter)
        case let .leading(view):
            return LayoutAssemblyHAnchor(item: view.asView, attribute: .leading)
        case let .trailing(view):
            return LayoutAssemblyHAnchor(item: view.asView, attribute: .trailing)
        case let .center(view):
            return LayoutAssemblyHAnchor(item: view.asView, attribute: .hcenter)
        }
    }
    
    private var view: NativeView? {
        switch self {
        case .leadingGuide: return nil
        case .trailingGuide: return nil
        case .centerGuide: return nil
        case let .leading(view): return view.asView
        case let .trailing(view): return view.asView
        case let .center(view): return view.asView
        }
    }
}

public enum VerticalAnchor {
    case topGuide
    case bottomGuide
    case centerGuide
    case top(NativeViewable)
    case bottom(NativeViewable)
    case baseline(NativeViewable)
    case center(NativeViewable)
    
    fileprivate func lower(other: VerticalAnchor) -> LayoutAssemblyVAnchor {
        switch self {
        case .topGuide:
            guard let s = other.view?.superview else {
                fatalError("misconfigured constraint has no views")
            }
            return LayoutAssemblyVAnchor(item: s, attribute: .top)
        case .bottomGuide:
            guard let s = other.view?.superview else {
                fatalError("misconfigured constraint has no views")
            }
            return LayoutAssemblyVAnchor(item: s, attribute: .bottom)
        case .centerGuide:
            guard let s = other.view?.superview else {
                fatalError("misconfigured constraint has no views")
            }
            return LayoutAssemblyVAnchor(item: s, attribute: .vcenter)
        case let .top(view):
            return LayoutAssemblyVAnchor(item: view.asView, attribute: .top)
        case let .bottom(view):
            return LayoutAssemblyVAnchor(item: view.asView, attribute: .bottom)
        case let .baseline(view):
            return LayoutAssemblyVAnchor(item: view.asView, attribute: .baseline)
        case let .center(view):
            return LayoutAssemblyVAnchor(item: view.asView, attribute: .vcenter)
        }
    }
    
    private var view: NativeView? {
        switch self {
        case .topGuide: return nil
        case .bottomGuide: return nil
        case .centerGuide: return nil
        case let .top(view): return view.asView
        case let .bottom(view): return view.asView
        case let .baseline(view): return view.asView
        case let .center(view): return view.asView
        }
    }
}

public enum SizeAnchor {
    case width(NativeViewable)
    case height(NativeViewable)
    case constant(Float)
    
    fileprivate func lower() -> LayoutAssemblyDimensionAnchor? {
        switch self {
        case let .width(view):
            return LayoutAssemblyDimensionAnchor(item: view.asView, attribute: .width)
        case let .height(view):
            return LayoutAssemblyDimensionAnchor(item: view.asView, attribute: .height)
        case .constant(_): return nil
        }
    }
    
    fileprivate func requiredLower() -> LayoutAssemblyDimensionAnchor {
        guard let l = lower() else {
            fatalError("first size constraint must be width or height")
        }
        return l
    }
    
    fileprivate func lowerConstant() -> Float {
        switch self {
        case .width(_): return 0.0
        case .height(_): return 0.0
        case let .constant(value): return value
        }
    }
    
}

enum VerticalSide {
    case top, bottom
}

enum SpacingConstraint {
    case equal(Float)
    case lessThan(Float)
    case greaterThan(Float)
}

public enum ColumnLayout {
    case topGuide
    case space(Float)
    case spaceOfAtLeast(Float)
    case view(leading: Float? = nil, NativeViewable, trailing: Float? = nil)
    case bottomGuide
    
    func anchor(for side: VerticalSide) -> VerticalAnchor? {
        switch self {
        case .topGuide:
            return .topGuide
        case .space(_):
            return nil
        case .spaceOfAtLeast:
            return nil
        case let .view(_, view, _):
            switch side {
            case .top: return .top(view)
            case .bottom: return .bottom(view)
            }
        case .bottomGuide:
            return .bottomGuide
        }
    }
    
    fileprivate var spacing: SpacingConstraint? {
        switch self {
        case let .space(value): return .equal(value)
        case let .spaceOfAtLeast(value): return .greaterThan(value)
        default: return nil
        }
    }
    
    fileprivate var horizontalConstraints: [CoreLayout] {
        switch self {
        case .topGuide, .space, .spaceOfAtLeast, .bottomGuide:
            return []
        case let .view(leading: leading, view, trailing: trailing):
            var constraints = [CoreLayout]()
            if let leading = leading {
                constraints.append(.halign(.leadingGuide, .leading(view), LayoutAssemblyRelation(constant: leading)))
            }
            if let trailing = trailing {
                constraints.append(.halign(.trailing(view), .trailingGuide, LayoutAssemblyRelation(constant: trailing)))
            }
            return constraints
        }
    }
}

enum HorizontalSide {
    case leading, trailing
}

public enum RowLayout {
    case leadingGuide
    case space(Float)
    case spaceOfAtLeast(Float)
    case view(NativeViewable)
    case trailingGuide
    
    func anchor(for side: HorizontalSide) -> HorizontalAnchor? {
        switch self {
        case .leadingGuide:
            return .leadingGuide
        case .space, .spaceOfAtLeast:
            return nil
        case let .view(view):
            switch side {
            case .leading: return .leading(view)
            case .trailing: return .trailing(view)
            }
        case .trailingGuide:
            return .trailingGuide
        }
    }

    var spacing: SpacingConstraint? {
        switch self {
        case let .space(value): return .equal(value)
        case let .spaceOfAtLeast(value): return .greaterThan(value)
        default: return nil
        }
    }
}

private enum CoreLayout {
    case halign(HorizontalAnchor, HorizontalAnchor, LayoutAssemblyRelation)
    case valign(VerticalAnchor, VerticalAnchor, LayoutAssemblyRelation)
    case size(SizeAnchor, SizeAnchor, LayoutAssemblyRelation)

    func compile() -> [LayoutAssembly] {
        switch self {
        case let .halign(first, second, relation):
            return [.h(first.lower(other: second),
                       second.lower(other: first),
                       relation)]
        case let .valign(first, second, relation):
            return [.v(first.lower(other: second),
                       second.lower(other: first),
                       relation)]
        case let .size(first, second, relation):
            return [.dimension(first.requiredLower(),
                               second.lower(),
                               LayoutAssemblyRelation(op: relation.op, constant: second.lowerConstant(), priority: relation.priority))]
        }
    }
}

public enum Layout {
    case halign(HorizontalAnchor, Float, HorizontalAnchor)
    case valign(VerticalAnchor, Float, VerticalAnchor)
    case size(SizeAnchor, SizeAnchor)

    case leading(Float, NativeViewable)
    case trailing(NativeViewable, Float)
    case hmargin(Float, NativeViewable, Float)
    case hmarginAtLeast(Float, NativeViewable, Float)
    case hmarginTrailingAtLeast(Float, NativeViewable, Float)
    case width(NativeViewable, SizeAnchor)
    case maximumWidth(NativeViewable, SizeAnchor)
    case hcenter(NativeViewable)
    case hcenterContainer(NativeViewable, minMargin: Float, maxWidth: Float)
    case row([RowLayout])
    
    case top(Float, NativeViewable)
    case bottom(NativeViewable, Float)
    case vmargin(Float, NativeViewable, Float)
    case vmarginAtLeast(Float, NativeViewable, Float)
    case height(NativeViewable, SizeAnchor)
    case vcenter(NativeViewable)
    case column([ColumnLayout])
    
    case center(NativeViewable)
    
    func compile() -> [LayoutAssembly] {
        return lower().flatMap { $0.compile() }
    }
    
    private func lower() -> [CoreLayout] {
        switch self {
        case let .halign(first, space, second):
            return [.halign(first, second, LayoutAssemblyRelation(constant: space))]
        case let .valign(first, space, second):
            return [.valign(first, second, LayoutAssemblyRelation(constant: space))]
        case let .size(first, second):
            return [.size(first, second, LayoutAssemblyRelation())]
            
        case let .leading(space, view):
            return [.halign(.leadingGuide, .leading(view), LayoutAssemblyRelation(constant: space))]
        case let .trailing(view, space):
            return [.halign(.trailing(view), .trailingGuide, LayoutAssemblyRelation(constant: space))]
        case let .hmargin(leading, view, trailing):
            return [.halign(.leadingGuide, .leading(view), LayoutAssemblyRelation(constant: leading)),
                    .halign(.trailing(view), .trailingGuide, LayoutAssemblyRelation(constant: trailing))]
        case let .hmarginAtLeast(leading, view, trailing):
            return [.halign(.leadingGuide, .leading(view), LayoutAssemblyRelation(op: .greaterThanEqual, constant: leading)),
                    .halign(.trailing(view), .trailingGuide, LayoutAssemblyRelation(op: .greaterThanEqual, constant: trailing))]
        case let .hmarginTrailingAtLeast(leading, view, trailing):
            return [.halign(.leadingGuide, .leading(view), LayoutAssemblyRelation(constant: leading)),
                    .halign(.trailing(view), .trailingGuide, LayoutAssemblyRelation(op: .greaterThanEqual, constant: trailing))]
        case let .width(view, anchor):
            return [.size(.width(view), anchor, LayoutAssemblyRelation())]
        case let .maximumWidth(view, anchor):
            return [.size(.width(view), anchor, LayoutAssemblyRelation(op: .lessThanEqual))]
        case let .hcenter(view):
            return [.halign(.center(view), .centerGuide, LayoutAssemblyRelation())]
        case let .hcenterContainer(view, minMargin: margin, maxWidth: width):
            return [.halign(.center(view), .centerGuide, LayoutAssemblyRelation()),
                .size(.width(view), .constant(width), LayoutAssemblyRelation(op: .lessThanEqual)),
                .halign(.leadingGuide, .leading(view), LayoutAssemblyRelation(op: .greaterThanEqual, constant: margin)),
                .halign(.trailing(view), .trailingGuide, LayoutAssemblyRelation(op: .greaterThanEqual, constant: margin)),
                .halign(.leadingGuide, .leading(view), LayoutAssemblyRelation(constant: margin, priority: .high)),
                .halign(.trailing(view), .trailingGuide, LayoutAssemblyRelation(constant: margin, priority: .high))

            ]
        case let .row(rows):
            return lower(rows: rows)
            
        case let .top(space, view):
            return [.valign(.topGuide, .top(view), LayoutAssemblyRelation(constant: space))]
        case let .bottom(view, space):
            return [.valign(.bottom(view), .bottomGuide, LayoutAssemblyRelation(constant: space))]
        case let .vmargin(top, view, bottom):
            return [.valign(.topGuide, .top(view), LayoutAssemblyRelation(constant: top)),
                    .valign(.bottom(view), .bottomGuide, LayoutAssemblyRelation(constant: bottom))]
        case let .vmarginAtLeast(top, view, bottom):
            return [.valign(.topGuide, .top(view), LayoutAssemblyRelation(op: .greaterThanEqual, constant: top)),
                    .valign(.bottom(view), .bottomGuide, LayoutAssemblyRelation(op: .greaterThanEqual, constant: bottom))]

        case let .height(view, anchor):
            return [.size(.height(view), anchor, LayoutAssemblyRelation())]
        case let .vcenter(view):
            return [.valign(.center(view), .centerGuide, LayoutAssemblyRelation())]
        case let .column(columns):
            return lower(columns: columns)
            
        case let .center(view):
            return [.halign(.center(view), .centerGuide, LayoutAssemblyRelation()),
                    .valign(.center(view), .centerGuide, LayoutAssemblyRelation())]
        }
    }
    
    private func lower(rows: [RowLayout]) -> [CoreLayout] {
        var previousAnchor: RowLayout?
        var spacing = SpacingConstraint.equal(0.0)
        var constraints = [CoreLayout]()
        
        for row in rows {
            guard let leadingAnchor = row.anchor(for: .leading) else {
                if let space = row.spacing {
                    spacing = space
                }
                continue
            }
            
            if let trailingAnchor = previousAnchor?.anchor(for: .trailing) {
                let relation: LayoutAssemblyRelation
                switch spacing {
                case let .equal(value):
                    relation = LayoutAssemblyRelation(op: .equal, constant: value)
                case let .greaterThan(value):
                    relation = LayoutAssemblyRelation(op: .greaterThanEqual, constant: value)
                case let .lessThan(value):
                    relation = LayoutAssemblyRelation(op: .lessThanEqual, constant: value)
                }
                constraints.append(.halign(trailingAnchor, leadingAnchor, relation))
                previousAnchor = row
                spacing = .equal(0.0)
            } else {
                previousAnchor = row
            }
        }
        
        return constraints
    }
    
    private func lower(columns: [ColumnLayout]) -> [CoreLayout] {
        var previousAnchor: ColumnLayout?
        var spacing = SpacingConstraint.equal(0.0)
        var constraints = [CoreLayout]()
        
        for column in columns {
            guard let topAnchor = column.anchor(for: .top) else {
                if let space = column.spacing {
                    spacing = space
                }
                continue
            }
            
            constraints.append(contentsOf: column.horizontalConstraints)
            
            if let bottomAnchor = previousAnchor?.anchor(for: .bottom) {
                let relation: LayoutAssemblyRelation
                switch spacing {
                case let .equal(value):
                    relation = LayoutAssemblyRelation(op: .equal, constant: value)
                case let .greaterThan(value):
                    relation = LayoutAssemblyRelation(op: .greaterThanEqual, constant: value)
                case let .lessThan(value):
                    relation = LayoutAssemblyRelation(op: .lessThanEqual, constant: value)
                }
                constraints.append(.valign(bottomAnchor, topAnchor, relation))
                previousAnchor = column
                spacing = .equal(0.0)
            } else {
                previousAnchor = column
            }
        }
        
        return constraints
    }
}

extension Array where Element == Layout {
    func compile() -> [LayoutAssembly] {
        return flatMap { $0.compile() }
    }
}
