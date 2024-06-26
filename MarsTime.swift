//
//  MarsTime.swift
//  DarianCalendar
//
//  Created by Joshua Peisach on 6/26/24.
//

// Reference: https://www.giss.nasa.gov/tools/mars24/help/algorithm.html
// If you're reading this, these calculations may be wrong
// so dont rely on it.


import Foundation

// im lazy
// https://www.hackingwithswift.com/example-code/language/how-to-convert-radians-to-degrees
func rad2deg(_ number: Double) -> Double {
    return number * 180 / .pi
}

func Equations() -> Double {
    // --- Determine Days Since J2K Epoch ---
    let UnixEpoch = Date.now.timeIntervalSince1970 // A-1
    let JulianDateUT = 2440587.5 + (UnixEpoch / 86400000) // A-2. 2440587.5 is a known offset for 00:00:00 on 1/1/1970
    
    // We will not be handling dates before Jan 1, 1972, so we can skip A-3

    let UTCToTTConversion = 32.184 + 37.0 // A-4 - 32.184 is constant. Atomic time is currently 37 seconds ahead (TODO: Check up on this)
    let JulianDateTT = JulianDateUT + ((UTCToTTConversion) / 86400) // A-5

    let TimeOffsetFromJ2K = JulianDateTT - 2451545.0 // A-6
    // --- Determine Days Since J2K Epoch ---

    // --- Determine Mars Params of Date ---
    // We need these later
    let MeanAnomaly = 19.3871 + 0.52402073 * TimeOffsetFromJ2K // B-1
    let AngleFictionMeanSun = 270.3871 + 0.524038496 * TimeOffsetFromJ2K // B-2
    
    // B-3: Pertubers (Accounting for orbit variation)
    // This is a summation. Let's walk through this step by step.

    // Variable Initialization
    var PBS = 0.0
    var Ai = 0.0
    var Ti = 0.0
    var Phi = 0.0

    // The summation:
    for i in 1...7 {
        // There is a table of values we need to refer to. Stay calm.
        switch i {
        case 1:
            Ai = 0.0071
            Ti = 2.2353
            Phi = 49.409
            break
        case 2:
            Ai = 0.0057
            Ti = 2.7543
            Phi = 168.173
            break
        case 3:
            Ai = 0.0039
            Ti = 1.1177
            Phi = 191.837
            break
        case 4:
            Ai = 0.0037
            Ti = 15.7866
            Phi = 21.736
            break
        case 5:
            Ai = 0.0021
            Ti = 2.1354
            Phi = 15.704
            break
        case 6:
            Ai = 0.0020
            Ti = 2.4694
            Phi = 95.528
            break
        default: // case 7
            Ai = 0.0018
            Ti = 32.8493
            Phi = 49.095
            break
        }
        
        PBS = PBS + Ai * rad2deg(cos(((360 / 365.25) * TimeOffsetFromJ2K / Ti) + Phi)) // 360 / 365.25 = 0.985626
    }

    let EquationOfCenter = (10.691 + 0.0000003 * TimeOffsetFromJ2K) * rad2deg(sin(MeanAnomaly)) + 0.623 * rad2deg(sin(2 * MeanAnomaly)) + 0.050 * rad2deg(sin(3 * MeanAnomaly)) + 0.005 * rad2deg(sin(4 * MeanAnomaly)) + 0.0005 * rad2deg(sin((5 * MeanAnomaly))) + PBS // B-4

    let AreocentricSolarLongitude = AngleFictionMeanSun + EquationOfCenter // B-5

    // --- Determine Mars Params of Date ---
    
    // Finally,
    // --- Determine Mars Time ---
    let EOT = 2.861 * rad2deg(sin(2 * AreocentricSolarLongitude - 0.071)) * rad2deg(sin(4 * AreocentricSolarLongitude + 0.002)) * rad2deg(sin(6 * AreocentricSolarLongitude - EquationOfCenter)) // TODO: Check this. C-1
    // EOT is in degrees. "Multiply by (24 h / 360°) = (1 h / 15°) to obtain the result in hours."

    let a = ((JulianDateTT - 2451549.5) / 1.0274912517) + 44796.0 - 0.0009626
    let MST = ((24 * a)).truncatingRemainder(dividingBy: 24.0) // lets hope this works
    
    return AreocentricSolarLongitude
}
