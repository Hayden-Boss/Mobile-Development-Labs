//
//  StudentsApp.swift
//  Students
//
//  Created by Andrew R Madsen on 4/18/22.
//

import SwiftUI

@main
struct StudentsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(students: Student.allStudents)
        }
    }
}
