//
//  Soul25App.swift
//  Soul25
//
//  Created by Zablon Charles on 4/14/24.
//
import Firebase
import SwiftUI

@main
struct Soul25App: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ViewController()
        }
    }
}
