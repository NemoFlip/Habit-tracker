//
//  ContentView.swift
//  Habit-tracking
//
//  Created by Артем Хлопцев on 05.08.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var showingSheet = false
    @ObservedObject var newActivity = AddActivity()
    var body: some View {
        NavigationView {
            List {
                ForEach(newActivity.activities) {activity in
                    NavigationLink(
                        destination: DetailView(activitie: newActivity, completed: activity.completedTimes, activity: activity)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(activity.name).fontWeight(.bold)
                                Text(activity.description).fontWeight(.medium).foregroundColor(.primary)
                            }
                            Spacer()
                            Text("\(activity.completedTimes) times").padding(.trailing)
                            
                        }
                    }
                }.onDelete(perform: removeItems)
            }
            .navigationBarTitle("Habit-tracking").navigationBarItems(leading: EditButton(), trailing: Button(action: {
                self.showingSheet.toggle()
            }, label: {
                Image(systemName: "plus")
            }).sheet(isPresented: $showingSheet, content: {
                AddActivityView(newActivity: newActivity)
            }))
        }
    }
    func removeItems(at offSets: IndexSet) {
        self.newActivity.activities.remove(atOffsets: offSets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
