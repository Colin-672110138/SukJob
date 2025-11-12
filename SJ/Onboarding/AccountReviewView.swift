//
//  AccountReviewView.swift
//  SJ
//
//  Created by colin black on 12/11/2568 BE.
//

// Views/Onboarding/AccountReviewView.swift

import SwiftUI

struct AccountReviewView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    @State private var goToNextStep = false
    // ตัวแปรสำหรับฟอร์มที่อนุญาตให้ผู้ใช้แก้ไข
    @State private var phoneNumber: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("ตรวจสอบข้อมูลบัญชี (6/8)")
                .font(.title2)
                .bold()
            
            Text("กรุณาตรวจสอบและแก้ไขข้อมูลที่อ่านจากบัตรประชาชนให้ถูกต้อง")
                .font(.subheadline)
                .multilineTextAlignment(.center)
            
            Form {
                // ส่วนข้อมูลที่มาจาก OCR (แสดงผลใน ocrData)
                Section(header: Text("ข้อมูลที่อ่านจากบัตรประชาชน")) {
                    InfoRow(label: "เลขบัตรประชาชน", value: $viewModel.ocrData.idCardNumber)
                    InfoRow(label: "ชื่อ-นามสกุล", value: .constant("\(viewModel.ocrData.title) \(viewModel.ocrData.firstName) \(viewModel.ocrData.lastName)"))
                    InfoRow(label: "วัน/เดือน/ปีเกิด", value: $viewModel.ocrData.dateOfBirth)
                    InfoRow(label: "ที่อยู่ตามบัตร", value: $viewModel.ocrData.address)
                }
                
                // ช่องกรอกเพิ่มเติม
                Section(header: Text("ข้อมูลติดต่อ")) {
                    TextField("เบอร์โทรศัพท์ (จำเป็น)", text: $phoneNumber)
                        .keyboardType(.phonePad)
                }
            }
            
            // ปุ่มดำเนินการต่อ
            Button("ดำเนินการต่อ") {
                // บันทึกข้อมูลที่แก้ไข และเตรียมไปหน้า 7 (ตาม Role)
                viewModel.savePersonalInfo(phoneNumber: phoneNumber)
                goToNextStep = true
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(!phoneNumber.isEmpty ? Color.green : Color.gray)
            .foregroundColor(.white)
            .cornerRadius(10)
            .disabled(phoneNumber.isEmpty)
        }
        .onAppear {
            // เมื่อหน้านี้ปรากฏ ให้จำลองการประมวลผล OCR
            viewModel.performMockOCR()
        }
        .padding([.horizontal, .bottom])
        //.navigationTitle("ข้อมูลบัญชี")
        
        // MARK: - การนำทางไปหน้า 7 (ขึ้นอยู่กับ Role)
        .navigationDestination(isPresented: $goToNextStep) {
            if viewModel.userProfile.role == .employer {
                EmployerProfileView(viewModel: viewModel) // <--- ไปหน้า 7A
            } else {
                JobSeekerProfileView(viewModel: viewModel) // <--- ไปหน้า 7B
            }
        }
    }
}

// MARK: - Component สำหรับแสดงข้อมูลที่สามารถแก้ไขได้
struct InfoRow: View {
    let label: String
    @Binding var value: String
    
    var body: some View {
        HStack {
            Text(label)
                .frame(width: 120, alignment: .leading)
                .foregroundColor(.gray)
            // TextField เพื่อให้ผู้ใช้สามารถแตะเพื่อแก้ไขได้
            TextField("", text: $value)
        }
    }
}
