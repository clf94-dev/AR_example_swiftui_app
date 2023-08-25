//
//  ContentView.swift
//  AR_example_app
//
//  Created by Carmen Lucas on 25/8/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        CustomARViewRepresentable()
            .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
