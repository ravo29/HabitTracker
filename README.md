# HabitTracker Pro

![Flutter](https://img.shields.io/badge/Flutter-3.2.0+-02569B?style=flat-square&logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.2.0+-0175C2?style=flat-square&logo=dart)
![License](https://img.shields.io/badge/license-MIT-green.svg)
![Platform](https://img.shields.io/badge/platform-iOS%20%7C%20Android-lightgrey)

A production-ready habit tracking application built with Flutter, designed to help users build healthy habits and maintain a balanced lifestyle through intuitive tracking, detailed statistics, and personalized reminders.

## 📱 Features

### Core Functionality
- **Habit Management**: Create, edit, and delete custom habits with flexible scheduling
- **Daily Tracking**: Mark habits as complete with intuitive check-in interface
- **Progress Visualization**: View streaks, completion rates, and detailed statistics
- **Calendar History**: Track habit completion over time with calendar view
- **Smart Reminders**: Customizable notifications to maintain consistency
- **Authentication**: Secure email/password and Google OAuth authentication
- **Multi-language Support**: French and English localization
- **Theme Customization**: Light, dark, and system theme modes

### User Experience
- **Onboarding Flow**: Guided introduction to app features
- **Responsive Design**: Optimized for various screen sizes and orientations
- **Smooth Animations**: Lottie animations and fluid transitions
- **Accessibility**: Semantic labels and screen reader support
- **Performance**: 60fps animations with optimized rebuilds

## 🏗️ Architecture

### Project Structure
```
lib/
├── core/
│   ├── constants/
│   │   └── app_theme.dart          # Theme definitions and color schemes
│   ├── l10n/
│   │   ├── app_fr.arb             # French translations
│   │   └── app_en.arb             # English translations
│   ├── routing/
│   │   └── app_router.dart        # Navigation configuration with go_router
│   └── services/
│       ├── auth_provider.dart     # Authentication state management
│       └── settings_providers.dart # Theme and locale providers
├── features/
│   ├── auth/
│   │   ├── presentation/
│   │   │   ├── auth_screen.dart
│   │   │   └── widgets/
│   │   │       ├── login_form.dart
│   │   │       └── register_form.dart
│   ├── habits/
│   │   ├── presentation/
│   │   │   ├── screens/
│   │   │   │   ├── home_screen.dart
│   │   │   │   ├── today_screen.dart
│   │   │   │   ├── statistics_screen.dart
│   │   │   │   └── add_edit_habit_screen.dart
│   │   │   ├── calendar_history_screen.dart
│   │   │   ├── habit_detail_screen.dart
│   │   │   ├── habit_form_screen.dart
│   │   │   └── widgets/
│   │   │       └── habit_card.dart
│   │   └── providers/
│   │       └── habits_provider.dart
│   ├── home/
│   │   └── presentation/
│   │       └── main_wrapper_screen.dart
│   ├── onboarding/
│   │   └── presentation/
│   │       └── onboarding_screen.dart
│   ├── settings/
│   │   └── presentation/
│   │       └── settings_screen.dart
│   └── splash/
│       └── presentation/
│           └── splash_screen.dart
└── main.dart
```

### Architecture Patterns
- **State Management**: Riverpod for reactive state management
- **Navigation**: go_router for declarative routing
- **Authentication**: Supabase Auth with OAuth support
- **Persistence**: SharedPreferences for local settings
- **Internationalization**: flutter_localizations with ARB files
- **Dependency Injection**: Riverpod providers for service injection

### Key Design Decisions
- **Feature-based organization**: Each feature is self-contained with its own presentation layer
- **Provider pattern**: Using Riverpod StateNotifier for complex state management
- **Responsive UI**: LayoutBuilder and MediaQuery for adaptive layouts
- **Type safety**: Strong typing throughout with Dart null safety
- **Separation of concerns**: Clear separation between UI, business logic, and data layers

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>= 3.2.0)
- Dart SDK (>= 3.2.0)
- Android Studio / Xcode for mobile development
- Supabase account for backend services
- Google OAuth credentials (optional)

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/yourusername/habittracker.git
cd habittracker
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Configure environment variables**
Create a `.env` file in the project root:
```env
SUPABASE_URL=your_supabase_project_url
SUPABASE_PUBLISHABLE_KEY=your_supabase_publishable_key
```

4. **Configure Supabase**
- Create a new project at [supabase.com](https://supabase.com)
- Enable Email authentication in your Supabase project
- Add Google OAuth provider (optional)
- Copy your project URL and publishable key to the `.env` file

5. **Run the app**
```bash
# For Android
flutter run

# For iOS
flutter run

# For web
flutter run -d chrome
```

### Building for Production

**Android APK**
```bash
flutter build apk --release
```

**Android App Bundle**
```bash
flutter build appbundle --release
```

**iOS IPA**
```bash
flutter build ios --release
```

## 🧪 Testing

### Run all tests
```bash
flutter test
```

### Run specific test suites
```bash
# Unit tests only
flutter test test/unit/

# Widget tests only
flutter test test/widget/

# Integration tests only
flutter test test/integration/
```

### Test coverage
```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

## 📊 Performance

### Optimization Techniques
- **Const constructors**: Extensive use of const widgets to prevent unnecessary rebuilds
- **Lazy loading**: Images and animations loaded on demand
- **Efficient state management**: Riverpod selectors for granular updates
- **Performance monitoring**: Flutter DevTools integration for profiling

### Benchmark Results
- **Frame rate**: Consistent 60fps on target devices
- **App size**: Optimized with code splitting and tree shaking
- **Startup time**: < 2 seconds cold start on mid-range devices

## 🔧 Configuration

### Environment Variables
| Variable | Description | Required |
|----------|-------------|----------|
| `SUPABASE_URL` | Supabase project URL | Yes |
| `SUPABASE_PUBLISHABLE_KEY` | Supabase anon/public key | Yes |

### Supported Locales
- French (fr) - Default
- English (en)

### Theme Options
- Light mode
- Dark mode
- System default

## 📱 Screenshots

### Authentication Flow
- Login screen with email/password and Google OAuth
- Registration with user metadata
- Secure session management

### Main Interface
- Today's habits with quick check-in
- Progress indicators and streaks
- Navigation between habit views

### Statistics & Analytics
- Completion rate charts
- Streak tracking
- Calendar history view

### Settings
- Theme customization
- Language selection
- Account management

## 🔒 Security

### Authentication
- Secure password hashing via Supabase
- OAuth 2.0 for Google Sign-In
- Session management with automatic token refresh

### Data Protection
- All communications encrypted via HTTPS
- Local data stored securely with SharedPreferences
- No sensitive data logged or cached

## 🤝 Contributing

Contributions are welcome! Please follow these guidelines:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Guidelines
- Follow Flutter/Dart style guide
- Write tests for new features
- Update documentation as needed
- Ensure all tests pass before submitting

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Supabase for the backend services
- Riverpod community for state management patterns
- LottieFiles for beautiful animations

## 📞 Support

For support, please open an issue in the GitHub repository or contact the development team.

## 🗺️ Roadmap

### Version 1.1.0 (Planned)
- [ ] Habit categories and tags
- [ ] Advanced statistics and insights
- [ ] Export data functionality
- [ ] Widget support for home screen

### Version 1.2.0 (Planned)
- [ ] Social features and habit sharing
- [ ] Cloud sync across devices
- [ ] Apple Watch companion app
- [ ] Custom themes and colors

---

**Built with ❤️ using Flutter**