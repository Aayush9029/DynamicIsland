//
//  SwiftUIView.swift
//
//
//  Created by Aayush Pokharel on 2023-10-02.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Show Alert", systemImage: "bell.fill") {
                UIApplication.shared.inAppAlert {
                    VStack {
                        DynamicAlert {
                            SmolView("leading")
                        } trailing: {
                            SmolView("trailing")
                        } center: {
                            SmolView("center", again: false)
                        } bottom: {
                            SmolView("bottom")
                        }
                    }
                }
            }
            .tint(.black)
            .buttonStyle(.borderedProminent)
        }
    }

    @ViewBuilder func SmolView(_ text: String, again: Bool = true) -> some View {
        VStack {
            VStack {
                Text(text)
                Group {
                    if again {
                        Text(text)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(6)
            .foregroundStyle(.red)
            .background(.red.opacity(0.25))
            .clipShape(.rect(cornerRadius: 26))
        }
    }
}

#Preview("Alert Preview") {
    ContentView()
}
