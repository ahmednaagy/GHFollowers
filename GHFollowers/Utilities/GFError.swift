//
//  GFError.swift
//  GHFollowers
//
//  Created by Ahmed Nagy on 13/04/2022.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername = "This username created an invalid request. Please try agian."
    case unableToComplete = "Unable to complete your request. Please check your Internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again"
}
