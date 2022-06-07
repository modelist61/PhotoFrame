import SwiftUI

struct InfoBlockGesture: ViewModifier {
    // MARK: State

    @StateObject var vm = GestureViewModel()
    @GestureState private var isPressingDown: Bool = false

    // MARK: UI

    func body(content: Content) -> some View {
        content
            .scaleEffect(vm.zoomScale.scale)
            .offset(x: vm.position.offSet.width, y: vm.position.offSet.height)
            .gesture(magnification)
            .simultaneousGesture(longPress)
            .onChange(of: isPressingDown) { value in
                if !value {
                    vm.isPressedDown = false //Reset the @ObservedObject property
                }
            }
    }
}

// MARK: Zoom extensin

extension InfoBlockGesture {
    var magnification: some Gesture {
        MagnificationGesture(minimumScaleDelta: 0.1)
            .onChanged { amount in
                vm.zoomScale.currentAmount = amount - 1
                print("Current - \(vm.zoomScale.currentAmount) \nAmount - \(amount)")
                print("Position if scale - \(vm.position.offSet.width)")
            }
            .onEnded { amount in
                print("ONEND AMOUNT \(amount)")
                vm.zoomScale.finalAmount += vm.zoomScale.currentAmount
                vm.zoomScale.currentAmount = 0
            }
    }
}

// MARK: Drag EXTENSION

extension InfoBlockGesture {
    var drag: some Gesture {
        DragGesture()
            .onChanged { drag in
                vm.offSet(drag: drag.translation)
                print("DRAG \(drag.translation.width)")
            }
            .onEnded { value in
                self.vm.position.newPosition.width += value.translation.width
                self.vm.position.newPosition.height += value.translation.height
            }
    }
}

// MARK: Long press + end Hold + simulation drag EXTENSION

extension InfoBlockGesture {
    var longPress: some Gesture {
        LongPressGesture(minimumDuration: 0.1)
            .sequenced(
                before: LongPressGesture(minimumDuration: .infinity)
                    .simultaneously(with: drag)
            )
            .updating($isPressingDown) { value, state, transaction in
                switch value {
                case .second(true, nil): //This means the first Gesture completed
                    state = true //Update the GestureState
                    withAnimation(Animation.spring()) {
                        vm.isPressedDown = true
                    }
                default: break
                }
            }
    }
}
