//
//  MarsTime.swift
//  DarianCalendar
//
//  Created by Joshua Peisach on 6/26/24.
//

// Reference: https://www.giss.nasa.gov/tools/mars24/help/algorithm.html, http://marsclock.com
// If you're reading this, these calculations may be wrong
// so dont rely on it.


import Foundation

// im lazy
// https://www.hackingwithswift.com/example-code/language/how-to-convert-radians-to-degrees
func rad2deg(_ number: Double) -> Double {
    return number * 180.0 / .pi
}

func MSD() -> Double {
    // --- Determine Days Since J2K Epoch ---
    let UnixEpoch = Date.now.timeIntervalSince1970 * 1000 // A-1 - we need this in miliseconds
    let JulianDateUT = 2440587.5 + (UnixEpoch / 86400000.0) // A-2. 2440587.5 is a known offset for 00:00:00 on 1/1/1970
    
    // We will not be handling dates before Jan 1, 1972, so we can skip A-3

    let UTCToTTConversion = 32.184 + 37.0 // A-4 - 32.184 is constant. Atomic time is currently 37 seconds ahead (TODO: Check up on this)
    let JulianDateTT = JulianDateUT + ((UTCToTTConversion) / 86400.0) // A-5

    let TimeOffsetFromJ2K = JulianDateTT - 2451545.0 // A-6 - this is in days

    // --- Determine Days Since J2K Epoch ---


    // We don't need the other mars parameters, just MSD and we can go forward.
    return ((TimeOffsetFromJ2K - 4.5) / 1.0274912517) + 44796.0 - 0.00096
}

func MTC() -> Double {
    return (24.0 * MSD()).truncatingRemainder(dividingBy: 24.0)
}
