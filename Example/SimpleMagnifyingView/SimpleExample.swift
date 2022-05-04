//
//  SimpleExample.swift
//  SimpleMagnifyingView_Example
//
//  Created by Tomortec on 2022/5/4.
//  Copyright © 2022 Tomortec. All rights reserved.
//

import SwiftUI

import SimpleMagnifyingView

struct SimpleExample: View {
    @State var isMagnifying = true
    
    var body: some View {
        MagnifierView(isMagnifying: $isMagnifying, scale: .constant(1.8)) {
            Text("Hello world")
                .foregroundColor(.white)
                // README: transparent background will cause unexpected results
                // please have a look at our `UnexpectedResult1`
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.cyan)
        }
        .outlineColor(.white)
        .closeButtonColor(.white)
    }
}

struct SimpleExamplePreviews: PreviewProvider {
    static var previews: some View {
        SimpleExample()
    }
}
