import SwiftUI

struct ZoomModel {
    var currentAmount = 0.0
    var finalAmount = 1.0
    var scale: CGFloat {
         currentAmount + finalAmount
    }
}

struct PositionModel {
    var newPosition: CGSize = .zero
    var offSet: CGSize = .zero
}

struct ScreenSize {
    var y = UIScreen.main.bounds.height
    var x = UIScreen.main.bounds.width
}

//enum DragState {
//    case inactive
//    case pressing
//    case dragging(translation: CGSize)
//
//    var translation: CGSize {
//        switch self {
//        case .inactive, .pressing:
//            return .zero
//        case .dragging(let translation):
//            return translation
//        }
//    }
//
//    var isActive: Bool {
//        switch self {
//        case .inactive:
//            print("isActive first case")
//            return false
//        case .pressing, .dragging:
//            print("isActive second case")
//            return true
//        }
//    }
//
//    var isDragging: Bool {
//        switch self {
//        case .inactive, .pressing:
//            return false
//        case .dragging:
//            return true
//        }
//    }
//}
