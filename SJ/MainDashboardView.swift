//
//  MainDashboardView.swift
//  SJ
//
//  Created by colin black on 12/11/2568 BE.
//

// Views/MainDashboardView.swift

import SwiftUI

struct MainDashboardView: View {
    var body: some View {
        TabView {
            Text("หน้าหลัก (Dashboard)")
                .tabItem {
                    Label("หน้าหลัก", systemImage: "house.fill")
                }
            
            Text("หน้าโพสต์งาน/หางาน")
                .tabItem {
                    Label("ประกาศ", systemImage: "list.bullet.rectangle.fill")
                }
            
            Text("หน้าโปรไฟล์")
                .tabItem {
                    Label("โปรไฟล์", systemImage: "person.fill")
                }
        }
        .navigationTitle("แอปเกษตรลำไย")
        .navigationBarBackButtonHidden(true)
    }
}
