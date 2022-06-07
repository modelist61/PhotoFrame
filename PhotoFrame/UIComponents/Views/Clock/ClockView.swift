//
//  ClockView.swift
import SwiftUI

struct ClockView: View {

    @StateObject private var clockViewModel = ClockViewModel()

    var body: some View {
        VStack(alignment: .trailing, spacing: 7) {
            DigitalClockBlock(viewModel: clockViewModel)
            DateBlock(viewModel: clockViewModel)
        }
        .frame(alignment: .trailing)
    }

@ViewBuilder
// MARK: Full Clock Block

    private func DigitalClockBlock(viewModel: ClockViewModel) -> some View {
        HStack(spacing: 5) {
            // MARK: - Hours
            ClockBlock(
                first: viewModel.currentTime2.hour.first,
                second: viewModel.currentTime2.hour.second,
                width: 18
            )

            // MARK: - Static DIVIDER
            DynamicDivider(width: 10)

            // MARK: - Minutes
            ClockBlock(
                first: viewModel.currentTime2.min.first,
                second: viewModel.currentTime2.min.second,
                width: 18
            )

            // MARK: - Dynamic DIVIDER
            DynamicDivider(divider: viewModel.divider, width: 10)

            // MARK: - Seconds
            ClockBlock(
                first: viewModel.currentTime2.sec.first,
                second: viewModel.currentTime2.sec.second,
                width: 18
            )
        }// end HStack
    }

// MARK: Clock Block consist two numbers

    private func ClockBlock(first: String, second: String, width: CGFloat) -> some View {
        HStack(spacing: 3) {
            Text("\(first)")
                .frame(width: width, alignment: .center)
            Text("\(second)")
                .frame(width: width, alignment: .center)
        }
        .font(Font.title.bold())
        .foregroundColor(.white)
    }

// MARK: Dynamic Divider :

    private func DynamicDivider(divider: String = ":", width: CGFloat) -> some View {
        Text("\(divider)")
            .frame(width: width, alignment: .center)
            .font(Font.title.bold())
            .foregroundColor(.white)
    }

// MARK: Date Block

    private func DateBlock(viewModel: ClockViewModel) -> some View {
        HStack {
            Text(viewModel.currentDate.day)
            Text(viewModel.currentDate.month)
            Text(viewModel.currentDate.year)
        }
        .foregroundColor(.white)
        .font(.callout)
    }
}

struct ClockView_Previews: PreviewProvider {

    static var previews: some View {
        ZStack {
            // MARK: - background image
            Image("photo")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.container, edges: .vertical)
            
            // MARK: - temporary zstack
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(.gray)
                    .shadow(radius: 5)
                    .opacity(0.7)

                ClockView()
            }
            .frame(height: 80)
            .scaleEffect(1.0)
        }
    }
}
