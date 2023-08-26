//
//  CustomARView.swift
//  AR_example_app
//
//  Created by Carmen Lucas on 25/8/23.
//

import ARKit
import Combine
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
        subscribeToActionStream()
    }
    
    private var cancellables: Set<AnyCancellable> = []
    // private var camera: CameraModel.Scene? = nil
    func subscribeToActionStream() {
        ARManager
            .shared
            .actionStream
            .sink {[weak self] action in
                switch action {
                    case .placeBlock(let color):
                        self?.placeBlock(ofColor: color)
                    case .removeAllAnchors:
                        self?.scene.anchors.removeAll()
                case .placeCamera:
                    do {
                        // let camera = try CameraModel.loadScene()
                        let camera = try? Entity.load(named: "CameraModel")
                        guard let cameraItem = camera else{
                            return
                        }
                        let anchor = AnchorEntity(world: .zero)
                        anchor.addChild(cameraItem)
                    
                        self?.scene.addAnchor(anchor)
                        // cameraItem.transform.translation = [0, 0,-0.6]
                        // self?.camera = camera
                    } catch {
                        print(error)
                    }
                    
                }
            }
            .store(in: &cancellables)
    }
    func configurationExamples() {
        // Tracks the device relative to it's environment
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        session.run(configuration)
        
        // Not supported in all regions, tracks w.r.t. global coordinates
        let _ = ARGeoTrackingConfiguration()
        
        // Tracks faces in the scene
        let _ = ARFaceTrackingConfiguration()
        
        // Tracks bodies in the scene
        let _ = ARBodyTrackingConfiguration()
        
    }
    
    func anchorExamples() {
        // Attach anchors at specific coordinates in the iPhone-centered coordinate system
        let coordinateAnchor = AnchorEntity(world: .zero)
        scene.addAnchor(coordinateAnchor)
        
        // Attach anchors to detected planes (this works best on devices with LIDAR sensor)
        // let _ = AnchorEntity(plane: .horizontal)
        // let _ = AnchorEntity(plane: .vertical)
        
        // Attach anchors to tracked body parts, such as the face
        let _ = AnchorEntity(.face)
        
        // Attach anchors to tracked images, such as markers or visual codes
        let _ = AnchorEntity(.image(group: "group", name: "name"))
    }
    
    func entityExamples() {
        // load an entity from a usdz file
         let _ = try? Entity.load(named:"usdzFileName")
        
        // load an entity from a reality file
        let _ = try? Entity.load(named: "realityFileName")
        
        // Generate an entity with code
        let box = MeshResource.generateBox(size: 1)
        let entity = ModelEntity(mesh: box)
        
        // Add entity to an anchor, so it's placed in the scene
        let anchor = AnchorEntity()
        anchor.addChild(entity)
        
    }
    
    func placeBlock(ofColor color: Color) {
        let block = MeshResource.generateBox(size: 0.1)
        let material = SimpleMaterial(color: UIColor(color), isMetallic: false)
        let entity = ModelEntity(mesh: block, materials: [material])
        
        let anchor = AnchorEntity(world: .zero)
        anchor.addChild(entity)
        scene.addAnchor(anchor)
        
        
        // entity.transform.translation = [0, 0,-1]
    }
}
