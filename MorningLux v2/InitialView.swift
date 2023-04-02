//
//  InitialView.swift
//  MorningLux v2
//
//  Created by Klemen Selakovic on 31/03/2023.
//

import SwiftUI
import AVFoundation

struct InitialView: View {
    @State private var hasCameraPermission = false

    var body: some View {
        VStack {
            if hasCameraPermission {
                CameraViewScreen()
            } else {
                LogoAndExplanationView(hasCameraPermission: $hasCameraPermission)
            }
        }
        .onAppear {
            checkCameraPermission { granted in
                hasCameraPermission = granted
            }
        }
    }
}

struct InitialView_Previews: PreviewProvider {
    static var previews: some View {
        InitialView()
    }
}

func checkCameraPermission(completion: @escaping (Bool) -> Void) {
    let authorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
    switch authorizationStatus {
    case .authorized:
        completion(true)
    case .notDetermined, .restricted, .denied:
        completion(false)
    default:
        completion(false)
    }
}
