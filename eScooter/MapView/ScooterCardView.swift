//
//  ScooterCardView.swift
//  eScooter
//
//  Created by Ana Vultur on 22.04.2022.
//

import SwiftUI

struct ScooterCardView: View {
    var body: some View {
        ZStack {
            //background
            VStack {
                HStack {
                    Image("scooter")
                    VStack {
                        Text("Scooter")
                            .font(.custom("BaiJamjuree-Medium", size: 14))
                        Text("#AB23")
                            .font(.custom("BaiJamjuree-Bold", size: 20))
                        Text("Battery 66%")
                            .font(.custom("BaiJamjuree-Medium", size: 14))
                        HStack {
                            Image("ring")
                            ZStack {
                                Image("rect")
                                Image("location")
                            }
                        }
                    }
                }
                HStack {
                    Image("pin")
                    Text("Str. Avram Iancu nr. 26 Cladirea 2")
                        .font(.custom("BaiJamjuree-Medium", size: 14))
                }
                unlockButton
            }
        }
    }
    
    var unlockButton: some View {
        Button {
            
        } label: {
            HStack {
                Text("Unlock")
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

struct ScooterCardView_Previews: PreviewProvider {
    static var previews: some View {
        ScooterCardView()
    }
}
