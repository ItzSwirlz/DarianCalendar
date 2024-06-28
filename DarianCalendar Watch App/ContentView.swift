//
//  ContentView.swift
//  DarianCalendar Watch App
//
//  Created by Joshua Peisach on 6/26/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        `TimelineView`(AnimationTimelineSchedule()) { context in
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            let mtc = MTC()
            Text(String(mtc.hours))
            Text(String(mtc.minutes))
            Text(String(mtc.seconds))
        }
    }
}

#Preview {
    ContentView()
}
