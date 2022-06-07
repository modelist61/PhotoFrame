import SwiftUI

struct InfoBlock: View {

    @ObservedObject private var clockViewModel = ClockViewModel()

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 270, height: 80)
                .foregroundColor(.gray.opacity(0.7))
                .shadow(radius: 4)

            HStack {
                WeatherView()

                Rectangle()
                    .frame(width: 1, height: 75)
                    .foregroundColor(.white.opacity(0.1))

                ClockView()
                    .padding(.bottom, 3)
            }
        }
    }
}

struct InfoBlock_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            // MARK: - background image
            Image("photo")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.container, edges: .vertical)
            
            InfoBlock()
        }
    }
}
