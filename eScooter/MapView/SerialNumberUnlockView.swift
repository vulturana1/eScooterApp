//
//  UnlockViewSerialNumber.swift
//  eScooter
//
//  Created by Ana Vultur on 28.04.2022.
//

import SwiftUI
import Introspect

struct UnlockViewSerialNumber: View {
    
    @ObservedObject var viewModel: SerialNumberViewModel
    let onClose: () -> Void
    let onQr: () -> Void
    let onNFC: () -> Void
    let onStartRide: () -> Void
    @State var waiting = false
    
    init(viewModel: SerialNumberViewModel, onClose: @escaping () -> Void, onQr: @escaping () -> Void, onNFC: @escaping () -> Void, onStartRide: @escaping () -> Void) {
        self.viewModel = viewModel
        self.onClose = onClose
        self.onQr = onQr
        self.onNFC = onNFC
        self.onStartRide = onStartRide
    }
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                CloseButtonTopBar(title: "Enter serial number", color: .white) {
                    onClose()
                }
                Spacer()
                Text("Enter the scooter's serial number")
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
                textFields
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
                    Image("nfc")
                        .onTapGesture {
                            onNFC()
                        }
                }
                .padding()
                Spacer()
                
            }
            .padding(.top, 30)
            .padding()
            if waiting {
                Rectangle()
                    .foregroundColor(.black)
                    .opacity(0.4)
                    .ignoresSafeArea()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(3)
            }
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
    var textFields: some View {
        HStack(spacing: 10) {
            TextFieldNumber(number: $viewModel.first, isFirstResponder: viewModel.first.isEmpty)
            TextFieldNumber(number: $viewModel.second, isFirstResponder: (!viewModel.first.isEmpty && viewModel.second.isEmpty))
            TextFieldNumber(number: $viewModel.third, isFirstResponder: (!viewModel.first.isEmpty && !viewModel.second.isEmpty && viewModel.third.isEmpty))
            TextFieldNumber(number: $viewModel.forth, isFirstResponder: (!viewModel.first.isEmpty && !viewModel.second.isEmpty && !viewModel.third.isEmpty && viewModel.forth.isEmpty))
                .onChange(of: viewModel.forth, perform: { _ in
                    if !(viewModel.first.isEmpty && viewModel.second.isEmpty && viewModel.third.isEmpty && viewModel.forth.isEmpty) {
                        waiting = true
                        viewModel.unlockScooterSerialNumber({ scooter in
                            waiting = false
                            onStartRide()
                        }, { error in
                            viewModel.first = ""
                            viewModel.second = ""
                            viewModel.third = ""
                            viewModel.forth = ""
                            waiting = false
                            showError(error: error)
                        })
                    }
                })
        }
    }
}
struct TextFieldNumber: View {
    @Binding var number: String
    var isFirstResponder: Bool
    
    var body: some View {
        TextField("", text: $number)
            .frame(width: 52, height: 52)
            .foregroundColor(Color.init(red: 0.129, green: 0.043, blue: 0.314))
            .background(.white)
            .cornerRadius(15)
            .font(.custom("BaiJamjuree-Medium", size: 20))
            .multilineTextAlignment(.center)
            .introspectTextField { textfield in
                if isFirstResponder {
                    textfield.becomeFirstResponder()
                } else {
                    textfield.resignFirstResponder()
                }
            }
            .keyboardType(.numberPad)
    }
}


//struct UnlockViewSerialNumber_Previews: PreviewProvider {
//    static var previews: some View {
//        UnlockViewSerialNumber(onClose: {}, onQr: {}, onNFC: {})
//    }
//}
