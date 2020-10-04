//
//  ViewController.swift
//  ARRuler
//
//  Created by Marcus Y. Kim on 10/4/20.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touchLocation = touches.first?.location(in: sceneView) {
            let hitTestResult = sceneView.raycastQuery(from: touchLocation, allowing: .estimatedPlane, alignment: .any)
            
            if let hitResult = hitTestResult {
                addDot(at: hitResult)
            }
            
        }
    }
    
    func addDot(at hitResult: ARRaycastQuery) {
        
        let dotGeometry = SCNSphere(radius: 0.05)
        
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.red
        
        dotGeometry.materials = [material]
        
        let dotNode = SCNNode(geometry: dotGeometry)
        
        dotNode.position = SCNVector3(hitResult.direction.x, hitResult.direction.y, hitResult.direction.z)
        
        sceneView.scene.rootNode.addChildNode(dotNode)
        
    }
    

}
