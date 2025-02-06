//
//  StudentCell.swift
//  Students
//
//  Created by Andrew R Madsen on 4/18/22.
//

import SwiftUI

struct StudentCell: View {
    let student: Student

    var body: some View {
        VStack {
            Image(uiImage: student.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(student.name)
        }
    }
}

struct StudentCell_Previews: PreviewProvider {
    static var previews: some View {
        StudentCell(student: Student.allStudents[0])
            .frame(width: 150, height: 150)
    }
}
