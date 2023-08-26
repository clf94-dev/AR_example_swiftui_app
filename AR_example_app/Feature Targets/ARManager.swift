//
//  ARManager.swift
//  AR_example_app
//
//  Created by Carmen Lucas on 25/8/23.
//

import Combine

class ARManager {
    static let shared = ARManager()
    private init () {
        
    }
    
    var actionStream = PassthroughSubject<ARAction, Never>()
}
