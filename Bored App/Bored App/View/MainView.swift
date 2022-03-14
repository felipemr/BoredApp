//
//  ContentView.swift
//  Bored App
//
//  Created by Felipe Marques Ramos on 3/11/22.
//

import SwiftUI
import CoreData

struct MainView: View {

//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(entity: ActivityEntity.entity(), sortDescriptors: [], animation: .default) var activitiesItems: FetchedResults<ActivityEntity>

    @StateObject private var viewModel = MainViewModel()
    @State private var activities = [Activity]()
    @State private var showingSearch = false

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
                .onDelete(perform: viewModel.deleteActivity)
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
                            viewModel.addActivity(activity)
                        }
                        Button("Nope", role: .cancel) {}
                    } message: { activity in
                        Text(activity.activity)
                    }
                }
                ToolbarItem {
                    Button {
//                        showingSearch = true
                        addItem()
                    } label : {
                        Label("Add Item", systemImage: "plus.circle")
                    }
                    .sheet(isPresented: $showingSearch) {
                        SearchView()
                    }

                }
            }
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            viewModel.addNewRandomActivity()
//            let newAct = ActivityEntity(context: viewContext)
//            newAct.activity = "super new"
//            saveData()
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
