
import SwiftUI

// MARK: - Drag Gesture

extension InfoBlockGestureOLD {

    var longPressDrag: some Gesture {
        LongPressGesture(minimumDuration: vm.pressDuration.duration)
            .sequenced(before: DragGesture())
            .updating($dragState) { value, state, transaction in //vm
                switch value {
                case .first(true):
                    state = .pressing
                case .second(true, let drag):
                    state = .dragging(translation: drag?.translation ?? .zero)
                default:
                    state = .inactive
                }
            }
            .onEnded { value in
                guard case .second(true, let drag?) = value else { return }
                self.vm.viewState.width += drag.translation.width //vm
                self.vm.viewState.height += drag.translation.height //vm
            }
    }
}
