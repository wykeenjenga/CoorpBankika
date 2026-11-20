# CoorpBankika

A SwiftUI budgeting app. Add an expense with a name, category and amount, and the home screen shows what's left of the monthly budget, this month's spend by category and your recent transactions. Everything is stored on the device with Core Data. There's no backend.

## Requirements

- Xcode 27
- iOS 17 or later

## Getting started

1. Clone the repo and open `CoorpBankika.xcodeproj`.
2. Make sure the SwiftyJSON package resolves. It's currently linked as a local package at `../../Desktop/CommonPackages/SwiftyJSON`, so either put SwiftyJSON there or swap it for `https://github.com/SwiftyJSON/SwiftyJSON` under **Package Dependencies**.
3. Pick a scheme and run.

## Environments

| Scheme | Bundle ID | Flag |
|---|---|---|
| CoorpBankika Dev | `com.wycliffnjenga.CoorpBankika.dev` | `DEV` |
| CoorpBankika UAT | `com.wycliffnjenga.CoorpBankika.uat` | `UAT` |
| CoorpBankika | `com.wycliffnjenga.CoorpBankika` | `PROD` |

Per-environment settings (Core Data store, default monthly budget, logging) live in `App/TargetConfiguration.swift`. Read them through `TargetConfiguration.shared`.

## Project layout

```
CoorpBankika/
├── App/                    App entry point, root view, TargetConfiguration
├── Business/
│   ├── Models/             BudgetItem, BudgetCategory (SwiftyJSON init(with:))
│   ├── Database/           Core Data model, entities and PersistenceController
│   └── Services/           BudgetStore, the single source of truth
├── PresentationModules/    One folder per screen (Models, ViewModels, Views)
│   ├── HomeTabView/        Custom tab bar
│   ├── HomeView/           Budget card, spend breakdown, recent transactions
│   └── AddBudget/          Add expense form and confirmation screen
├── Utitlities /            Extensions, styles, gradients
├── Others/PreviewData/     Sample data for SwiftUI previews
└── Resources/              Assets: colours, tab icons, transaction images
```

## Architecture

MVVM. View models are `@MainActor` `ObservableObject`s. `BudgetStore` publishes the saved expenses, and `HomeViewModel` subscribes with Combine to work out the remaining balance, monthly total and category split. Those figures are calculated from the stored expenses, not saved separately, so they always match the data.
