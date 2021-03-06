//
//  HistoryViewModel.swift
//  eScooter
//
//  Created by Ana Vultur on 03.05.2022.
//

import Foundation

class HistoryViewModel: ObservableObject {
    
    @Published var customer: CustomerData?
    
    @Published var loading: Bool = false {
        didSet {
            if oldValue == false && loading == true {
                self.getAllTrips()
            }
        }
    }
    @Published var trips: [HistoryTrip] = []
    var length: Int = 10
    var start: Int = 0
    
    init() {
        getAllTrips()
        getUser()
    }
    
    func loadMore() {
        start = length
        length = length + 10
        getAllTrips()
    }
    
    func getAllTrips() {
        API.getAllTrips(start: start, length: length) { result in
            switch result {
            case .success(let trips):
                self.trips = trips.trips
                break
            case .failure(let error):
                showError(error: error)
                break
            }
        }
        self.loading = false
    }
    
    func getUser() {
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
