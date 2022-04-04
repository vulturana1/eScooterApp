//
//  RegisterViewModel.swift
//  eScooter
//
//  Created by Ana Vultur on 01.04.2022.
//

import Foundation

class RegisterViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var username: String = ""
    @Published var password: String = ""
    
}
