//
//  DrivingLicenseView.swift
//  eScooter
//
//  Created by Ana Vultur on 06.04.2022.
//

import SwiftUI

struct DrivingLicenseView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Spacer()
                Text("Driving License")
                    .font(.custom("BaiJamjuree-SemiBold", size: 17))
                    .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
                Spacer()
            }
            ZStack {
                Image("mask")
                Image("driving-license")
            }
            Text("Before you can start riding")
                .font(.custom("BaiJamjuree-Bold", size: 32))
                .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
            Text("Please take a photo or upload the front side of your driving license so we can make sure that it is valid.")
                .font(.custom("BaiJamjuree-Medium", size: 16))
                .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
            
            Spacer()
            
            addDrivingLicense
            
        }.padding()
    }
    
    var addDrivingLicense: some View {
        Button {
            
        } label: {
            HStack {
                Text("Add driving license")
                    .font(.custom("BaiJamjuree-SemiBold", size: 16))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56, alignment: .center)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.init(red: 0.898, green: 0.188, blue: 0.384), lineWidth: 2)
                    )
            }
            .background(Color.init(red: 0.898, green: 0.188, blue: 0.384))
            .cornerRadius(20)
        }
    }
}

struct DrivingLicenseView_Previews: PreviewProvider {
    static var previews: some View {
        DrivingLicenseView()
    }
}
