//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Dmitry Sharabin on 26.01.2022.
//

import SwiftUI

struct User: Identifiable {
    var id = "Taylor Swift"
}

struct ContentView: View {
    @State private var selectedUser: User? = nil
    @State private var isShowingUser = false
    
    var body: some View {
        Text("Hello, world!")
            .onTapGesture {
                selectedUser = User()
                isShowingUser = true
            }
//            .sheet(item: $selectedUser) { user in
//                Text(user.id)
//            }
//            .alert("Welcome", isPresented: $isShowingUser, presenting: selectedUser) { user in
//                Button(user.id) { }
//            }
            .alert("Welcome", isPresented: $isShowingUser) { }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
