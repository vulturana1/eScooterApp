//
//  UnlockViewNFC.swift
//  eScooter
//
//  Created by Ana Vultur on 28.04.2022.
//

import SwiftUI

struct UnlockViewNFC: View {
    
    let onClose: () -> Void
    let onSerial: () -> Void
    let onQr: () -> Void
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                CloseButtonTopBar(title: "Unlock scooter", color: .white) {
                    onClose()
                }
                Spacer()
                Text("NFC unlock")
                    .font(.custom("BaiJamjuree-Bold", size: 32))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                Text("Hold your phone close to the NFC Tag located on top of the handlebar of your scooter.")
                    .font(.custom("BaiJamjuree-Medium", size: 16))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .opacity(0.7)
                    .padding()
                Image("nfc-1")
                Spacer()
                Text("Alternately you can unlock using")
                    .font(.custom("BaiJamjuree-Medium", size: 16))
                    .foregroundColor(.white)
                HStack(spacing: 20) {
                    Image("qr")
                        .onTapGesture {
                            onQr()
                        }
                    Text("or")
                        .font(.custom("BaiJamjuree-Medium", size: 16))
                        .foregroundColor(.white)
                    Image("serial")
                        .onTapGesture {
                            onSerial()
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

struct UnlockViewNFC_Previews: PreviewProvider {
    static var previews: some View {
        UnlockViewNFC(onClose: {}, onSerial: {}, onQr: {})
    }
}
