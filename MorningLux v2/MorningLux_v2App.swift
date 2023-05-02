//
//  MorningLux_v2App.swift
//  MorningLux v2
//
//  Created by Klemen Selakovic on 31/03/2023.
//

import SwiftUI
import Foundation

@main
struct YourAppNameApp: App {
    var body: some Scene {
        WindowGroup {
            InitialView().preferredColorScheme(getColorSchemeBasedOnTime())
        }
    }
}

struct Previews_MorningLux_v2App_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}

func getColorSchemeBasedOnTime() -> ColorScheme {
    let hour = Calendar.current.component(.hour, from: Date())
    if hour >= 7 && hour <= 18 {
        return .light
    } else {
        return .dark
    }
}
