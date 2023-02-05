//
//  ViewController.swift
//  ARWarpDoor
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
        // 型チェック
        if anchor is ARPlaneAnchor {
            // ARPlaneAnchor型にキャスト
            let planeAnchor = anchor as! ARPlaneAnchor
            
            // classroom.scnを読み込む
            let roomScene = SCNScene(named: "art.scnassets/classroom.scn")!
            
            // シーンからclassroomAllを取り出す
            if let roomNode = roomScene.rootNode.childNode(withName: "classroomAll", recursively: true) {
                
                // 平面検出の場所をレンダリング位置に設定する
                roomNode.position = SCNVector3(x: planeAnchor.center.x, y: planeAnchor.center.y, z: planeAnchor.center.z)
                
                // ノードを追加
                node.addChildNode(roomNode)
            }
            
            // 平面検出を止める
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
