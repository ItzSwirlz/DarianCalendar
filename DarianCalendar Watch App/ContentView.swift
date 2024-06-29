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
            Text(String(mtc.seconds)) // FIXME: Seconds 0-9: have leading 0

            let cal = Calendar(msd: MSD())
            Text(String(format: "MSD: %f", MSD())) // for debugging
            Text(String(format: "Year: %d", cal.year))
            Text(String(cal.month.formatted)) // this is worng
            Text(String(cal.solOfMonth)) // also wrong
            Text(String(cal.currentSolName.formatted))

        }
    }
}

#Preview {
    ContentView()
}
