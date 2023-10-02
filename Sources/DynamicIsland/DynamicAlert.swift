//
//  SwiftUIView.swift
//
//
//  Created by Aayush Pokharel on 2023-10-02.
//
import SwiftUI

public struct DynamicAlert<Leading: View, Trailing: View, Center: View, Bottom: View>: View {
    public var leading: () -> Leading?
    public var trailing: () -> Trailing?
    public var center: () -> Center?
    public var bottom: () -> Bottom?

    public var body: some View {
        VStack {
            HStack {
                leading()
                center()
                    .padding(.top, 20)
                trailing()
            }
            bottom()
        }
        .padding()

        .background {
            RoundedRectangle(cornerRadius: 15)
                .fill(.black)
        }
    }

    public init(
        @ViewBuilder leading: @escaping () -> Leading? = { nil },
        @ViewBuilder trailing: @escaping () -> Trailing? = { nil },
        @ViewBuilder center: @escaping () -> Center? = { nil },
        @ViewBuilder bottom: @escaping () -> Bottom? = { nil }
    ) {
        self.leading = leading
        self.trailing = trailing
        self.center = center
        self.bottom = bottom
    }
}

#Preview {
    ContentView()
}
