//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Dmitry Sharabin on 26.01.2022.
//

import SwiftUI

extension View {
    @ViewBuilder func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}

enum SortOrder {
    case none, alphabetical, country
}

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @StateObject var favorites = Favorites()
    @State private var searchText = ""
    
    @State private var sortOrder: SortOrder = .none
    @State private var showingSortOrderDialog = false
    
    var body: some View {
        NavigationView {
            List(filteredResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 5)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                Button {
                    showingSortOrderDialog = true
                } label: {
                    Label("Sort resorts", systemImage: "arrow.up.arrow.down")
                }
            }
            .confirmationDialog("Choose sort order", isPresented: $showingSortOrderDialog, titleVisibility: .visible) {
                Button("Default") { sortOrder = .none }
                Button("Alphabetical") { sortOrder = .alphabetical }
                Button("Country") { sortOrder = .country }
                
                Button("Cancel", role: .cancel) { }
            }
            
            WelcomeView()
        }
        .environmentObject(favorites)
        //.phoneOnlyStackNavigationView()
    }
    
    var sortedResorts: [Resort] {
        switch sortOrder {
            case .none:
                return resorts
            case .alphabetical:
                return resorts.sorted()
            case .country:
                return resorts.sorted { $0.country < $1.country }
        }
    }
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return sortedResorts
        } else {
            return sortedResorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
