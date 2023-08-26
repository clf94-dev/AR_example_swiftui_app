//
//  ContentView.swift
//  AR_example_app
//
//  Created by Carmen Lucas on 25/8/23.
//

import SwiftUI

struct ContentView: View {
    @State private var colors: [Color] = [.green, .red, .blue]
    var body: some View {
        CustomARViewRepresentable()
            .ignoresSafeArea()
            .overlay (alignment: .bottom) {
                ScrollView(.horizontal){
                    HStack{
                        Button("Place") {
                            ARManager.shared.actionStream.send(.placeCamera)
                        }
                        Button{
                            ARManager.shared.actionStream.send(.removeAllAnchors)
                        } label: {
                            Image(systemName: "trash")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .padding()
                                .background(.regularMaterial)
                                .clipShape(.rect(cornerRadius: 16))
                        }
                        ForEach(colors, id: \.self) {color in
                            Button{
                                ARManager.shared.actionStream.send(.placeBlock(color: color))
                            } label: {
                                color
                                    .frame(width: 40, height: 40)
                                    .padding()
                                    .background(.regularMaterial)
                                    .clipShape(.rect(cornerRadius: 16))
                            }
                        }
                    }.padding()
                }
            }
    }
}

#Preview {
    ContentView()
}
