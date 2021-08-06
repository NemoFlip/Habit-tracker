//
//  DetailView.swift
//  Habit-tracking
//
//  Created by Артем Хлопцев on 06.08.2021.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var activitie: AddActivity
    @Environment(\.presentationMode) var presentationMode
    @State var completed: Int
    var activity: Activity
    var userCompleted = 0
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Edit a description of activity").textCase(.none)) {
                    Text(self.activity.description)
                }
                Section(header: Text("Change Complited Times").textCase(.none)) {
                    Stepper("\(completed) times", value: $completed)
                }
            }
            .navigationBarTitle(self.activity.name).navigationBarItems(trailing: Button("Save changes") {
                self.saveActivity()
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
    func saveActivity() {
        if let index = activitie.activities.firstIndex(where: {act in
            act == self.activity
        }) {
            self.activitie.activities.remove(at: index)
            self.activitie.activities.insert(Activity(name: self.activity.name, description: self.activity.description, completedTimes: self.completed), at: index)

        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(activitie: AddActivity(), completed: 1, activity: Activity(name: "Test", description: "Test", completedTimes: 2))
    }
}
