import SwiftUI

struct PermissionDeniedView: View {
    var body: some View {
        VStack {
            Image(systemName: "camera")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.red)
            
            Text("Camera Permission Denied")
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
                .padding(.top)
            
            Text("This app requires camera access to measure light exposure. Please enable camera access in your device settings. Go to Settings > MorningLux > Camera Allow")
                .font(.body)
                .padding()
                .multilineTextAlignment(.center)
        }
    }
}

struct PermissionDeniedView_Previews: PreviewProvider {
    static var previews: some View {
        PermissionDeniedView()
    }
}
