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
struct CameraViewScreen: View {
    @State private var luxValue: String = "0.00"
    @State private var exposureDuration: String = "0.00"
    @State private var infoScreenIsActive = false
    var body: some View {
        NavigationView {ZStack {
            CameraViewController(luxValue: $luxValue,exposureDuration: $exposureDuration)
                .ignoresSafeArea()
            
            // Add a gradient overlay
                           LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.5), Color.black.opacity(0)]),
                                          startPoint: .top,
                                          endPoint: .bottom)
                               .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        infoScreenIsActive = true
                    }) {
                        NavigationLink(destination:InfoScreen()){ Image(systemName: "info.circle")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .padding()
                            .foregroundColor(.white)}
                    }
                }
                Spacer()
            }
            .background(
                NavigationLink(
                    destination: InfoScreen(),
                    label: {
                        EmptyView()
                    }
                )
                .opacity(0)
            )
            
            VStack {
                VStack(alignment: .leading) {
                    Text("LUX Value")
                        .multilineTextAlignment(.center)
                        .font(.caption)
                        .foregroundColor(.white)
                }
                VStack(alignment: .leading) {
                    Text("\(luxValue)")
                        .multilineTextAlignment(.center)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("Recommended exposure")
                        .multilineTextAlignment(.center)
                        .font(.caption)
                        .foregroundColor(.white)
                }
                VStack(alignment: .leading) {
                    Text("\(exposureDuration)")
                        .multilineTextAlignment(.center)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
            }
            .padding()
        }}
    }
}
struct CameraViewScreen_Previews: PreviewProvider {
    static var previews: some View {
        CameraViewScreen()
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
