import SwiftUI

// MARK: - Model

struct ZoomGestureModel {
    let maxScale = 5.0
    let minScale = 0.5
    let normalMin = 1.0
    let normalMax = 2.0

    var currentAmount = 0.0
    var finalAmount = 1.0
    var scale: CGFloat {
        currentAmount + finalAmount
    }
}

struct LongPressModel {
    let duration = 0.3
}

//struct ScreenSize {
//    var y = UIScreen.main.bounds.height
//    var x = UIScreen.main.bounds.width
//}

enum DragStateOLD {
    case inactive
    case pressing
    case dragging(translation: CGSize)

    var translation: CGSize {
        switch self {
        case .inactive, .pressing:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }

    var isActive: Bool {
        switch self {
        case .inactive:
            return false
        case .pressing, .dragging:
            return true
        }
    }

    var isDragging: Bool {
        switch self {
        case .inactive, .pressing:
            return false
        case .dragging:
            return true
        }
    }
}

// new
struct Scale {

}
