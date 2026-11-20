//
//  MonthPickerView.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import SwiftUI

struct MonthPickerView: View {
    @Binding var selection: Date
    let options: [Date]

    var body: some View {
        Menu {
            Picker("Month", selection: $selection) {
                ForEach(options, id: \.self) { month in
                    Text(month.monthName).tag(month)
                }
            }
        } label: {
            HStack(spacing: 12) {
                Text(selection.monthName)
                    .font(.system(size: 16))

                Image(systemName: "arrowtriangle.down.fill")
                    .font(.system(size: 9))
            }
            .foregroundStyle(Color.textSecondary)
            .padding(.horizontal, 10)
            .frame(height: 36)
            .overlay {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .strokeBorder(Color.fieldBorder)
            }
            .contentShape(Rectangle())
        }
        .accessibilityLabel("Month")
        .accessibilityValue(selection.monthName)
    }
}

#Preview {
    @Previewable @State var month = Date.now
    MonthPickerView(selection: $month, options: [month])
}
