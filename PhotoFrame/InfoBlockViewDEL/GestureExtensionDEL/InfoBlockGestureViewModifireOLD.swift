
import SwiftUI

struct InfoBlockGestureOLD: ViewModifier {

    @StateObject var vm = GestureViewModelOLD()

    @GestureState var dragState = DragStateOLD.inactive

    func body(content: Content) -> some View {

        let finalOffSetX = vm.viewState.width + dragState.translation.width //vm
        let finalOffSetY = vm.viewState.height + dragState.translation.height //vm

        content
            .scaleEffect(vm.zoomScale.scale)
            .offset(
                x: vm.offSetBound(dragState: finalOffSetX, correct: 100, maxSize: vm.screen.x, scale: vm.scale), //vm
                y: vm.offSetBound(dragState: finalOffSetY, correct: 40, maxSize: vm.screen.y, scale: vm.scale) //vm
            )
//            .offset(
//                x: vm.viewState.height,
//                y: vm.viewState.width
//            )
            .gesture(magnification)
            .simultaneousGesture(longPressDrag)

        // Write to UD

            .onChange(of: vm.zoomScale.finalAmount ) { _ in
                vm.savePosition()
            }
            .onChange(of: vm.viewState) { _ in //vm
                vm.savePosition()
            }

        // MARK: - Tap to move ANIMATION

            .onChange(of: dragState.isActive) { drag in
                if drag {
                    withAnimation(Animation.spring()) {
                        // scale down
                        vm.zoomScale.currentAmount -= 0.05
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            withAnimation(Animation.spring()) {
                                // scale up
                            vm.zoomScale.currentAmount += 0.1
                            }
                        }
                    }
                } else {
                    withAnimation(Animation.spring()) {
                        //scale down
                        vm.zoomScale.currentAmount -= 0.1
                    }
                }
            }
    }
}
