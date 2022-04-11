//
//  DrivingLicenseView.swift
//  eScooter
//
//  Created by Ana Vultur on 06.04.2022.
//

import SwiftUI

struct DrivingLicenseView: View {
    @State var showingOptions = false
    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentActionScheet = false
    @State private var shouldPresentCamera = false
    @State private var image: Image? = Image("")
    @State private var recognizedText = "Tap button to start scanning"
    
    let onBack: () -> Void
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 20) {
                Spacer()
                BackButtonTopBar(title: "Driving License", color: .init(red: 0.129, green: 0.043, blue: 0.314)) {
                    onBack()
                }
                Image("driving-license")
                    .resizable()
                    .scaledToFill()
                Text("Before you can start riding")
                    .font(.custom("BaiJamjuree-Bold", size: 32))
                    .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
                    .padding(.leading)
                    .padding(.trailing)
                Text("Please take a photo or upload the front side of your driving license so we can make sure that it is valid.")
                    .font(.custom("BaiJamjuree-Medium", size: 16))
                    .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
                    .padding(.leading)
                    .padding(.trailing)
                Spacer()
                addDrivingLicenseButton
                Spacer()
            }
        }
    }
    
    var addDrivingLicenseButton: some View {
        Button {
            showingOptions = true
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
        .padding()
//        .actionSheet(isPresented: $showingOptions) {
//                        ActionSheet(
//                            title: Text("Select one method"),
//                            buttons: [
//                                .default(Text("Take a picture")) {
//                                    //ScanDocumentView(recognizedText: self.$recognizedText)
//                                },
//                                .default(Text("Upload a picture")) {
//
//                                },
//                            ]
//                        )
//                    }
        
        .sheet(isPresented: $showingOptions) {
                        ScanDocumentView(recognizedText: self.$recognizedText)
            
                    }
//        .sheet(isPresented: $showingOptions) {
//                        SUImagePickerView(sourceType: self.shouldPresentCamera ? .camera : .photoLibrary, image: self.$image, isPresented: self.$shouldPresentImagePicker)
//                }.actionSheet(isPresented: $shouldPresentActionScheet) { () -> ActionSheet in
//                    ActionSheet(title: Text("Choose mode"), message: Text("Please choose your preferred mode to set your profile image"), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
//                        self.shouldPresentImagePicker = true
//                        self.shouldPresentCamera = true
//                    }), ActionSheet.Button.default(Text("Photo Library"), action: {
//                        self.shouldPresentImagePicker = true
//                        self.shouldPresentCamera = false
//                    }), ActionSheet.Button.cancel()])
//                }
    }
}

struct DrivingLicenseView_Previews: PreviewProvider {
    static var previews: some View {
        DrivingLicenseView(onBack: {})
    }
}
