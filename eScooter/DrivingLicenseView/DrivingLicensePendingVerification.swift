//
//  DrivingLicensePendingVerification.swift
//  eScooter
//
//  Created by Ana Vultur on 11.04.2022.
//

import SwiftUI

struct DrivingLicensePendingVerification: View {
    var body: some View {
        ZStack() {
            BackgroundView()
            VStack {
                Spacer()
                Text("We are currently verifying your driving license")
                    .foregroundColor(.white)
                    .font(.custom("BaiJamjuree-Bold", size: 32))
                    .multilineTextAlignment(.center)
                    .padding()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.5)
                Spacer()
            }
        }
    }
}

struct DrivingLicensePendingVerification_Previews: PreviewProvider {
    static var previews: some View {
        DrivingLicensePendingVerification()
    }
}
