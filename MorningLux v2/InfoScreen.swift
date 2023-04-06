import SwiftUI

struct InfoScreen: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("The Importance of Morning Light")
                    .font(.title)
                    .fontWeight(.bold)

                Text("Morning light plays a crucial role in regulating our circadian rhythms, our body's internal clocks that control sleep-wake cycles, hormone release, and other biological processes. Exposure to natural light in the morning helps synchronize our circadian rhythms, leading to better sleep quality, improved mood, and increased daytime alertness.")
                    .font(.body)

                Text("Our Mornings Today")
                    .font(.title2)
                    .fontWeight(.bold)

                Text("People today typically spend 90% of their time indoors, away from natural sunlight. This lack of exposure to natural light, especially in the morning, can disrupt our circadian rhythms and lead to various health issues, including poor sleep, low mood, and reduced productivity. MorningLux aims to address this problem by helping you optimize your morning light exposure, even indoors.")
                    .font(.body)
                
                Text("What is LUX?")
                    .font(.title2)
                    .fontWeight(.bold)

                Text("LUX (lumens per square meter) is a measurement unit that represents the light intensity in a given area. It is used to quantify the amount of light available in various environments, from indoor spaces to natural sunlight.")
                    .font(.body)
                
                Text("Circadian Rhythm")
                    .font(.title2)
                    .fontWeight(.bold)

                Text("Our circadian rhythm is a 24-hour internal clock that governs our sleep-wake cycle and other physiological processes. It is influenced by external factors, such as light exposure, and is vital in maintaining our overall health and well-being. Our internal clocks are synchronized with the environment primarily by light, remarkably the sun's natural light. When our circadian rhythm is disrupted, it can lead to sleep disorders, mood disturbances, and other health problems.")
                    .font(.body)
                
                
                
                Text("Science & Research")
                    .font(.title2)
                    .fontWeight(.bold)

                Text("Scientific research has consistently demonstrated the importance of light exposure in regulating our circadian rhythms. Studies have shown that morning light exposure is beneficial for maintaining a healthy sleep-wake cycle and supporting various physiological processes, such as hormone production and body temperature regulation. Research has also revealed the presence of specialized cells in our eyes called intrinsically photosensitive retinal ganglion cells (ipRGCs), which play a crucial role in synchronizing our circadian rhythms with light. These cells are particularly sensitive to blue light, which is abundant in natural sunlight in the morning. Furthermore, numerous studies have investigated the effects of light therapy on various health conditions, including circadian rhythm sleep disorders, depression, dementia, and insomnia. The use of bright light therapy, dawn simulation, and blue light exposure has shown promise in helping to treat these conditions by regulating circadian rhythms and improving overall health. MorningLux incorporates these scientific findings to provide personalized recommendations for optimal morning light exposure. By measuring the LUX intensity in your environment and calculating your ideal exposure time, our app helps you support your circadian rhythm and experience the numerous health benefits associated with adequately timed light exposure.")
                    .font(.body)
                
                
                

                // Add more information as needed
            }.padding([.top,.leading,.trailing])
            VStack(alignment: .leading, spacing: 10) {

                Text("How It Works")
                    .font(.title2)
                    .fontWeight(.bold)

                Text("The MorningLux app is intended to be used in the first 30 minutes of waking up and in the outside natural light. MorningLux uses your smartphone's camera to measure the LUX intensity in your environment. Based on this measurement and cutting-edge research, the app calculates your ideal exposure time to morning light for optimal health benefits. Following our personalized recommendations can improve your sleep, mood, and overall well-being. Point your smartphone's camera at the light source you want to measure, and MorningLux will provide an accurate LUX reading. Then, based on this information, the app will generate personalized recommendations for your ideal morning light exposure time. Start using MorningLux today and experience the benefits of a healthier, more balanced lifestyle through the optimized morning light exposure.")
                    .font(.body)
                
                
                

                // Add more information as needed
            }
            .padding([.bottom,.leading,.trailing]).padding(.top,5)
        }
        .navigationBarItems(leading: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                //Image(systemName: "chevron.left")
                //Text("Back")
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
