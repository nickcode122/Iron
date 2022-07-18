//
//  ViewRouter.swift
//  Iron
//
//  Created by Nick Schwab on 7/17/22.
//

import Foundation
enum AppView: Int {
    case templates, logs, list, settings
}

class ViewRouter: ObservableObject {
    @Published var currentView: AppView = .templates
    @Published var newWorkout: Workout? = nil
    @Published var workoutLinkActive = false
}
