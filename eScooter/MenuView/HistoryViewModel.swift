//
//  HistoryViewModel.swift
//  eScooter
//
//  Created by Ana Vultur on 03.05.2022.
//

import Foundation

class HistoryViewModel: ObservableObject {
    
    @Published var loading: Bool = false {
        didSet {
            if oldValue == false && loading == true {
                self.getAllTrips()
            }
        }
    }
    
    @Published var trips: [Trip] = []
    var length: Int = 10
    var start: Int = 0
    
    init() {
        getAllTrips()
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
}
