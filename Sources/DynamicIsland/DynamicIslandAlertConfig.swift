//
//  DynamicIslandAlertConfig.swift
//
//
//  Created by Aayush Pokharel on 2023-10-02.
//

import Foundation

public struct DynamicIslandAlertConfig {
    public var adaptForDynamicIsland: Bool
    public var timeout: CGFloat
    public var swipeToClose: Bool

    public static let defaultConfig: DynamicIslandAlertConfig = .init(
        adaptForDynamicIsland: true,
        timeout: 3.0,
        swipeToClose: false
    )

    public init(adaptForDynamicIsland: Bool = true, timeout: CGFloat = 3.0, swipeToClose: Bool = true) {
        self.adaptForDynamicIsland = adaptForDynamicIsland
        self.timeout = timeout
        self.swipeToClose = swipeToClose
    }
}
