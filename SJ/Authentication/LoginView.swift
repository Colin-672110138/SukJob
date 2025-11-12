//
//  LoginView.swift
//  SJ
//
//  Created by colin black on 12/11/2568 BE.
//

// Views/Authentication/LoginView.swift

import SwiftUI
import Combine

struct LoginView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 30) {
            Text("ยินดีต้อนรับสู่ suk Job")
                .font(.largeTitle)
                .bold()
            
            HStack {
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)

                Text("เข้าสู่ระบบ")
                    .font(.headline)
                    .foregroundColor(.gray)

                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)
            }
            
            // ปุ่มจำลองการ Login
            Button(action: {
                viewModel.performLineLogin() // เรียกใช้ Mock Login
            }) {
                HStack {
                    Image("LineIcon") // สมมติว่ามีรูป Line Icon
                    Text("เข้าสู่ระบบด้วย LINE")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green) // สีเขียวสื่อถึงการเกษตร/Go
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .padding(40)
        // เมื่อ Login สำเร็จ (isAuthenticated = true) จะนำทางไปหน้าถัดไป
        .navigationDestination(isPresented: $viewModel.isAuthenticated) {
            WelcomeRoleSelectionView(viewModel: viewModel)
        }
    }
}
