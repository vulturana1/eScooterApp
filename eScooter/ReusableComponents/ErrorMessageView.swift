//
//  ErrorMessageView.swift
//  eScooter
//
//  Created by Ana Vultur on 18.04.2022.
//

import SwiftUI
import SwiftMessages
import UIKit

public func showError(error: String) {
    SwiftMessages.show {
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(.error)
        view.configureDropShadow()
        view.layoutMargins = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
        view.configureContent(title: "Error", body: error, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: "Dismiss", buttonTapHandler: { _ in
            SwiftMessages.hide()
        })
        return view
    }
}

