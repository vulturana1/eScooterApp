//
//  MenuViewModel.swift
//  eScooter
//
//  Created by Ana Vultur on 20.04.2022.
//

import Foundation

class MenuViewModel: ObservableObject {
    @Published var customer: CustomerData?
    
    init() {
        API.getCurrentCustomer({ result in
            switch result {
            case .success(let customer):
                self.customer = customer
                break
            case .failure(let error):
                showError(error: error)
                break
            }
        })
    }
}
