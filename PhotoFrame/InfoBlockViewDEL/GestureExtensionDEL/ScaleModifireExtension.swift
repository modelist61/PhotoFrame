
import SwiftUI

// MARK: - Scale Gesture

extension InfoBlockGestureOLD {

    var magnification: some Gesture {
        MagnificationGesture(minimumScaleDelta: 0.1)
            .onChanged { amount in
                withAnimation {
                    vm.zoomScale.currentAmount = amount - 1
                }
            }
            .onEnded { amount in
                vm.zoomScale.finalAmount += vm.zoomScale.currentAmount
                vm.zoomScale.currentAmount = 0
            }
    }
}
