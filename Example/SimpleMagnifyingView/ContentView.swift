//
//  ContentView.swift
//  SimpleMagnifyingView_Example
//
//  Created by 李奥 on 2022/4/28.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI
import SimpleMagnifyingView

struct ContentView: View {
    
    @State var isShowingAlert = false
    @State var scale: CGFloat = 2.0
    @State var isMagnifying = true
    
    var body: some View {
        MagnifierView(isMagnifying: $isMagnifying, scale: $scale) {
            VStack {
                Text("Hello world")
                    .foregroundColor(.white)
                Text("Scale: \(scale)")
                Button("Enlarge") {
                    withAnimation {
                        scale += 0.1
                    }
                }
                Button("Reduce") {
                    withAnimation {
                        scale -= 0.1
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.cyan)
        }
        .outlineColor(.white)
        .closeButtonColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
