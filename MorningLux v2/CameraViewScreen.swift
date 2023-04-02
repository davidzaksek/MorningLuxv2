import SwiftUI
import UIKit
import AVFoundation

struct CameraViewController: UIViewControllerRepresentable {
    @Binding var luxValue: String

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

            let cameraImage = CIImage(cvPixelBuffer: pixelBuffer)
            let exposureValue = cameraImage.averageBrightness()
            let lux = exposureValue * 2.5
            // Remove the line below if you don't want to transform the lux value
            let transformedLux = transformLuxValue(lux)
            DispatchQueue.main.async {
                self.parent.luxValue = String(format: "%.10f", transformedLux)
            }
        }
    }
}

func transformLuxValue(_ value: Double) -> Double {
    // ... (the rest of your transformLuxValue function)
}

extension CIImage {
    func averageBrightness() -> Float {
        // ... (the same averageBrightness function from the previous CameraController.swift)
    }
}
