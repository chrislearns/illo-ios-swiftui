//
//  Date+Extensions.swift
//  NewsApp
//
//  Created by Chris Guirguis on 10/7/21.
//

import SwiftUI

extension Date {
    static func getSalutation() -> String {
        let hour = Calendar.current.component(.hour, from: Date())

        switch hour {
        case 6..<12 : return "Good Morning"
        case 12..<18 : return "Good Afternoon"
        default: return "Good Evening"
        }
    }

}
