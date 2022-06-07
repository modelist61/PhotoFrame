import SwiftUI

class ClockViewModel: ObservableObject {

    @Published var currentTime = TimeAnalog(sec: 15, min: 10, hour: 10)
    @Published var currentTime2 = TimeDigital(sec: 15, min: 3, hour: 10)
    @Published var currentDate = TimeDate(day: 1, month: 1, year: 2000)
    @Published var divider = " "
    @Published var date = ""

    var timer: Timer?
    var showDivider = true

    init() {
        getTimeComponents()
        getDate()
        timer = updateTimer()
    }

    private func updateTimer() -> Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.getTimeComponents()
            self.fastChangeDivider()
        }
    }

// MARK: - make divider fastest
    private func fastChangeDivider() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.changeDivider()
        }
        self.changeDivider()
    }

// MARK: - divider state changer
    private func changeDivider() {
        showDivider ? (divider = " ") : (divider = ":")
        showDivider.toggle()
    }

// MARK: - time data to time model
    private func getTimeComponents() {
        let calender = Calendar.current
        let date = Date()
        let sec = calender.component(.second, from: date)
        let min = calender.component(.minute, from: date)
        let hour = calender.component(.hour, from: date)
            currentTime2 = TimeDigital(sec: sec, min: min, hour: hour)
    }

// TODO: - make showing date
    private func getDate() {
        let calender = Calendar.current
        let day = calender.component(.day, from: Date())
        let month = calender.component(.month, from: Date())
        let year = calender.component(.year, from: Date())
            currentDate = TimeDate(day: day, month: month, year: year)
    }
}
