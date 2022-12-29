//
//  MenuSection.swift
//  TaskApp
//
//  Created by Junaid on 29/12/2022.
//

import Foundation
enum MenuSection: String, CaseIterable {
    case ongoing = "Ongoing"
    case done = "Done"

    var title: String {
        switch self {
        case .ongoing:
            return "Ongoing"
        case .done:
            return "Done"
        }
    }
}
