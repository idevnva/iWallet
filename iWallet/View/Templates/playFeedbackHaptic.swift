//
//  playFeedbackHaptic.swift
//  iWallet
//
//  Created by Владислав Новошинский on 15.04.2023.
//

import SwiftUI

public func playFeedbackHaptic(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
    let generator = UIImpactFeedbackGenerator(style: style)
    generator.impactOccurred()
}
