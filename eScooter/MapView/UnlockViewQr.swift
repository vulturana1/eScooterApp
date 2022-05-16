//
//  UnlockViewQr.swift
//  eScooter
//
//  Created by Ana Vultur on 04.05.2022.
//

import SwiftUI

struct UnlockViewQr: View {
    
    let onClose: () -> Void
    let onSerial: () -> Void
    let onNfc: () -> Void
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                CloseButtonTopBar(title: "Unlock scooter", color: .white) {
                    onClose()
                }
                Spacer()
                Text("Scan QR")
                    .font(.custom("BaiJamjuree-Bold", size: 32))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                Text("You can find it on the scooter's front panel")
                    .font(.custom("BaiJamjuree-Medium", size: 16))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .opacity(0.7)
                    .padding()
                Spacer()
                Text("Alternately you can unlock using")
                    .font(.custom("BaiJamjuree-Medium", size: 16))
                    .foregroundColor(.white)
                HStack(spacing: 20) {
                    Image("serial")
                        .onTapGesture {
                            onSerial()
                        }
                    Text("or")
                        .font(.custom("BaiJamjuree-Medium", size: 16))
                        .foregroundColor(.white)
                    Image("nfc")
                        .onTapGesture {
                            onNfc()
                        }
                }
                .padding()
                Spacer()
            }
            .padding(.top, 30)
            .padding()
        }
    }
}

struct UnlockViewQr_Previews: PreviewProvider {
    static var previews: some View {
        UnlockViewQr(onClose: {}, onSerial: {}, onNfc: {})
    }
}
