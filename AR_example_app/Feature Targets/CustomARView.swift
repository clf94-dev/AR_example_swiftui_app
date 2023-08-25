//
//  CustomARView.swift
//  AR_example_app
//
//  Created by Carmen Lucas on 25/8/23.
//

import ARKit
import RealityKit
import SwiftUI

class CustomARView: ARView {
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
    }
    dynamic required init?(coder decoder: NSCoder) {
        fatalError("init(codeer:) has not ben implemented")
    }
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
    }
}
