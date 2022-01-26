//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Dmitry Sharabin on 26.01.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        NavigationView {
//            Text("Hello, world!")
//                .navigationTitle("Primary")
//
//            Text("Secondary")
//        }
        
        NavigationView {
            NavigationLink {
                Text("New secondary")
            } label: {
                Text("Hello, world!")
            }
            .navigationTitle("Primary")
            
            Text("Secondary")
            
            Text("Tertiary")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
