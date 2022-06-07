import SwiftUI
import CoreLocationUI

struct WeatherView: View {
    // MARK: - Properties

    @StateObject var locationManager = LocationManager()
    @State var weather: ResponseBody?
    var weatherManager = NetworkManager()

    // MARK: - UI

    var body: some View {
        VStack {

            // DEBUG
            //                weatherStack(
            //                    title: "Таганрог",
            //                    temp: 44,
            //                    description: "thunderstorm with light rain",
            //                    wind: 12,
            //                    humidity: 75,
            //                    imageId: "10d"
            //                )
            // DEBUG end

            if let location = locationManager.location {
                if let weather = weather {
                    VStack {
                        weatherStack(
                            title: weather.name,
                            temp: weather.main.temp,
                            description: weather.weather[0].description,
                            wind: weather.wind.speed,
                            humidity: weather.main.humidity,
                            imageId: weather.weather[0].icon
                        )
                    }
                    .onAppear {
                        locationManager.manager.stopUpdatingLocation()
                    }
                } else {
                    progressView(size: 70)
                        .task {
                            do {
                                weather = try await
                                weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                            } catch {
                                print("Error getting weather: \(error)")
                            }
                        }
                }
            }
        }// end VStack
        .frame(width: 70, height: 78)
    }

    // MARK: - UI Components

    private func weatherStack(
        title: String,
        temp: Double,
        description: String,
        wind: Double,
        humidity: Double,
        imageId: String
    ) -> some View {
        VStack(spacing: 3) {
            Text(title)
                .font(Font.system(size: 9))
                .foregroundColor(.white)

            temperatureStack(
                value: temp,
                imageId: imageId
            )

            HStack(spacing: 0) {
                smallInfoStack(value: humidity, mark: "%")

                Rectangle()
                    .foregroundColor(.white.opacity(0.1))
                    .frame(width: 1, height: 14)

                smallInfoStack(value: wind, mark: "м/с")
            }// end HSTack

            Text(description)
                .font(Font.system(size: 7))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }// end VSTack
    }

    private func temperatureStack(value: Double, imageId: String) -> some View {
        HStack(spacing: 0) {
            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(imageId)@2x.png")) { image in
                image
                    .resizable()
                    .frame(width: 35, height: 35)

            } placeholder: {
                progressView(size: 7)
                    .frame(width: 35)
            }// end AsyncImage

            Text("\(value.roundDouble())" + "°")
                .bold()
                .font(Font.system(size: 20))
                .foregroundColor(.white)
                .frame(width: 35)
        }// end HSTack
        .frame(width: 70, height: 20)
    }

    private func smallInfoStack(value: Double, mark: String) -> some View {
        HStack(alignment: .bottom, spacing: 2) {
            Text("\(value.roundDouble())")
                .bold()
                .font(Font.system(size: 13))
                .foregroundColor(.white)

            Text(mark)
                .bold()
                .font(Font.system(size: 8))
                .foregroundColor(.white)
        }
        .frame(width: 35)
    }

    private func progressView(size: CGFloat) -> some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .white))
            .frame(width: size, height: size)
            .opacity(0.5)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 80, height: 80)
                .foregroundColor(.gray.opacity(0.7))
                .shadow(radius: 4)

            WeatherView()
        }.scaleEffect(2)
    }
}
