//
//  LoginViewModel.swift
//  eScooter
//
//  Created by Ana Vultur on 04.04.2022.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    
}
