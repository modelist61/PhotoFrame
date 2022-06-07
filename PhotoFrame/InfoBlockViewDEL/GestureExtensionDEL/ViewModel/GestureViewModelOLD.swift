import SwiftUI
import Combine

class GestureViewModelOLD: ObservableObject {

    @Published var zoomScale = ZoomGestureModel()
    @Published var pressDuration = LongPressModel()

    @Published var scale: CGFloat = 1.0

    @Published var viewState = CGSize.zero
    @GestureState var dragState = DragStateOLD.inactive

    let screen = ScreenSize()

    @AppStorage("scaleOLD") var savedScale = 1.0
    @AppStorage("positionXOLD") var savedX = 0.0
    @AppStorage("positionYOLD") var savedY = 0.0

    init() {
        loadSavedState()
    }


    func savePosition() {
        savedScale = zoomScale.scale
        savedX = viewState.width
        savedY = viewState.height
        print("SAVE")
    }


    func offSetBound(dragState: CGFloat, correct: CGFloat, maxSize: CGFloat, scale: CGFloat) -> CGFloat {
        var position = 0.0
        if dragState > 0 {
            position = min(dragState, (maxSize / 2) - (correct * scale) )
        } else {
            position = -min(abs(dragState), (maxSize / 2) - (correct * scale))
        }
        return position
    }

    func loadSavedState() {
        zoomScale.finalAmount = savedScale
        viewState = CGSize(width: savedX, height: savedY)
        print("LOAD")
    }

    func updateViewState() {
        viewState = .init(
            width: viewState.width + dragState.translation.width,
            height: viewState.height + dragState.translation.height
        )

    }
}
