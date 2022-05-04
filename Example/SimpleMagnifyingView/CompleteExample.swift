//
//  CompleteExample.swift
//  SimpleMagnifyingView_Example
//
//  Created by Tomortec on 2022/5/4.
//  Copyright © 2022 Tomortec. All rights reserved.
//

import SwiftUI

import SimpleMagnifyingView

struct CompleteExample: View {
    
    @State var isMagnifying: Bool = true
    @State var scale: CGFloat = 2.0
    
    var body: some View {
        MagnifierView(isMagnifying: $isMagnifying, scale: $scale) {
            VStack {
                Text("Complete Example")
                Image(systemName: "heart.fill")
                    .resizable()
                    .frame(width: 50.0, height: 50.0)
                
                HStack(spacing: 30.0) {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 30.0, height: 30.0)
                        .onTapGesture {
                            withAnimation {
                                isMagnifying.toggle()
                            }
                        }
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 30.0, height: 30.0)
                        .onTapGesture {
                            withAnimation {
                                scale += 0.2
                            }
                        }
                    Image(systemName: "minus.circle.fill")
                        .resizable()
                        .frame(width: 30.0, height: 30.0)
                        .onTapGesture {
                            withAnimation {
                                scale -= 0.2
                                if scale < 1.0 {
                                    scale = 1.0
                                }
                            }
                        }
                }
                .offset(x: 0.0, y: 200.0)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.cyan)
        }
        .magnifyingGlassSize(CGSize(width: 300.0, height: 250.0))
        .magnifyingGlassShape(AnyShape(Rectangle()))
        .handleHeight(0.0)
        .maskBackgroundColor(.black.opacity(0.2))
        .outlineColor(.white)
        .outlineWidth(7.0)
        .enableCloseButton(false)
    }
}

struct CompleteExamplePreviews: PreviewProvider {
    static var previews: some View {
        CompleteExample()
    }
}
