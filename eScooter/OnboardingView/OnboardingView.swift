//
//  OnboardingView.swift
//  eScooter
//
//  Created by Ana Vultur on 28.03.2022.
//

import SwiftUI

struct OnboardingView: View {
    @State var page = 0;
    let getStarted: () -> Void
    
    var body: some View {
        GeometryReader { geom in
            ZStack {
                content
                    .id(UUID())
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                    .animation(.easeInOut, value: page)
            }
            .padding(.top, -geom.safeAreaInsets.top)
        }
    }
    
    var content: some View {
        VStack {
            if page < onboardingData.count {
                VStack(spacing: 0) {
                    GeometryReader { geometry in
                        Image(onboardingData[page].image)
                            .resizable()
                            .scaledToFill()
                            .edgesIgnoringSafeArea(.all)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                    }
                    textContent
                }
            }
        }
    }
    
    var textContent: some View {
        ZStack {
            Color.white
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text(onboardingData[page].title)
                        .font(.custom("BaiJamjuree-Bold", size: 32))
                        .foregroundColor(Color.init(red: 0.129, green: 0.043, blue: 0.314))
                    Spacer()
                    Button {
                        
                    } label: {
                        Text("Skip")
                            .font(.custom("BaiJamjuree-SemiBold", size: 14))
                            .foregroundColor(Color.init(red: 0.698, green: 0.667, blue: 0.761))
                            .onTapGesture {
                                getStarted()
                            }
                    }
                }.padding()
                Text(onboardingData[page].text)
                    .font(.custom("BaiJamjuree-Medium", size: 16))
                    .foregroundColor(Color.init(red: 0.129, green: 0.043, blue: 0.314))
                    .padding(.horizontal)
                Spacer()
                HStack {
                    bottomBar
                    Spacer()
                    if page == 4 {
                        getStartedButton
                    } else {
                        nextButton
                    }
                    
                }
                .padding(.bottom, 40)
                .padding(.leading, 20)
                .padding(.trailing, 20)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    var rectangle: some View {
        Rectangle()
            .fill(Color.init(red: 0.129, green: 0.043, blue: 0.314))
            .frame(width: 16, height: 4)
            .cornerRadius(5)
    }
    
    var point: some View {
        Rectangle()
            .fill(Color.init(red: 0.698, green: 0.667, blue: 0.761))
            .frame(width: 4, height: 4)
            .cornerRadius(5)
    }
    
    var bottomBar: some View {
        HStack(spacing: 12) {
            ForEach(0 ..< 5) { i in
                if i == page {
                    rectangle
                } else {
                    point
                }
            }
        }
        .frame(width: 80, height: 4)
    }
    
    var nextButton: some View {
        Button {
            page += 1
        } label: {
            HStack {
                Text("Next")
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
    
    var getStartedButton: some View {
        Button {
            getStarted()
        } label: {
            HStack {
                Text("Get started")
                Image("arrow")
                    .renderingMode(.template)
                    .foregroundColor(.white)
            }
        }
        .frame(width: 153, height: 56)
        .foregroundColor(.white)
        .background(Color.init(red: 0.898, green: 0.188, blue: 0.384))
        .cornerRadius(16)
    }
}


struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(getStarted: {})
    }
}
