//
//  ContentView.swift
//  SimpleMagnifyingView_Example
//
//  Created by Tomortec on 2022/4/28.
//  Copyright © 2022 Tomortec. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        UINavigationBar.appearance().tintColor = .black
    }
    
    var body: some View {
        NavigationView {
            List {
                Section("Examples") {
                    NavigationLink("Simple Example", destination: SimpleExample().ignoresSafeArea())
                    NavigationLink("Complete Example", destination: CompleteExample().ignoresSafeArea())
                }
                
                Section("Unexpected Results") {
                    NavigationLink("Transparent Background", destination: UnexpectedResult1())
                    NavigationLink("Small Scale", destination: UnexpectedResult2())
                    NavigationLink("Not-working Close Button", destination: UnexpectedResult3())
                }
                
                Text("*For more details, please build and go to our documentation*")
            }
            .navigationTitle("Example")
        }
        .navigationViewStyle(.columns)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
