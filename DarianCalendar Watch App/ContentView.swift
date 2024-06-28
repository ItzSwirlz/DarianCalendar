//
//  ContentView.swift
//  DarianCalendar Watch App
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
            let mtc = MTC()
            Text(String(mtc.hours))
            Text(String(mtc.minutes))
            Text(String(mtc.seconds))
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
