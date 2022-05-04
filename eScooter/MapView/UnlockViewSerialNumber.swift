//
//  UnlockViewSerialNumber.swift
//  eScooter
//
//  Created by Ana Vultur on 28.04.2022.
//

import SwiftUI

struct UnlockViewSerialNumber: View {
    
    @ObservedObject var viewModel = SerialNumberViewModel()
    let onClose: () -> Void
    let onQr: () -> Void
    let onNFC: () -> Void
    
    private enum Field: Int, Hashable {
        case first, second, third, forth
    }
    @FocusState private var focusedField: Field?
    
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
        }
    }
    
//    var textField: some View {
//        TextField("", text: $number)
//            .frame(width: 52, height: 52)
//            .foregroundColor(Color.init(red: 0.129, green: 0.043, blue: 0.314))
//            .background(.white)
//            .cornerRadius(15)
//            .font(.custom("BaiJamjuree-Medium", size: 20))
//            .multilineTextAlignment(.center)
//    }
    
    var textFields: some View {
        HStack(spacing: 10) {
            TextFieldNumber(number: $viewModel.first)
                .focused($focusedField, equals: .first)
                .submitLabel(.next)
                .onSubmit {
                    focusedField = .second
                }
            TextFieldNumber(number: $viewModel.second)
                .focused($focusedField, equals: .second)
                .submitLabel(.next)
                .onSubmit {
                    focusedField = .third
                }
            TextFieldNumber(number: $viewModel.third)
                .focused($focusedField, equals: .third)
                .submitLabel(.next)
                .onSubmit {
                    focusedField = .forth
                }
            TextFieldNumber(number: $viewModel.forth)
                .focused($focusedField, equals: .forth)
                .submitLabel(.done)
                .onSubmit {
//                    guard viewModel.validate() else { return }
//                        viewModel.login()
                }
        }
        
    }
}
struct TextFieldNumber: View {
    @Binding var number: String
    var body: some View {
        TextField("", text: $number)
            .frame(width: 52, height: 52)
            .foregroundColor(Color.init(red: 0.129, green: 0.043, blue: 0.314))
            .background(.white)
            .cornerRadius(15)
            .font(.custom("BaiJamjuree-Medium", size: 20))
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
    }
}


struct UnlockViewSerialNumber_Previews: PreviewProvider {
    static var previews: some View {
        UnlockViewSerialNumber(onClose: {}, onQr: {}, onNFC: {})
    }
}
