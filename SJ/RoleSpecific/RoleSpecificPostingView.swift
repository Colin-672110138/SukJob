//
//  RoleSpecificPostingView.swift
//  SJ
//
//  Created by colin black on 12/11/2568 BE.
//

// Views/RoleSpecific/RoleSpecificPostingView.swift

// Views/RoleSpecific/RoleSpecificPostingView.swift

import SwiftUI

struct RoleSpecificPostingView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        Group {
            if viewModel.userProfile.role == .employer {
                // เนื้อหาสำหรับ 'ผู้จ้างงาน' (หน้าโพสต์งานใหม่)
                Text("➕ โพสต์งานใหม่")
            } else {
                // เนื้อหาสำหรับ 'ผู้หางาน' (หน้าดูประกาศทั้งหมด)
                Text("📋 ดูประกาศงานทั้งหมด")
            }
        }
    }
}
