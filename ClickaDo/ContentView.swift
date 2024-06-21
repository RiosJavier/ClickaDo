//
//  ContentView.swift
//  ClickaDo
//
//  Created by Javier R on 6/19/24.
//

import SwiftUI

struct ContentView: View {
    @State private var tasks: [Task] = UserDefaults.standard.loadTasks() ?? [
        Task(title: "Buy groceries", isCompleted: false),
        Task(title: "Take a nap", isCompleted: false),
        Task(title: "Finish project", isCompleted: true)
    ]
    @State private var showingAddTaskView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(tasks) { task in
                    HStack {
                        Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                            .onTapGesture {
                                if let index = tasks.firstIndex(where: { $0.id == task.id }) {
                                    tasks[index].isCompleted.toggle()
                                    UserDefaults.standard.saveTasks(tasks)
                                }
                            }
                        Text(task.title)
                    }
                }
            }
            .navigationTitle("ClickaDo")
            .navigationBarItems(trailing: Button(action: {
                showingAddTaskView.toggle()
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showingAddTaskView) {
                AddTaskView { newTaskTitle in
                    let newTask = Task(title: newTaskTitle, isCompleted: false)
                    tasks.append(newTask)
                    UserDefaults.standard.saveTasks(tasks)
                }
            }
        }
    }
}

extension UserDefaults {
    private static let tasksKey = "tasksKey"
    
    func saveTasks(_ tasks: [Task]) {
        let data = try? JSONEncoder().encode(tasks)
        set(data, forKey: UserDefaults.tasksKey)
    }
    
    func loadTasks() -> [Task]? {
        guard let data = data(forKey: UserDefaults.tasksKey),
              let tasks = try? JSONDecoder().decode([Task].self, from: data) else {
            return nil
        }
        return tasks
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
