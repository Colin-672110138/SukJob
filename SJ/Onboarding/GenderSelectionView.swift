//
//  GenderSelectionView.swift
//  SJ
//
//  Created by colin black on 12/11/2568 BE.
//

// Views/Onboarding/GenderSelectionView.swift

import SwiftUI

struct GenderSelectionView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    // สถานะสำหรับหน้าถัดไป (หน้า 4: อัปโหลดบัตร)
    @State private var goToNextStep = false
    
    var body: some View {
        VStack(spacing: 30) {
            Text("ข้อมูลส่วนตัว (3/7)")
                .font(.title2)
                .bold()
            
            Text("กรุณาเลือกเพศของคุณ")
                .font(.headline)
            
            Picker("เลือกเพศ", selection: $viewModel.userProfile.gender) {
                Text("ไม่ได้ระบุ").tag("")
                Text("ชาย").tag("Male")
                Text("หญิง").tag("Female")
                Text("อื่นๆ").tag("Other")
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            Spacer()
            
            // ปุ่มดำเนินการต่อ
            Button("ดำเนินการต่อ") {
                // ตรวจสอบว่าเลือกเพศแล้วหรือไม่ก่อนไปต่อ
                if !viewModel.userProfile.gender.isEmpty {
                    goToNextStep = true
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(viewModel.userProfile.gender.isEmpty ? Color.gray : Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
            .disabled(viewModel.userProfile.gender.isEmpty)
        }
        .padding()
        //.navigationTitle("เลือกเพศ")
        
        // MARK: - การนำทางไปหน้า 4
        .navigationDestination(isPresented: $goToNextStep) {
            IDCardUploadView(viewModel: viewModel) // <--- เปลี่ยนจาก Placeholder
        }
        // MARK: - ปุ่มย้อนกลับ (Navigation Bar)
        // เนื่องจากใช้ NavigationStack ปุ่มย้อนกลับจะถูกสร้างโดยอัตโนมัติ
        // ทำให้ผู้ใช้สามารถย้อนกลับไปหน้าเลือกบทบาท (หน้า 2) ได้
    }
}
