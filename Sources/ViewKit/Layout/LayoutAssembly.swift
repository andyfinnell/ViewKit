import Foundation

enum LayoutAssemblyOperator: Int {
    case equal, lessThanEqual, greaterThanEqual
}

enum LayoutAssemblyPriority: Int {
    case low
    case high
    case required
}

struct LayoutAssemblyRelation: Equatable {
    let op: LayoutAssemblyOperator
    let constant: Float
    let priority: LayoutAssemblyPriority
    
    init(op: LayoutAssemblyOperator = .equal, constant: Float = 0.0, priority: LayoutAssemblyPriority = .required) {
        self.op = op
        self.constant = constant
        self.priority = priority
    }
}

enum LayoutAssemblyHAttribute: Int {
    case leading, hcenter, trailing
}

struct LayoutAssemblyHAnchor: Equatable {
    let item: NativeView
    let attribute: LayoutAssemblyHAttribute
}

enum LayoutAssemblyVAttribute: Int {
    case top, vcenter, baseline, bottom
}

struct LayoutAssemblyVAnchor: Equatable {
    let item: NativeView
    let attribute: LayoutAssemblyVAttribute
}

enum LayoutAssemblyDimensionAttribute: Int {
    case width, height
}

struct LayoutAssemblyDimensionAnchor: Equatable {
    let item: NativeView
    let attribute: LayoutAssemblyDimensionAttribute
}

enum LayoutAssembly: Equatable {
    case h(LayoutAssemblyHAnchor, LayoutAssemblyHAnchor, LayoutAssemblyRelation)
    case v(LayoutAssemblyVAnchor, LayoutAssemblyVAnchor, LayoutAssemblyRelation)
    case dimension(LayoutAssemblyDimensionAnchor, LayoutAssemblyDimensionAnchor?, LayoutAssemblyRelation)
}
