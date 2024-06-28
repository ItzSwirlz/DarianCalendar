//
//  ContentView.swift
//  DarianCalendar
//
//  Created by Joshua Peisach on 6/26/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            var mtc = MTC()
            Text(String(String(mtc.hours) + ":" + String(mtc.minutes) + ":" + String(mtc.seconds)))
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
