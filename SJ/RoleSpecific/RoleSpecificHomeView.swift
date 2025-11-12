//
//  RoleSpecificHomeView.swift
//  SJ
//
//  Created by colin black on 12/11/2568 BE.
//

// Views/RoleSpecific/RoleSpecificHomeView.swift

// Views/RoleSpecific/RoleSpecificHomeView.swift

import SwiftUI

struct RoleSpecificHomeView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        Group {
            if viewModel.userProfile.role == .employer {
                // เนื้อหาสำหรับ 'ผู้จ้างงาน'
                Text("🏠 Dashboard ผู้จ้างงาน")
            } else {
                // เนื้อหาสำหรับ 'ผู้หางาน'
                Text("💼 Dashboard ผู้หางาน")
            }
        }
    }
}
