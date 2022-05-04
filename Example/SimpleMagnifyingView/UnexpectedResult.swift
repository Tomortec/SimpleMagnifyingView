//
//  UnexpectedResult.swift
//  SimpleMagnifyingView_Example
//
//  Created by Tomortec on 2022/5/2.
//  Copyright © 2022 Tomortec. All rights reserved.
//

import SwiftUI
import SimpleMagnifyingView

struct UnexpectedResult1: View {
    var body: some View {
        MagnifierView(isMagnifying: .constant(true)) {
            VStack {
                Text("Unexpected Result 1: Providing transparent background")
                    .padding()
                Text("Solution: \nProvide a `.frame(maxWidth: .infinity, maxHeight: .infinity).background(.white)` background (or other frame, but background is needed) for your views")
                    .padding()
            }
        }
        .enableCloseButton(false)
    }
}

struct UnexpectedResult2: View {
    var body: some View {
        MagnifierView(isMagnifying: .constant(true), scale: .constant(0.7)) {
            VStack {
                Text("Unexpected Result 2: Providing a small scale (less than 1.0)")
                    .padding()
                Text("Solution: \n`Clamp` your scale passed")
                    .padding()
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.cyan)
        }
        .outlineColor(.white)
        .enableCloseButton(false)
    }
}

struct UnexpectedResult3: View {
    var body: some View {
        MagnifierView(isMagnifying: .constant(true)) {
            VStack {
                Text("Unexpected Result 3: Close button not working")
                    .padding()
                Text("Solution: \nYou can either call `.enableCloseButton(false)` method to hide close button or provide a Bool binding for `isMagnifying`")
                    .padding()
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.cyan)
        }
        .outlineColor(.white)
        .closeButtonColor(.white)
    }
}
