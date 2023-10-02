//
//  UIApplication+Extension.swift
//
//
//  Created by Aayush Pokharel on 2023-10-02.
//

import SwiftUI

public extension UIApplication {
    func inAppAlert<Content: View>(
        config: DynamicIslandAlertConfig = .defaultConfig,
        @ViewBuilder content: @escaping () -> Content
    ) {
        // Getting current active window
        if let activeWindow = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first(where: { $0.isKeyWindow }) {
            let frame = activeWindow.frame
            let safeArea = activeWindow.safeAreaInsets

            // Making sure only one alert is presented at a time.
            var tag = 1009

            @AppStorage("InAppAlertTag") var storedTag = 0

            let deviceContainsDynamicIsland = (safeArea.top > 51)
            let checkForDynamicIsland = config.adaptForDynamicIsland && deviceContainsDynamicIsland

            tag = storedTag + 1
            storedTag = tag

            // UIView -> SwiftUI View
            let config = UIHostingConfiguration {
                AnimatedAlertView(
                    content: content(),
                    tag: tag,
                    config: .init(adaptForDynamicIsland: checkForDynamicIsland),
                    safeArea: safeArea
                )
                .frame(width: frame.width - (checkForDynamicIsland ? 20 : 30), height: 120, alignment: .top)
                .contentShape(.rect)
            }
//            UIView
            let view = config.makeContentView()
            view.tag = tag
            view.backgroundColor = .clear
            view.translatesAutoresizingMaskIntoConstraints = false
            activeWindow.addSubview(view)

            // Layout Constraints
            view.centerXAnchor.constraint(equalTo: activeWindow.centerXAnchor).isActive = true
            view.centerYAnchor.constraint(equalTo: activeWindow.centerYAnchor, constant:
                (-(frame.height - safeArea.top) / 2) + (checkForDynamicIsland ? 11 :
                    safeArea.top)).isActive = true
        }
    }
}

#Preview {
    ContentView()
}
