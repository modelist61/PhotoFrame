import SwiftUI
import Combine

class GestureViewModel: ObservableObject {
    private let screen = ScreenSize()
    private var cancellableSet = Set<AnyCancellable>()

    @AppStorage("scale") var savedScale = 1.0
    @AppStorage("offSetX") var offSetX = 0.0
    @AppStorage("offSetY") var offSetY = 0.0

    @Published var zoomScale = ZoomModel()
    @Published var position = PositionModel()
    @Published var isPressedDown = false

// MARK: - Initializer

    init() {
        loadState()
        isPressingSink($isPressedDown)
        zoomSink($zoomScale)
    }

    // MARK: - Methods

    func offSet(drag: CGSize) {
        let width = position.newPosition.width + drag.width
        let height = position.newPosition.height + drag.height
        let outOfBoundWidth = offSetBound(
            dragState: width,
            correct: 135,
            maxSize: screen.x,
            scale: zoomScale.scale
        )
        let outOfBoundHeight = offSetBound(
            dragState: height,
            correct: 50,
            maxSize: screen.y,
            scale: zoomScale.scale
        )
        
        position.offSet = .init(
            width: outOfBoundWidth,
            height: outOfBoundHeight
        )
    }

    private func offSetBound(
        dragState: CGFloat,
        correct: CGFloat,
        maxSize: CGFloat,
        scale: CGFloat
    ) -> CGFloat {
        if dragState > 0 {
            return min(dragState, (maxSize / 2) - (correct * scale) )
        } else {
            return -min(abs(dragState), (maxSize / 2) - (correct * scale))
        }
    }

    private func saveState() {
        offSetY = position.offSet.height
        offSetX = position.offSet.width
        print("SAVE POSITION")
    }

    private func loadState() {
        zoomScale.finalAmount = savedScale
        position.offSet.height = offSetY
        position.offSet.width = offSetX
        position.newPosition.height = offSetY
        position.newPosition.width = offSetX
        print("LOAD")
    }

    private func tapAnimation(_ tap: Bool) {
        if tap {
            withAnimation(Animation.spring()) {
                zoomScale.currentAmount -= 0.1
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation(Animation.spring()) {
                        self.zoomScale.currentAmount += 0.2
                    }
                }
            }
        } else {
            withAnimation(Animation.spring()) {
                zoomScale.currentAmount -= 0.1
            }
        }
    }

    private func isPressingSink(_ press: Published<Bool>.Publisher) {
        press
            .sink { pressing in
                if !pressing {
                    self.saveState()
                }
                    self.tapAnimation(pressing)
            }
            .store(in: &cancellableSet)
    }

    private func zoomSink(_ scale: Published<ZoomModel>.Publisher) {
        scale
            .sink { zoom in
                if zoom.scale != self.savedScale {
                    self.savedScale = self.zoomScale.scale
                    print("SAVE SCALE")
                }
            }
            .store(in: &cancellableSet)
    }
}
