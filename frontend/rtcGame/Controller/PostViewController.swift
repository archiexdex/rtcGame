//
//  PostViewController.swift
//  rtcGame
//
//  Created by HsinChih Yang on 10/07/2017.
//  Copyright © 2017 Archie. All rights reserved.
//

import UIKit
import AVFoundation
import ImageIO

class PostViewController: UIViewController {

    
    @IBOutlet var theView: UIView!
    
    var theImageView = UIImageView()
    let session = AVCaptureSession()
    let captureVPL = AVCaptureVideoPreviewLayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        session.sessionPreset = AVCaptureSessionPresetPhoto
        
        if let device = AVCaptureDevice.defaultDevice(withDeviceType: .builtInWideAngleCamera, mediaType: AVMediaTypeVideo, position: .back) {
            session.addInput(try! AVCaptureDeviceInput(device: device))
            
            session.addOutput(AVCapturePhotoOutput())
            
            captureVPL.session = session
            captureVPL.videoGravity = AVLayerVideoGravityResizeAspectFill
            theView.layer.addSublayer(captureVPL)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        captureVPL.frame = theView.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        session.startRunning()
    }

    // MARK: - Navigation Controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let vc = segue.destination as! PostNextViewController
//        vc.theImageView = theImageView
//        
    }
    
    // MARK: - IBAction
    @IBAction func backAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FirstViewController") as! FirstViewController
        
//        self.present(vc, animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func takeButton(_ sender: Any) {
        
        let settings = AVCapturePhotoSettings()
        let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first
        let previewFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewPixelType as Any,
                             kCVPixelBufferWidthKey as String: theImageView.frame.size.width,
                             kCVPixelBufferHeightKey as String: theImageView.frame.size.height,
        ] as [String:Any]
        
        settings.previewPhotoFormat = previewFormat
        
        if let output = session.outputs.first as? AVCapturePhotoOutput {
            output.capturePhoto(with: settings, delegate: self)
        }
        
    }
}

extension PostViewController : AVCapturePhotoCaptureDelegate {
    func capture(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhotoSampleBuffer photoSampleBuffer: CMSampleBuffer?, previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        
        guard error == nil else {
            print(error as Any)
            return
        }
        
        let imageData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer!, previewPhotoSampleBuffer: previewPhotoSampleBuffer)
        
        theImageView.image = UIImage(data: imageData!)
        
        //UIImageWriteToSavedPhotosAlbum(theImageView.image!, nil, nil, nil)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "PostNextViewController") as! PostNextViewController
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension PostViewController: PostNextViewDelegate {
    func getImage() -> UIImage? {
        return theImageView.image
    }
}
