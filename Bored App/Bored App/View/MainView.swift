//
//  ContentView.swift
//  Bored App
//
//  Created by Felipe Marques Ramos on 3/11/22.
//

import SwiftUI
import CoreData

struct MainView: View {

    @StateObject private var viewModel = MainViewModel()
    @State private var activities = [Activity]()
//    @State private var showingRandomAlert = false
//    @State private var randomActivity: Activity?

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.activities, id: \.key) { item in
                    NavigationLink {
                        Text("\(item.activity)")
                    } label: {
                        Text("\(item.activity)")
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button{
                        viewModel.getNewRandomActivity()
                    } label: {
                        Label("Random Item", systemImage: "dice")
                    }
                    .alert("Add this activity?", isPresented: $viewModel.requestIsLoaded, presenting: viewModel.randomAcitivity) { activity in
                        Button("Sure", role: .none) {
                            print(activity)
                        }
                        Button("Nope", role: .cancel) {
                            print(activity)
                        }
                    } message: { activity in
                        Text(activity.activity)
                        Text("UIA")
                    }
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus.circle")
                    }
                }
            }
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            viewModel.addNewRandomActivity()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
