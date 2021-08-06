//
//  Activity.swift
//  Habit-tracking
//
//  Created by Артем Хлопцев on 05.08.2021.
//

import Foundation

class AddActivity: ObservableObject {
    @Published var activities = [Activity]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(activities) {
                UserDefaults.standard.set(encoded, forKey: "act")
            }
        }
    }
    init() {
        if let activities = UserDefaults.standard.data(forKey: "act") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Activity].self, from: activities) {
                self.activities = decoded
                return
            }
        } else {
        self.activities = []
        }
    }
}

struct Activity: Identifiable, Codable {
    var id = UUID()
    var name: String
    var description: String
    var completedTimes: Int
    static func == (lhs: Activity, rhs: Activity) -> Bool {
        return lhs.id == rhs.id
    }
}
