

<div align="center">

# DynamicIsland
WIP Swift Library to show in-app alerts in dynmaic island

<img src="https://github.com/Aayush9029/DynamicIsland/assets/43297314/32b6f0f3-1f69-47a4-9fcf-5bc09cf91d77" width="480">

</div>


```swift

import DynamicIsland
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Show Alert", systemImage: "bell.fill") {
                UIApplication.shared.inAppAlert {
                    DynamicAlert {
                        SmolView("leading")
                    } trailing: {
                        SmolView("trailing")
                    } center: {
                        SmolView("center", again: false)
                    } bottom: {
                        SmolView("bottom", again: false)
                    }
                }
            }
            .tint(.black)
            .buttonStyle(.borderedProminent)
            Spacer()
        }
    }
}
```
