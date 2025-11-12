//
//  SJApp.swift
//  SJ
//
//  Created by colin black on 12/11/2568 BE.
//

// (YourAppName)App.swift

import SwiftUI

@main
struct AppEntry: App {
    // สร้าง ViewModel ตัวเดียวเพื่อส่งต่อสถานะไปทุกหน้าจอ
    @StateObject var onboardingVM = OnboardingViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                // เริ่มต้นที่หน้า Login
                LoginView(viewModel: onboardingVM)
            }
        }
    }
}
