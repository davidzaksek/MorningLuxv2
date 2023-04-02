//
//  CameraPermissionHelper.swift
//  MorningLux v2
//
//  Created by Klemen Selakovic on 31/03/2023.
//

import AVFoundation

func requestCameraPermission(completion: @escaping (Bool) -> Void) {
    AVCaptureDevice.requestAccess(for: .video) { granted in
        DispatchQueue.main.async {
            completion(granted)
        }
    }
}
