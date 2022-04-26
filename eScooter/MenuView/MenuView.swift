//
//  MenuView.swift
//  eScooter
//
//  Created by Ana Vultur on 11.04.2022.
//

import SwiftUI

struct MenuView: View {
    
    @ObservedObject var menuViewModel = MenuViewModel()
    let onBack: () -> Void
    let onAccountSettings: () -> Void
    let onChangePassword: () -> Void
    
    var body: some View {
        ZStack {
            Image("menu")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 40) {
                backButton
                historyButton
                generalSettings
                legal()
                rateUs
                Spacer()
            }
            .padding()
        }
    }
    
    var backButton: some View {
        HStack {
            Button {
                onBack()
            } label: {
                Image("left-arrow")
                    .renderingMode(.template)
                    .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
            }
            Spacer()
            let username = menuViewModel.customer?.customer.username ?? ""
            Text("Hi \(username)")
                .font(.custom("BaiJamjuree-SemiBold", size: 17))
                .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
            Spacer()
            Image("avatar")
        }
        .padding(.top, 30)
    }
    
    var historyButton: some View {
        ZStack {
            Image("background")
                .resizable()
                .frame(height: 112)
                .cornerRadius(30)
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text("History")
                        .font(.custom("BaiJamjuree-Bold", size: 16))
                        .foregroundColor(.white)
                    let trips = menuViewModel.customer?.customer.numberOfTrips ?? 0
                    Text("Total rides: \(trips)")
                        .font(.custom("BaiJamjuree-Medium", size: 16))
                        .foregroundColor(.white)
                        .opacity(0.7)
                }
                Spacer()
                seeAllButton
            }
            .padding()
        }
    }
    
    var seeAllButton: some View {
        Button {
            
        } label: {
            HStack {
                Text("See all")
                    .font(.custom("BaiJamjuree-Bold", size: 16))
                Image("arrow")
                    .renderingMode(.template)
                    .foregroundColor(.white)
            }
        }
        .frame(width: 100, height: 56)
        .foregroundColor(.white)
        .background(Color.init(red: 0.898, green: 0.188, blue: 0.384))
        .cornerRadius(16)
    }
    
    var generalSettings: some View {
        VStack(alignment: .leading, spacing: 25) {
            HStack {
                Image("settings")
                Text("General Settings")
                    .font(.custom("BaiJamjuree-Bold", size: 16))
                    .foregroundColor(Color.init(red: 0.129, green: 0.043, blue: 0.314))
            }
            Text("Account")
                .font(.custom("BaiJamjuree-Medium", size: 14))
                .foregroundColor(Color.init(red: 0.129, green: 0.043, blue: 0.314))
                .padding(.leading, 32)
                .onTapGesture {
                    onAccountSettings()
                }
            Text("Change Password")
                .font(.custom("BaiJamjuree-Medium", size: 14))
                .foregroundColor(Color.init(red: 0.129, green: 0.043, blue: 0.314))
                .padding(.leading, 32)
                .onTapGesture {
                    onChangePassword()
                }
        }
    }
    
    var rateUs: some View {
        VStack(alignment: .leading, spacing: 25) {
            HStack {
                Image("rate")
                Text("Rate Us")
                    .font(.custom("BaiJamjuree-Bold", size: 16))
                    .foregroundColor(Color.init(red: 0.129, green: 0.043, blue: 0.314))
            }
        }
    }
}

struct legal: View {
    @State var url = URL(string: "http://tapptitude.com")
    @State var termsPressed = false
    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            HStack {
                Image("legal")
                Text("Legal")
                    .font(.custom("BaiJamjuree-Bold", size: 16))
                    .foregroundColor(Color.init(red: 0.129, green: 0.043, blue: 0.314))
            }
            Text("Terms and Conditions")
                .font(.custom("BaiJamjuree-Medium", size: 14))
                .foregroundColor(Color.init(red: 0.129, green: 0.043, blue: 0.314))
                .padding(.leading, 32)
                .onTapGesture {
                    termsPressed = true
                }
                .sheet(isPresented: $termsPressed) {
                    SafariView(url: self.url!)
                }
            Text("Privacy Policy")
                .font(.custom("BaiJamjuree-Medium", size: 14))
                .foregroundColor(Color.init(red: 0.129, green: 0.043, blue: 0.314))
                .padding(.leading, 32)
                .onTapGesture {
                    termsPressed = true
                }
                .sheet(isPresented: $termsPressed) {
                    SafariView(url: self.url!)
                }
        }
    }
    
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(onBack: {}, onAccountSettings: {}, onChangePassword: {})
    }
}
