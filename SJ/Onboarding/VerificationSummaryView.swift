//
//  VerificationSummaryView.swift
//  SJ
//
//  Created by colin black on 12/11/2568 BE.
//

// Views/Onboarding/VerificationSummaryView.swift

import SwiftUI
import UIKit

struct VerificationSummaryView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var showingConfirmation = false

    var body: some View {
        VStack(spacing: 30) {
            Text("สรุปและยืนยันรูปภาพ (8/8)")
                .font(.title2)
                .bold()
            
            Text("กรุณาตรวจสอบรูปภาพเพื่อยืนยันตัวตนก่อนเข้าสู่ระบบ")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            // MARK: - แถบแสดงรูปภาพ 3 รูป
            VStack(spacing: 25) {
                SummaryImage(title: "บัตรประชาชนด้านหน้า", uiImage: viewModel.idCardFrontImage)
                SummaryImage(title: "บัตรประชาชนด้านหลัง", uiImage: viewModel.idCardBackImage)
                SummaryImage(title: "รูปถ่ายคู่บัตร", uiImage: viewModel.selfieWithIDImage)
            }
            
            
            // MARK: - ปุ่มยืนยัน
            // MARK: - ปุ่มยืนยัน
            Button("ยืนยันและดำเนินการต่อ") {
                            showingConfirmation = true
                        }
            // ลบ .padding(.top, 10) ออกจากตรงนี้ก่อน เพราะเรามี spacing ใน VStack หลักแล้ว
            // ลบ .frame(maxWidth: .infinity) ออก เพราะ .padding() ก็ทำให้ขยายเต็มอยู่แล้ว
            .frame(maxWidth: .infinity) // <<< ขยายปุ่มเต็มความกว้าง
                        .padding()
                        .background(Color.green) // <<< ใช้สีเขียวคงที่เพราะหน้านี้ไม่ต้องการ disabled
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        // ลบ .padding(.top, 10), .font(.headline), และ .shadow ออกเพื่อให้สไตล์เรียบง่ายและเป็นมาตรฐาน
        }
        .padding()
        //.navigationTitle("ยืนยันตัวตน")
        //.navigationBarBackButtonHidden(true)
        
        // MARK: - ข้อความเด้ง (Alert)
        .alert("ยืนยันตัวตนเรียบร้อย", isPresented: $showingConfirmation) {
            Button("ไปยังหน้าหลัก") {
                viewModel.isProfileFullyVerified = true // เปลี่ยนสถานะเพื่อนำทาง
            }
        } message: {
            Text("คุณสามารถเริ่มโพสต์งานหรือหางานได้ทันที")
        }
        
        // MARK: - การนำทางไปหน้าหลัก
        .navigationDestination(isPresented: $viewModel.isProfileFullyVerified) {
            MainDashboardView() // ไปยังหน้าหลัก
        }
    }
}

// MARK: - Component สำหรับแสดงรูปในหน้าสรุป
struct SummaryImage: View {
    let title: String
    let uiImage: UIImage?
    
    var body: some View {
        VStack(spacing: 8) {
            if let uiImage = uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 120)
                    .cornerRadius(8)
            } else {
                Image(systemName: "photo.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
                    .frame(height: 120)
                    .padding(10)
            }
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
}
