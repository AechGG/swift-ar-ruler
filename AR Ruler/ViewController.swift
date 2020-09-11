//
//  ViewController.swift
//  AR Ruler
//
//  Created by Harrison Gittos on 11/09/2020.
//  Copyright © 2020 Harrison Gittos. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints];
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
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
            let hitTestResults = sceneView.hitTest(touchLocation, types: .featurePoint);
            
            if let hitResult = hitTestResults.first {
                addDot(at: hitResult);
            }
        }
    }
    
    func addDot(at hitResult: ARHitTestResult) {
        let dotGeometry = SCNSphere(radius: 0.005);
        let material = SCNMaterial();
        material.diffuse.contents = UIColor.red;
        dotGeometry.materials = [material];
        
        let dotNode = SCNNode(geometry: dotGeometry);
        
        dotNode.position = SCNVector3(hitResult.worldTransform.columns.3.x, hitResult.worldTransform.columns.3.y, hitResult.worldTransform.columns.3.z);
        
        sceneView.scene.rootNode.addChildNode(dotNode);
    }

}
