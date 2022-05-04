//
//  DrivingLicenseView.swift
//  eScooter
//
//  Created by Ana Vultur on 06.04.2022.
//

import SwiftUI

struct DrivingLicenseView: View {
    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentActionScheet = false
    @State private var shouldPresentCamera = false
    @State private var image: Image? = Image("")
    @State var waiting = false
    
    let onVerification: (Image) -> Void
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 20) {
                Spacer()
                TopBar(title: "Driving License", color: .init(red: 0.129, green: 0.043, blue: 0.314))
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
    
    var imageBinding: Binding<Image?> {
        return Binding(get: {
            Image("")
        }, set: { newImage in
            if let image = newImage {
                waiting = true
                onVerification(image)
            }
        })
    }
    
    var addDrivingLicenseButton: some View {
        Button {
            shouldPresentActionScheet = true
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
        .sheet(isPresented: $shouldPresentImagePicker) {
            SUImagePickerView(sourceType: .photoLibrary,
                              image: imageBinding, isPresented: $shouldPresentImagePicker)
        }
        .sheet(isPresented: $shouldPresentCamera) {
            ScanDocumentView(isPresented: $shouldPresentCamera, image: imageBinding)
        }
        .actionSheet(isPresented: $shouldPresentActionScheet) {
            actionSheet
        }
    }
    
    var actionSheet: ActionSheet {
        ActionSheet(title: Text("Select one method"),
                    buttons: [ActionSheet.Button.default(Text("Camera"), action: {
            self.shouldPresentImagePicker = false
            self.shouldPresentCamera = true
        }), ActionSheet.Button.default(Text("Photo Library"), action: {
            self.shouldPresentImagePicker = true
            self.shouldPresentCamera = false
        }), ActionSheet.Button.cancel({
            showError(error: "Please try again")
        })])
    }
}

struct DrivingLicenseView_Previews: PreviewProvider {
    static var previews: some View {
        DrivingLicenseView(onVerification: {_ in })
    }
}
