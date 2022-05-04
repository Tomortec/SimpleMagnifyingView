//
//  UnexpectedResult.swift
//  SimpleMagnifyingView_Example
//
//  Created by 李奥 on 2022/5/2.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI
import SimpleMagnifyingView

struct UnexpectedResult1: View {
    var body: some View {
        MagnifierView(isMagnifying: .constant(true)) {
            VStack {
                Text("Unexpected Result 1: Providing transparent background")
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
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.cyan)
        }
        .outlineColor(.white)
        .enableCloseButton(false)
    }
}

struct Previews: PreviewProvider {
    static var previews: some View {
        UnexpectedResult1()
    }
}
