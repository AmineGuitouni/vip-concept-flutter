# VIP-Consept - Business Management Platform [![Non-Commercial License](https://img.shields.io/badge/License-NonCommercial-blue.svg)](LICENSE)

VIP-Consept is a comprehensive business management app that helps local businesses streamline operations with features like:
- 🔐 Firebase Authentication
- 💳 Stripe Payment Integration
- 📊 Business Analytics Dashboard
- ⭐ Customer Reviews System
- 🤖 AI-powered Insights
- 🎯 Promo Code Management
- 📱 Subscription Services

## 🚀 Getting Started

### Prerequisites
- Flutter SDK
- Firebase project
- Stripe account (for payments)

### Configuration
1. **Firebase Setup**:
   - Create Firebase project at [console.firebase.google.com](https://console.firebase.google.com)
   - Add Android/iOS apps to your Firebase project
   - Download configuration files:
     - Android: `google-services.json` → place in `android/app/`
     - iOS: `GoogleService-Info.plist` → place in `ios/Runner/`
   - Enable Firebase Authentication and Firestore

2. **Stripe Setup**:
   - Replace test publishable key in `lib/main.dart` with your live key:
     ```dart
     Stripe.publishableKey = "YOUR_STRIPE_PUBLISHABLE_KEY";
     ```

3. **Run the app**:
   ```bash
   flutter pub get
   flutter run
   ```

## 📁 Project Structure
```
lib/
├── core/         # Core utilities, themes, routing
├── features/     # Feature modules (auth, business, ai, etc.)
└── screens/      # Main application screens
```

## 📜 License
This project is licensed under the [Non-Commercial License](LICENSE).
- **You may**: Use, modify, and share the software for non-commercial purposes.
- **You may NOT**: Use the software for commercial purposes or claim ownership of the original work.

## 🔒 Sensitive Files
The following files are excluded from version control (see .gitignore):
- Firebase config files (`google-services.json`, `GoogleService-Info.plist`)
- Environment variables (`.env`)
- Android signing keys (`key.properties`, `*.keystore`, `*.jks`)

Always keep these files private!

## 🤝 Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss proposed changes.
