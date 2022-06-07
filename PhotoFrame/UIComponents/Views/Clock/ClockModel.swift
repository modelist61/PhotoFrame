import Foundation

struct TimeAnalog {
    var sec: Int
    var min: Int
    var hour: Int
}

struct TimeDigital {
    private var secInt, minInt, hourInt: Int
    var sec, min, hour: (first: String, second: String)

    init(sec: Int, min: Int, hour: Int) {
        secInt = sec
        minInt = min
        hourInt = hour
        self.sec = (first: "", second: "")
        self.min = (first: "", second: "")
        self.hour = (first: "", second: "")
        buildClockModel()
    }

    private mutating func buildClockModel() {
        self.sec = (
            first: (secInt < 10 ? "0" : "\(secInt / 10)"),
            second: "\(secInt % 10)"
        )

        self.min = (
            first: (minInt < 10 ? "0" : "\(minInt / 10)"),
            second: "\(minInt % 10)"
        )

        self.hour = (
            first: (hourInt < 10 ? "0" : "\(hourInt / 10)"),
            second: "\(hourInt % 10)"
        )
    }
}

struct TimeDate {
    private var dayInt, monthInt, yearInt: Int
    var day, month, year: String

    init (day: Int, month: Int, year: Int) {
        dayInt = day
        monthInt = month
        yearInt = year
        self.day = "\(day)"
        self.month = "\(month)"
        self.year = "\(year)"
        monthLocalize()
    }

    private mutating func monthLocalize() {
        switch monthInt {
        case 1: month = "Января"
        case 2: month = "Февраля"
        case 3: month = "Марта"
        case 4: month = "Апреля"
        case 5: month = "Мая"
        case 6: month = "Июня"
        case 7: month = "Июля"
        case 8: month = "Августа"
        case 9: month = "Сентября"
        case 10: month = "Октября"
        case 11: month = "Ноября"
        case 12: month = "Декабря"
        default:
            break
        }
    }
}
