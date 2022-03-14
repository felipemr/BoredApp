//
//  DetailView.swift
//  Bored App
//
//  Created by Felipe Marques Ramos on 3/11/22.
//

import SwiftUI

struct DetailView: View {

    var activity: Activity

    var body: some View {
        VStack{
            Text(activity.activity)
                .font(.largeTitle)
            Text(activity.type)
                .font(.headline)
            Text(activity.key)
                .font(.footnote)
            Text("\(activity.participants ?? 1)")
            Text("\(activity.price ?? 1)")
            Text(activity.link ?? "")
            Text("\(activity.accessibility ?? 1)")

        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(activity: Activity(activity: "Nice", type: "Recreational", participants: 1, price: 0.5, link: "Google.com", key: "00000", accessibility: 0.1))
    }
}
