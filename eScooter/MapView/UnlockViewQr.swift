//
//  UnlockViewQr.swift
//  eScooter
//
//  Created by Ana Vultur on 04.05.2022.
//

import SwiftUI
import CodeScanner

struct UnlockViewQr: View {
    
    @ObservedObject var viewModel: SerialNumberViewModel
    let onClose: () -> Void
    let onSerial: () -> Void
    let onNfc: () -> Void
    let onStartRide: () -> Void
    
    init(viewModel: SerialNumberViewModel, onClose: @escaping () -> Void, onSerial: @escaping () -> Void, onNfc: @escaping () -> Void, onStartRide: @escaping () -> Void) {
        self.viewModel = viewModel
        self.onClose = onClose
        self.onSerial = onSerial
        self.onNfc = onNfc
        self.onStartRide = onStartRide
    }
    
    var body: some View {
        ZStack {
            CodeScannerView(codeTypes: [.qr]) { result in
                print(result)
                switch result {
                case .success(let code):
                    viewModel.unlockScooterQrCode(qrCode: code.string) { scooter in
                        onStartRide()
                    } _: { error in
                        showError(error: error)
                    }
                case .failure:
                    break
                }
               
            }
            .edgesIgnoringSafeArea(.all)
            
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
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.white,lineWidth: 2)
                    .padding()
                    .frame(height: 327)
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

//struct UnlockViewQr_Previews: PreviewProvider {
//    static var previews: some View {
//        UnlockViewQr(onClose: {}, onSerial: {}, onNfc: {})
//    }
//}
