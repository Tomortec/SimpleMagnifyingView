//
//  MagnifierView.swift
//  SimpleMagnifyingView
//
//  Created by Tomortec on 2022/4/30.
//  Copyright © 2022 Tomortec. All rights reserved.
//

import SwiftUI

/**
 Create a magnifying glass which will magnify the views behind it
 
 Simple Example:
 ``` swift
 MagnifierView(isMagnifying: .constant(true)) {
     Text("Hello world")
         .foregroundColor(.white)
         // README: transparent background will cause unexpected results
         // please have a look at our `UnexpectedResult1`
         .frame(maxWidth: .infinity, maxHeight: .infinity)
         .background(.cyan)
 }
 .outlineColor(.white)
 .closeButtonColor(.white)
 ```
 - note: it's recommended that the `MagnifierView` be the first view of your `ContentView`'s `body`
 - attention: the views to be magnified should not have TRANSPARENT background!! Have a look at our example above. `Text` Views are always facing this problem
 - attention: trying to magnify complex views like video may be a large performance problem,
 because the `MagnifierView` attempts to copy `content` passed. However, it's not tested yet
 - important: `MagnifierView` does NOT `.ignoresSafeArea()`
 */
public struct MagnifierView<Content: View>: View {
    
    let content: Content
    
    /* MARK: - Appearance */
    var magnifyingGlassSize: CGSize = CGSize(width: 200.0, height: 200.0)
    var magnifyingGlassShape: AnyShape
    var glassHandleWidthRatio: CGFloat = 0.3
    var glassHandleHeight: CGFloat = 15.0
    
    var outlineColor: Color = .black
    var outlineWidth: CGFloat = 5.0
    
    var maskBackgroundColor: Color = .black.opacity(0.1)
    
    var closeButtonSize: CGSize = CGSize(width: 40.0, height: 40.0)
    var closeButtonColor: Color = .black
    
    /* MARK: - Controlling */
    @Binding var isMagnifying: Bool
    @Binding var scale: CGFloat
    
    var enableHitInMagnifyingGlass: Bool = true
    
    var isShowingCloseButton: Bool = true
    
    /// a vector from the center of the magnifying view pointing to the center of the screen, used to control the position of the scaled `content`
    @State private var translation: CGVector = .init(dx: 0, dy: 0)
    
    /// the position of magnifying glass
    @State private var position: CGPoint = .init(x: UIScreen.main.bounds.width / 2.0, y: UIScreen.main.bounds.height / 2.0 - 60.0)
    
    /**
     Construct a `MagnifierView` with must-have paras: `isMagnifying`
     
     - parameters:
        - isMagnifying: a binding used to control the visibility of `MagnifierView`. Note that when this binding is set as `.constant(true)`, the `closeButton` does not work. Required
        - scale: a binding used to control the scaling of the `MagnifierView`. Default is `.constant(2.0)`
        - glassShape: determines the shape of the magnifying glass. Note that the `Shape` passed should be wrapped by `AnyShape(_:)`. Default is `AnyShape(RoundedRectangle(cornerRadius: 12.0))`
        - content: the views to magnify. It's recommended that the `MagnifierView` be the first view of your `ContentView`'s `body`. Required
     
     - important: the `MagnifierView` does not clamp the `scale`, which means if the `scale` is too small, the magnifying glass cannot hold the whole scaled `content` in it. Therefore, you may have to clamp the `scale` passed ( >= 1.0 ) when it's being modified. Our `UnexpectedResult2` in the example demonstrates this.
     - note: when `isMagnifying` binding is set as `.constant(true)`, the `closeButton` does not work
     */
    public init(
        isMagnifying: Binding<Bool>,
        scale: Binding<CGFloat> = .constant(2.0),
        glassShape: AnyShape = AnyShape(RoundedRectangle(cornerRadius: 12.0)),
        @ViewBuilder _ content: () -> Content
    ) {
        self.magnifyingGlassShape = glassShape
        self._isMagnifying = isMagnifying
        self._scale = scale
        self.content = content()
    }
    
