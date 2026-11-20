//
//  FormFieldView.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import SwiftUI

/// A small caption above a form input.
struct FormFieldView<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(Color.brandSecondary)

            content
        }
    }
}

#Preview {
    FormFieldView(title: "Item Name") {
        TextField("e.g. KFC Chicken", text: .constant(""))
            .outlinedField()
    }
    .padding()
}
