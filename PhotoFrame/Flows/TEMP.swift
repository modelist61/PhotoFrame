import SwiftUI

struct TEMP: View {

    @ObservedObject private var clockViewModel = ClockViewModel()

    @State private var imageUrl = URL(string: "https://picsum.photos/800/1000")
    @State private var refreshToggle = true
    @State private var showProgressView = true

    var body: some View {
            ZStack {
                // MARK: - background image
//                Image("photo")
//                    .resizable()
//                    .scaledToFill()
//                    .ignoresSafeArea(.container, edges: .vertical)

                if refreshToggle {
                    AsyncImage(url: imageUrl) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .ignoresSafeArea(.container, edges: .vertical)
                    } placeholder: {
                        ProgressView()
                            .scaleEffect(3)
                            .opacity(showProgressView ? 1.0 : 0.0)
                    }
                    .transition(.opacity.animation(.easeInOut(duration: 3)))
                } else {
                    AsyncImage(url: imageUrl) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .ignoresSafeArea(.container, edges: .vertical)
                    } placeholder: {
                        ProgressView()
                            .scaleEffect(3)
                            .opacity(showProgressView ? 1.0 : 0.0)
                    }
                    .transition(.opacity.animation(.easeInOut(duration: 3)))
                    .onAppear {
                        showProgressView = false
                    }
                }

                InfoBlock()
//                    .modifier(InfoBlockGestureOLD())
                    .modifier(InfoBlockGesture())
            }
            .onChange(of: clockViewModel.currentTime2.sec.first) { _ in
                    refreshToggle.toggle()
            }
            .onAppear {
                if UIDevice.isIPad {
                    imageUrl = URL(string: "https://picsum.photos/1200/1500")
                } 
            }
    }
}

struct TEMPClockView_Previews: PreviewProvider {
    static var previews: some View {
        TEMP()
    }
}


//MARK: Extension detect device
extension UIDevice {
    static var isIPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }

    static var isIPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
}
// Use UIDevice.isIPad or UIDevice.isIPhone
