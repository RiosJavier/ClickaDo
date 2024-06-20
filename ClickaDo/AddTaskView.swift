//
//  AddTaskView.swift
//  ClickaDo
//
//  Created by Javier R on 6/20/24.
//

import SwiftUI


struct Task: Identifiable {
    var id = UUID()
    var title: String
    var isCompleted: Bool
}

struct AddTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var taskTitle: String = ""
    var addTask: (String) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Task Title", text: $taskTitle)
            }
            .navigationTitle("New Task")
            .navigationBarItems(trailing: Button("Save") {
                addTask(taskTitle)
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView { _ in }
    }
}
