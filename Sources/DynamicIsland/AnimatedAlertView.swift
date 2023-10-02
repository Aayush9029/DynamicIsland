//
//  AnimatedAlertView.swift
//
//
//  Created by Aayush Pokharel on 2023-10-02.
//

import SwiftUI

struct AnimatedAlertView<Content: View>: View {
    // Parameters
    var content: Content
    var tag: Int
    var config: DynamicIslandAlertConfig
    var safeArea: UIEdgeInsets

    // View Properties
    @State private var animateAlert: Bool = false

    var body: some View {
        content
            .blur(radius: animateAlert ? 0 : 12)
            .disabled(!animateAlert)
            .mask {
                if config.adaptForDynamicIsland {
                    RoundedRectangle(cornerRadius: 50, style: .continuous)
                } else {
                    Rectangle()
                }
            }
            // Scaling animaton: for dynamic island devices
            .scaleEffect(config.adaptForDynamicIsland ? (animateAlert ? 1 : 0.01) : 1, anchor: .init(x: 0.5, y: 0.01))
            // Offset animation: other devices
            .offset(y: offsetY)

            .gesture(
                DragGesture()
                    .onEnded { value in
                        if -value.translation.height > 50, config.swipeToClose {
                            removeAlert()
                        }
                    }
            )
            .onAppear {
                Task {
                    guard !animateAlert else { return }
                    withAnimation(.smooth) {
                        animateAlert = true
                    }

                    try await Task.sleep(for: .seconds(config.timeout < 1 ? 1 : config.timeout))

                    guard animateAlert else { return }
                    removeAlert()
                }
            }
    }

    func removeAlert() {
        withAnimation(.smooth, completionCriteria: .logicallyComplete) {
            animateAlert = false
        } completion: {
            removeAlertFromWindow()
        }
    }

    func removeAlertFromWindow() {
        if let activeWindow = (UIApplication.shared.connectedScenes.first as?
            UIWindowScene)?.windows.first(where: { $0.isKeyWindow })
        {
            if let view = activeWindow.viewWithTag(tag) {
                print("Removing view with tag: \(tag)")
                view.removeFromSuperview()
            }
        }
    }

    var offsetY: CGFloat {
        config.adaptForDynamicIsland ? 0 : (animateAlert ? 10 : -(safeArea.top + 130))
    }
}

#Preview {
    ContentView()
}
