//
//  ViewController.swift
//  ARWarpDoor
//
//  Created by Hiroki Yoshioka on 2023/01/29.
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
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        // anchorの型チェック
        if anchor is ARPlaneAnchor {
            // anchorをARPlaneAnchor型にキャスト
            let planeAnchor = anchor as! ARPlaneAnchor
            
            // "classroom.scn"の読み込み
            let roomScene = SCNScene(named: "art.scnassets/classroom.scn")!
            
            // シーンから"Classroom"の取り出し
            if let roomNode = roomScene.rootNode.childNode(withName: "Classroom", recursively: true) {
                
                // 平面検出した場所を表示位置に指定
                roomNode.position = SCNVector3(x: planeAnchor.center.x, y: planeAnchor.center.y, z: planeAnchor.center.z)
                
                // ノードの追加
                node.addChildNode(roomNode)
            }
            
            // 平面検出のOFF
            let configuration = ARWorldTrackingConfiguration()
            sceneView.session.pause()
            sceneView.session.run(configuration)
            
        } else {
            return
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // 平面検知
        configuration.planeDetection = .horizontal

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

}
