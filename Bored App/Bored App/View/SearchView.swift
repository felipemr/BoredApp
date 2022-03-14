//
//  SearchView.swift
//  Bored App
//
//  Created by Felipe Marques Ramos on 3/11/22.
//

import SwiftUI

//"""
//accessibility
//
//A factor describing how possible an event is to do with zero being the most accessible
//

//
//type
//
//Type of the activity
//
//["education", "recreational", "social", "diy", "charity", "cooking", "relaxation", "music", "busywork"]
//
//participants
//
//The number of people that this activity could involve
//

//
//price
//
//A factor describing the cost of the event with zero being free
//

//"""

struct SearchView: View {

    @StateObject private var viewModel = SearchViewModel()

    @State private var activityTypes = ["education", "recreational", "social", "diy", "charity", "cooking", "relaxation", "music", "busywork"]
    @State private var selectedType = 0

    @State private var accessibility = 0.0 //[0.0, 1.0]
    @State private var participants = 0 //[0, n]
    @State private var price = 0.0 //[0, 1]

    @FocusState private var participantsIsFocused: Bool
    let numberFormat: IntegerFormatStyle<Int> = .number

    @State private var currentActivity: Activity?

    var body: some View {
        VStack {
            Form {
                Section {
                    HStack {
                        Text("Activity Type")
                        Picker("Activity Type", selection: $selectedType) {
                            ForEach(activityTypes, id: \.self) { activityType in
                                Text(activityType)
                            }
                        }
                        .pickerStyle(.menu)
                    }

                    HStack {
                        Text("Accessibility")
                        Slider(value: $accessibility, in: 0...1) {
                            Text("$accessibility")
                        } minimumValueLabel: {
                            Text("Full")
                        } maximumValueLabel: {
                            Text("None")
                        }
                    }


                    HStack {
                        Text("Participants")
                        TextField("Participants", value: $participants, format: numberFormat)
                            .keyboardType(.numberPad)
                            .focused($participantsIsFocused)
                    }


                    HStack {
                        Text("Price")
                        Slider(value: $price, in: 0...1) {
                            Text("Price")
                        } minimumValueLabel: {
                            Text("$")
                        } maximumValueLabel: {
                            Text("$$$")
                        }
                    }

                } header: {
                    Text("Filters")
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        participantsIsFocused = false
                    }
                }
            }

            Button{
                search()
            } label: {
                Image(systemName: "magnifyingglass.circle")
            }
            Spacer()
            Text(viewModel.filteredActivity?.activity ?? "Search")
            Spacer()
        }
    }

    private func search(){
        var filters = [String:String]()

        filters["accessibility"] = "\(accessibility)"
        filters["type"] = activityTypes[selectedType]
        filters["participants"] = "\(participants)"
        filters["price"] = "\(price)"

        viewModel.getNewFilteredActivity(with: filters)
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
