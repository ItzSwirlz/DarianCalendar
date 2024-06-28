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

            Text(String(format: "Year: %.f", ((MSD() / 668.59) + 140))) // FIXME: handle years properly

            // FIXME: These are probably wrong. Some months have 28 days, some have 27. Probably best to find a better way to handle this. Also, if the MSD's number is divisible by 24 it will screw everything up... so figure this all out.
            Text(String(format: "Month No. (Wrong): %.f", (((MSD().truncatingRemainder(dividingBy: 24.0))))))
            Text(String(format: "Sol No. (Wrong): %.f", (MSD().truncatingRemainder(dividingBy: 27.8579))))

        }
    }
}

#Preview {
    ContentView()
}
