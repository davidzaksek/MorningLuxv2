import SwiftUI

struct InfoScreen: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("The Importance of Morning Light")
                    .font(.title)
                    .fontWeight(.bold)

                Text("MorningLux is a user-friendly app designed to help you optimize your morning light exposure for better health and well-being. Based on scientific research, MorningLux measures the LUX intensity of your environment and provides a personalized timer to ensure you receive the optimal amount of light exposure for your circadian rhythm.")
                    .font(.body)

                Text("Circadian Rhythm")
                    .font(.title2)
                    .fontWeight(.bold)

                Text("Circadian rhythm is a natural, internal process that regulates the sleep-wake cycle and repeats on each rotation of the Earth, roughly every 24 hours. It can be affected by environmental cues, like sunlight and temperature. MorningLux uses your smartphone's camera to accurately measure the light intensity in your surroundings, calculates the ideal exposure time for you, and helps you track your daily light exposure, set goals, and monitor your progress over time. By optimizing your morning light exposure, you can experience benefits such as better sleep, increased energy, and enhanced well-being.")
                    .font(.body)
                

                // Add more information as needed
            }
            .padding()
        }
        .navigationBarItems(leading: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                Text("Back")
            }
            .foregroundColor(Color.blue)
        })
        .navigationTitle("Information")
    }
}

struct InfoScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            InfoScreen()
        }
    }
}
