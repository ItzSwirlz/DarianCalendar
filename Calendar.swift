//
//  Calendar.swift
//  DarianCalendar
//
//  Created by Joshua Peisach on 6/28/24.
//

import Foundation

public enum Month {
    case Sagittarius, Dhanus, Capricornus, Makara, Aquarius, Khumba, Pisces, Mina, Aries, Mesha, Taurus, Rishabha, Gemini, Mithuna, Cancer, Karka, Leo, Simha,
    Virgo, Kanya, Libra, Tula, Scorpius, Vrishika

    var formatted: String {
        return String(describing: self)
    }
}

enum Sol {
    case Solis, Lunae, Martis, Mercurii, Jovis, Veneris, Saturni

    var formatted: String {
        return String(describing: self)
    }
}

// TODO: check
private func IsLeapYear(year: Int) -> Bool {
    if(year % 500 == 0) {
        return true;
    } else if(year % 100 == 0) {
        return false;
    } else if(year % 10 == 0) {
        return true;
    } else if(year % 2 == 0) {
        return false;
    }
    return true;
}

private func GetMonth(leapYear: Bool, msd: Int) -> Month {
    var temp = msd


    // TODO: someone teach me lookup tables
    if(0 <= temp && temp <= 28) {
        return Month.Sagittarius
    } else if(29 <= temp && temp <= 56) {
        return Month.Dhanus
    } else if(57 <= temp && temp <= 84) {
        return Month.Capricornus
    } else if(85 <= temp && temp <= 112) {
        return Month.Makara
    } else if(113 <= temp && temp <= 140) {
        return Month.Aquarius
    } else if(141 <= temp && temp <= 167) { // End of season. 27 sols.
        return Month.Khumba
    } else if(168 <= temp && temp <= 195) {
        return Month.Pisces
    } else if(196 <= temp && temp <= 223) {
        return Month.Mina
    } else if(224 <= temp && temp <= 251) {
        return Month.Aries
    } else if(252 <= temp && temp <= 279) {
        return Month.Mesha
    } else if(280 <= temp && temp <= 307) {
        return Month.Taurus
    } else if(308 <= temp && temp <= 334) { // End of season. 27 sols.
        return Month.Rishabha
    } else if(335 <= temp && temp <= 362) {
        return Month.Gemini
    } else if(363 <= temp && temp <= 390) {
        return Month.Mithuna
    } else if(391 <= temp && temp <= 418) {
        return Month.Cancer
    } else if(419 <= temp && temp <= 446) {
        return Month.Karka
    } else if(447 <= temp && temp <= 474) {
        return Month.Leo
    } else if(475 <= temp && temp <= 501) { // End of season. 27 sols.
        return Month.Simha
    } else if(502 <= temp && temp <= 529) {
        return Month.Virgo
    } else if(530 <= temp && temp <= 557) {
        return Month.Kanya
    } else if(558 <= temp && temp <= 585) {
        return Month.Libra
    } else if(586 <= temp && temp <= 613) {
        return Month.Tula
    } else if(614 <= temp && temp <= 641) {
        return Month.Scorpius
    } else {
        return Month.Vrishika // this will work weather it is a leap year ot not
    }
}

// FIXME: This is wrong
private func GetSolOfMonth(leapYear: Bool, month: Month, msd: Int) -> Int {
    var temp = msd

    if(month == Month.Khumba || month == Month.Rishabha || month == Month.Simha || ((leapYear == true) && month == Month.Vrishika)) {
        // 27-sol months
        temp %= 27
    } else {
        temp %= 28
    }

    return temp
}

private func GetSolName(leapYear: Bool, solMonth: Int) -> Sol {
    switch(solMonth % 7) {
    case 0:
        return Sol.Solis
    case 1:
        return Sol.Lunae
    case 2:
        return Sol.Martis
    case 3:
        return Sol.Mercurii
    case 4:
        return Sol.Jovis
    case 5:
        return Sol.Veneris
    case 6:
        return Sol.Saturni
    default:
        return Sol.Solis
    }
}


struct Calendar {
    public var solNum: Int
    public var year: Int
    public var month: Month
    public var solOfMonth: Int
    public var currentSolName: Sol
    
    init(msd: Double) {
        // JD calculation from AI
        let date = Date()
        let calendar = Foundation.Calendar(identifier: .gregorian)
        let y = calendar.component(.year, from: date)
        let m = calendar.component(.month, from: date)
        let d = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let second = calendar.component(.second, from: date)
            
        var Y = y
        var M = m
        if M <= 2 {
            Y -= 1
            M += 12
        }
    
        let A = Y / 100
        let B = 2 - A + A / 4
        let JD0 = Double(Int(365.25 * Double(Y + 4716))) + Double(Int(30.6001 * Double(M + 1))) + Double(d) + Double(B) - 1524.5
        let fractionOfDay = (Double(hour) + Double(minute) / 60.0 + Double(second) / 3600.0) / 24.0
        let JD = JD0 + fractionOfDay
        // End of AI code

        // julian sol
        let JS = (JD - 2308806.30493) / 1.027491251
        let sol = JS.truncatingRemainder(dividingBy: 668.5907).rounded(.up) // FIXME: check if its safe to round up or not
        solNum = Int(sol)
        year = Int(JS / 668.5907)
    
        let isLeapYear = IsLeapYear(year: year)
        month = GetMonth(leapYear: isLeapYear, msd: solNum)
        solOfMonth = GetSolOfMonth(leapYear: isLeapYear, month: month, msd: solNum)
        currentSolName = GetSolName(leapYear: isLeapYear, solMonth: solOfMonth)
    }
}
