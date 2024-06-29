//
//  Calendar.swift
//  DarianCalendar
//
//  Created by Joshua Peisach on 6/28/24.
//

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
    var temp = msd % 668
    if(leapYear == true) {
        temp = msd % 669
    }

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

private func GetSolOfMonth(leapYear: Bool, month: Month, msd: Int) -> Int {
    var temp = msd % 668
    if(leapYear == true) {
        temp = msd % 669
    }

    if(month == Month.Khumba || month == Month.Rishabha || month == Month.Simha || (leapYear == true) && month == Month.Vrishika) {
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
    default:
        return Sol.Saturni
    }
}


struct Calendar {
    public var year: Int
    public var month: Month
    public var solOfMonth: Int
    public var currentSolName: Sol
    
    init(msd: Double) {
        // TODO: Depending on leap years there may be edge case conditions where this is wrong.
        // TODO: What is the epoch? For now, offset by 140
        year = 140 + Int(msd / 668.5907)
        let isLeapYear = IsLeapYear(year: year)
        month = GetMonth(leapYear: isLeapYear, msd: Int(msd)) // TODO: This is wrong. From the number of days that have passed how do we get the nth day of the year?
        solOfMonth = GetSolOfMonth(leapYear: isLeapYear, month: month, msd: Int(msd))
        currentSolName = GetSolName(leapYear: isLeapYear, solMonth: solOfMonth)
    }
}
