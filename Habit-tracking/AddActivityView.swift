//
//  AddActivityView.swift
//  Habit-tracking
//
//  Created by Артем Хлопцев on 05.08.2021.
//

import SwiftUI
struct HeadLineText: View {
    var text: String
    var body: some View {
        Text(text).textCase(.none).font(.subheadline)
    }
}
struct AddActivityView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var newActivity: AddActivity
    @State private var name = ""
    @State private var description = ""
    @State private var completedTimes = 0
    @State private var showingAlert = false
    var body: some View {
        NavigationView {
            Form {
                Section(header: HeadLineText(text: "Enter name of a habit")) {
                    TextField("Habit name", text: $name)
                }
                Section(header: HeadLineText(text: "Enter description of a habit")) {
                    TextField("Description", text: $description)
                }
                Section(header: HeadLineText(text: "Completed times")) {
                    Stepper("\(self.completedTimes) times", value: $completedTimes, in: 0...Int.max)
                }
            }
            .navigationBarTitle("Add New Activity").navigationBarItems(trailing: Button("Save") {
                let activity = Activity(name: self.name.capitalized, description: self.description.capitalized, completedTimes: self.completedTimes)
                if self.name != "" && self.description != "" {
                    newActivity.activities.append(activity)
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    self.showingAlert = true
                }
                    
            }.alert(isPresented: $showingAlert, content: {
                Alert(title: Text("Whoops..."), message: Text("You entered an emptry string"), dismissButton: .default(Text("Ok")) {
                    self.showingAlert = false
                    self.presentationMode.wrappedValue.dismiss()
                })
            }))
        }
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityView(newActivity: AddActivity())
    }
}
