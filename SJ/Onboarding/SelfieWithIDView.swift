//
//  SelfieWithIDView.swift
//  SJ
//
//  Created by colin black on 12/11/2568 BE.
//

// Views/Onboarding/SelfieWithIDView.swift

// Views/Onboarding/SelfieWithIDView.swift

import SwiftUI
import PhotosUI
import UIKit // *** ต้อง import UIKit สำหรับ UIImage ***

struct SelfieWithIDView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    @State private var goToNextStep = false
    
    @State private var selfieItem: PhotosPickerItem?
    @State private var selfieImage: Image?

    var isReadyToProceed: Bool {
        // ตรวจสอบจาก UIImage ใน ViewModel
        return viewModel.selfieWithIDImage != nil
    }

    var body: some View {
        VStack(spacing: 30) {
            Text("ยืนยันตัวตน (5/8)") // อัปเดตเลขหน้า
                .font(.title2)
                .bold()
            
            Text("ขั้นตอนสุดท้าย! กรุณาถ่ายรูปใบหน้าคู่กับบัตรประชาชน เพื่อยืนยันว่าเป็นบุคคลเดียวกัน")
                .font(.subheadline)
                .multilineTextAlignment(.center)
            
            // MARK: - อัปโหลดรูปเซลฟี่
            PhotosPicker(selection: $selfieItem, matching: .images) {
                VStack(spacing: 8) {
                    if let image = selfieImage {
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .cornerRadius(8)
                    } else {
                        VStack {
                            Image(systemName: "person.badge.key.fill")
                                .font(.largeTitle)
                                .foregroundColor(.orange)
                            Text("แตะเพื่ออัปโหลดรูปถ่ายคู่บัตร")
                                .foregroundColor(.primary)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 250)
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray, lineWidth: 1)
                )
            }
            
            // MARK: - Logic บันทึกรูปภาพ (UIImage)
            .onChange(of: selfieItem) { newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: data) {
                        
                        selfieImage = Image(uiImage: uiImage)
                        self.viewModel.selfieWithIDImage = uiImage // <<< บันทึก UIImage
                    }
                }
            }

            Spacer()
            
            // ปุ่มดำเนินการต่อ
            Button("ดำเนินการต่อ") {
                if isReadyToProceed {
                    goToNextStep = true
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(isReadyToProceed ? Color.green : Color.gray)
            .foregroundColor(.white)
            .cornerRadius(10)
            .disabled(!isReadyToProceed)
        }
        .padding()
        //.navigationTitle("รูปถ่ายคู่บัตร")
        
        // MARK: - การนำทางไปหน้า 6
        .navigationDestination(isPresented: $goToNextStep) {
            AccountReviewView(viewModel: viewModel)
        }
    }
}
