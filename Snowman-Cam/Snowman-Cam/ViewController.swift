//
//  ViewController.swift
//  Snowman-Cam
//
//  Created by Johannes Schneemann on 1/16/20.
//  Copyright © 2020 Johannes Schneemann. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var categoryLabel: UILabel!
    
    let model = GoogLeNetPlaces()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        let imageView = sender.view as? UIImageView
        
        if let imageToAnalyse = imageView?.image {
            if let sceneLabelString = sceneLabel(forImage: imageToAnalyse) {
                categoryLabel.text = sceneLabelString
            }
        }
        
        
    }
    
    func sceneLabel (forImage image:UIImage) -> String? {
        if let pixelBuffer = ImageHandler.pixelBuffer(forImage: image.cgImage!) {
            guard let scene = try? model.prediction(sceneImage: pixelBuffer) else {fatalError("Unexpected runtime error")}
            return scene.sceneLabel
            
        }
        
        return nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
}

}
