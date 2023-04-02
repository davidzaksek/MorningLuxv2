import SwiftUI
import AVFoundation

struct LogoAndExplanationView: View {
    @Binding var hasCameraPermission: Bool
    @State private var cameraViewIsActive = false
    @State private var cameraPermissionDenied = false

    var body: some View {
        NavigationView {
            VStack(spacing: 10) {                Spacer()
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)

                Text("MorningLux")
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                Text("Optimize Your Morning Light Exposure")
                    .font(.title3)
                    .bold()
                    .multilineTextAlignment(.center)
                
                Text("Light is as essential for humans and fundamental for life and of equal importance as water and air.")
                    .font(.callout)
                    .padding()
                    .multilineTextAlignment(.center)
                Spacer()
                Button(action: {
                    requestCameraPermission { granted in
                        if granted {
                            cameraViewIsActive = true
                            hasCameraPermission = true
                        } else {
                            cameraPermissionDenied = true
                        }
                    }
                }) {
                    Text("Grant camera permission")
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.yellow)
                        .foregroundColor(.black)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                .background(
                    NavigationLink("", destination: CameraViewScreen())
                        .opacity(0)
                        .disabled(!cameraViewIsActive)
                )

                Text("Created by Klemen Selakovic & GPT-4")
                    .font(.caption2)
                    .padding()
                    .multilineTextAlignment(.center)
            }
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $cameraPermissionDenied) {
                PermissionDeniedView()
            }
        }
    }
}

struct LogoAndExplanationView_Previews: PreviewProvider {
    static var previews: some View {
        LogoAndExplanationView(hasCameraPermission: .constant(false))
    }
}
