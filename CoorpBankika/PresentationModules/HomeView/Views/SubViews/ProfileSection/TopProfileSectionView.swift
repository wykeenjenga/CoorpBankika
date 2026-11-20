//
//  TopProfileSectionView.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import SwiftUI

struct TopProfileSectionView: View {
    let userName: String

    var body: some View {
        HStack(alignment: .center, spacing: 14) {
            Image(.profile)
                .resizable()
                .scaledToFill()
                .frame(width: 44, height: 44)
                .clipShape(Circle())
                .accessibilityHidden(true)

            Text("Welcome back, \(userName) 👋")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(Color.brandSecondary)
                .lineLimit(1)
                .minimumScaleFactor(0.8)

            Spacer(minLength: 8)

            ZStack(alignment: .center) {
                Circle()
                    .strokeBorder(Color.brandPrimary, lineWidth: 1.5)

                Image(systemName: "bell")
                    .font(.system(size: 18))
                    .foregroundStyle(Color.brandPrimary)
            }
            .frame(width: 44, height: 44)
            .accessibilityLabel("Notifications")
        }
    }
}

#Preview {
    TopProfileSectionView(userName: "John Doe")
        .padding()
}
