import SwiftUI
import UIKit
import AVFoundation
import CoreMotion


struct CameraViewController: UIViewControllerRepresentable {
    @Binding var luxValue: String
    @Binding var exposureDuration: String

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let previewView = PreviewView()
        previewView.videoPreviewLayer.videoGravity = .resizeAspectFill
        previewView.frame = viewController.view.bounds
        viewController.view.addSubview(previewView)

        let session = AVCaptureSession()
        let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
        do {
            let input = try AVCaptureDeviceInput(device: camera!)
            if session.canAddInput(input) {
                session.addInput(input)
            }

            let videoOutput = AVCaptureVideoDataOutput()
            videoOutput.setSampleBufferDelegate(context.coordinator, queue: DispatchQueue(label: "sample buffer delegate", attributes: []))
            if session.canAddOutput(videoOutput) {
                session.addOutput(videoOutput)
            }
        } catch {
            print(error)
        }

        session.startRunning()
        previewView.session = session

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

extension CameraViewController {
    class Coordinator: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
        var parent: CameraViewController

        init(_ parent: CameraViewController) {
            self.parent = parent
        }

        func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
            guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
                return
            }
            
            let rawMetadata = CMCopyDictionaryOfAttachments(allocator: nil, target: sampleBuffer, attachmentMode: CMAttachmentMode(kCMAttachmentMode_ShouldPropagate))
            let metadata = CFDictionaryCreateMutableCopy(nil, 0, rawMetadata) as NSMutableDictionary
            let exifData = metadata.value(forKey: "{Exif}") as? NSMutableDictionary
                    
            let FNumber : Double = exifData?["FNumber"] as! Double
            let ExposureTime : Double = exifData?["ExposureTime"] as! Double
            let ISOSpeedRatingsArray = exifData!["ISOSpeedRatings"] as? NSArray
            let ISOSpeedRatings : Double = ISOSpeedRatingsArray![0] as! Double
            let CalibrationConstant : Double = 50
                    
            let luminosity : Double = (CalibrationConstant * FNumber * FNumber ) / ( ExposureTime * ISOSpeedRatings )

            let cameraImage = CIImage(cvPixelBuffer: pixelBuffer)
            let exposureValue = averageBrightness(for: cameraImage)
            let lux = pow(90, Double(exposureValue)*2) * 12.5
            // Remove the line below if you don't want to transform the lux value
            _ = transformLuxValue(lux)
            DispatchQueue.main.async {
                self.parent.luxValue = String(format: "%.0f", luminosity)
            }
            if(luminosity < 1000){
                self.parent.exposureDuration = String("Not enough light to start your circadian rhythm")
            }
            else if(luminosity < 5000){
                self.parent.exposureDuration = String("60 - 120 min")
            }
            else if(luminosity < 10000){
                self.parent.exposureDuration = String("20 - 30 min")
            }
            else if(luminosity < 50000){
                self.parent.exposureDuration = String("15 - 20 min")
            }
            else if(luminosity < 100000){
                self.parent.exposureDuration = String("10 - 15 min")
            }
            else{
                self.parent.exposureDuration = String("1 - 2 min")
            }
        }
    }
}

func transformLuxValue(_ value: Double) -> Double {
    // ... (the rest of your transformLuxValue function)
    return 0.0 // Replace this line with the correct return value
}

func averageBrightness(for image: CIImage) -> Float {
    // Set up the filter to calculate the average color of the input image
    guard let averageFilter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: image]) else {
        print("Error: Could not create CIAreaAverage filter.")
        return -1
    }

    // Apply the filter and get the output image
    guard let outputImage = averageFilter.outputImage else {
        print("Error: Could not apply CIAreaAverage filter.")
        return -1
    }

    // Create a 1x1 pixel context to extract the color information
    let context = CIContext(options: [.workingColorSpace: NSNull()])
    let pixelSize = CGSize(width: 1, height: 1)
    guard let outputPixel = context.createCGImage(outputImage, from: CGRect(origin: .zero, size: pixelSize)) else {
        print("Error: Could not create CGImage from the output image.")
        return -1
    }

    // Get the color information from the pixel
    let dataProvider = outputPixel.dataProvider
    guard let data = dataProvider?.data else {
        print("Error: Could not get pixel data.")
        return -1
    }

    guard let pixelData = CFDataGetBytePtr(data) else {
        print("Error: Could not get byte pointer from data.")
        return -1
    }

    let red = Float(pixelData[0]) / 255.0
    let green = Float(pixelData[1]) / 255.0
    let blue = Float(pixelData[2]) / 255.0

    // Calculate the brightness using the ITU-R Recommendation BT.709 formula
    let brightness = 0.2126 * red + 0.7152 * green + 0.0722 * blue

    return brightness
}
