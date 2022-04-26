//
//  OnboardingData.swift
//  eScooter
//
//  Created by Ana Vultur on 28.03.2022.
//

import Foundation

struct OnboardingData {
    let image: String
    let title: String
    let text: String
}

let onboardingData = [OnboardingData(image: "safety", title: "Safety", text: "Please wear a helmet and protect yourself while riding"),
                      OnboardingData(image: "scan", title: "Scan", text: "Scan the QR code or NFC sticker on top of  the scooter to unlock and ride"),
                      OnboardingData(image: "ride", title: "Ride", text: "Step on the scooter with one foot and kick off the ground. When the scooter starts to coast, push the right throttle to accelerate."),
                      OnboardingData(image: "parking", title: "Parking", text: "If convenient, park at a bike rack. If not, park close to the edge of the sidewalk closest to the street. Do not block sidewalks, doors or ramps."),
                      OnboardingData(image: "rules", title: "Rules", text: "You must be 18 years or older with a valid driving license to operate a scooter. Please folloe all street signs, signals and markings, and obey local traffic laws.")]

