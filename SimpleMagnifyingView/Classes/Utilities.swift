//
//  Utilities.swift
//  SimpleMagnifyingView
//
//  Created by Tomortec on 2022/4/28.
//  Copyright © 2022 Tomortec. All rights reserved.
//

import SwiftUI

extension CGPoint {
    static func -(leftValue: Self, rightValue: Self) -> CGVector {
        return CGVector(dx: leftValue.x - rightValue.x, dy: leftValue.y - rightValue.y)
    }
}

extension Comparable {
    func clamp(to range: ClosedRange<Self>) -> Self {
        return min(range.upperBound, max(range.lowerBound, self))
    }
}

/// A type-erased Shape
public struct AnyShape: Shape {
    private var base: (CGRect) -> Path
    
    public init<S: Shape>(_ shape: S) {
        base = shape.path(in:)
    }
    
    public func path(in rect: CGRect) -> Path {
        base(rect)
    }
}