    public var body: some View {
        GeometryReader {
            geometry in
            
            ZStack {
                content
                
                if isMagnifying {
                    // MARK: - Mask
                    
                    // if using color like `maskBackgroundColor.frame(maxWidth: .infinity, maxHeight: .infinity)`,
                    // the mask will not fill the whole screen, leaving the safe areas uncovered
                    Text("")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(maskBackgroundColor)
                        .allowsHitTesting(false)
                        .zIndex(99)
                    
                    // MARK: - Close Button
                    if isShowingCloseButton {
                        Button(action: {
                            withAnimation {
                                isMagnifying.toggle()
                            }
                        }, label: {
                            Image(systemName: "xmark.circle")
                                .resizable()
                        })
                        .frame(width: closeButtonSize.width, height: closeButtonSize.height)
                        .offset(x: geometry.size.width / 2.0 - closeButtonSize.width,
                                y: geometry.size.height / -2.0 + closeButtonSize.height)
                        .foregroundColor(closeButtonColor)
                        .zIndex(99)
                    }
                    
                    // MARK: - Copied View
                    content
                        .allowsHitTesting(enableHitInMagnifyingGlass)
                        .scaleEffect(scale, anchor: .center)
                        .zIndex(100)
                        // plus with `geometry.size / 2.0` to make it in the center of the screen,
                        // position(0, 0) will place the scaled `content` in the top leading on the screen
                        //
                        // using `frame.width` / 2.0 and `frame.height / 2.0` instead of
                        // `.midX` and `.midY` to take safe area into consideration
                        .position(
                            x: translation.dx * (scale - 1.0) + geometry.size.width / 2.0,
                            y: translation.dy * (scale - 1.0) + geometry.size.height / 2.0)
                        // clip to bounds
                        .mask(
                            magnifyingGlassShape
                                .size(magnifyingGlassSize)
                                .frame(width: magnifyingGlassSize.width, height: magnifyingGlassSize.height)
                                .position(position)
                        )
                        .contentShape(
                            magnifyingGlassShape
                                .size(magnifyingGlassSize)
                                // the coordinate of `.offset` and `position` is different, transformation needed
                                .offset(x: position.x - magnifyingGlassSize.width / 2.0,
                                        y: position.y - magnifyingGlassSize.height / 2.0)
                        )
                    
                    // MARK: - Magnifying Glass
                    MagnifyingGlass(
                        size: magnifyingGlassSize,
                        shape: magnifyingGlassShape,
                        handleWidthRatio: glassHandleWidthRatio,
                        handleHeight: glassHandleHeight,
                        position: $position,
                        translation: $translation,
                        geometry: geometry,
                        enableHitInMagnifyingView: enableHitInMagnifyingGlass,
                        zIndex: 100
                    )
                    .outlineColor(outlineColor)
                    .outlineWidth(outlineWidth)
                }
            }
        }
    }
}

/* MARK: - Property Modifiers */
extension MagnifierView {
    /// Config the size of the magnifying glass
    public func magnifyingGlassSize(_ size: CGSize) -> Self {
        var copied = self
        copied.magnifyingGlassSize = size
        return copied
    }
    
    /// Config the shape of the magnifying glass
    ///
    /// - note: use `AnyShape(_:)` to wrap the `Shape`
    ///
    /// Example:
    /// ``` Swift
    /// MagnifierView(isMagnifying: $isMagnifying) {
    ///     Text("Hello world")
    ///         .foregroundColor(.white)
    ///         .frame(maxWidth: .infinity, maxHeight: .infinity)
    ///         .background(.cyan)
    /// }
    /// .magnifyingGlassShape(AnyShape(Rectangle()))    // use `AnyShape(_:)` to wrap the `Shape`
    /// ```
    public func magnifyingGlassShape(_ shape: AnyShape) -> Self {
        var copied = self
        copied.magnifyingGlassShape = shape
        return copied
    }
    
    /// Set the scale of the handle width
    ///
    /// - note: this method receives `ratio`, while `.handleHeight(_:)` method receives absolute value
    public func handleWidthRatio(_ ratio: CGFloat) -> Self {
        var copied = self
        copied.glassHandleWidthRatio = ratio
        return copied
    }
    
    /// Set the height of the handle
    ///
    /// - note: this method receives `absolute value`, while `.handleWidthRatio(_:)` receives ratio
    public func handleHeight(_ height: CGFloat) -> Self {
        var copied = self
        copied.glassHandleHeight = height
        return copied
    }
    
    /// Set the background color of the mask
    public func maskBackgroundColor(_ color: Color) -> Self {
        var copied = self
        copied.maskBackgroundColor = color
        return copied
    }
    
    /// Set the outline color of the magnifying glass
    public func outlineColor(_ color: Color) -> Self {
        var copied = self
        copied.outlineColor = color
        return copied
    }
    
    /// Set the outline width of the magnifying glass
    public func outlineWidth(_ width: CGFloat) -> Self {
        var copied = self
        copied.outlineWidth = width
        return copied
    }
    
    /// Enable or disable interactions in the magnifying glass
    ///
    /// If you disable interactions in the magnifying glass by `.enableHitInMagnifyingGlass(false)`,
    /// you can drag the whole magnifying glass to move instead of the border of it
    public func enableHitInMagnifyingGlass(_ enabled: Bool) -> Self {
        var copied = self
        copied.enableHitInMagnifyingGlass = enabled
        return copied
    }
    
    /// Enable or disable close button
    ///
    /// - note: you can customize your close button by disable this close button and
    /// control `isMagnifying` binding which was passed in the constructor
    public func enableCloseButton(_ enabled: Bool) -> Self {
        var copied = self
        copied.isShowingCloseButton = enabled
        return copied
    }
    
    /// Set the size of the close button
    public func closeButtonSize(_ size: CGSize) -> Self {
        var copied = self
        copied.closeButtonSize = size
        return copied
    }
    
    /// Set the foreground color of the close button
    public func closeButtonColor(_ color: Color) -> Self {
        var copied = self
        copied.closeButtonColor = color
        return copied
    }
}
