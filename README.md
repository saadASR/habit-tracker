# Habit Tracker - Premium Flutter App

A production-ready,Habit tracking application built with Flutter. This app demonstrates advanced UI engineering, fluid animations, clean architecture, and thoughtful UX design.

## Features

### Core Functionality
- **Habit Management**: Create, edit, and delete habits with custom icons, colors, and categories
- **Daily Tracking**: Mark habits as completed with satisfying micro-interactions
- **Streak System**: Track current streak, longest streak, and total completions
- **Calendar Heatmap**: GitHub-style contribution graph showing consistency over time
- **Analytics**: Detailed progress visualization with time-range filters (7/30/90 days)

### UI/UX Highlights
- **Animated Splash Screen**: Logo reveal animation on app launch
- **Onboarding Flow**: 3-screen introduction explaining app features
- **Home Dashboard**: Greeting header, progress overview, animated progress rings
- **Habit Cards**: Custom animated completion toggles with streak badges (separate tap zones for toggle and details)
- **Premium Design**: Rounded corners, subtle shadows, elegant gradients

### Customization
- **Theme Color Picker**: Choose from 3 beautiful color themes (Teal, Pink, Light Blue)
- **Dark/Light Mode**: Full theme support with smooth transitions

### Additional Features
- **Local Notifications**: Scheduled habit reminders with motivational messages
- **Data Persistence**: Hive-based local storage (no backend required)
- **Sample Data**: App comes pre-seeded with demo habits for showcasing

## Architecture

### Clean Architecture
```
lib/
├── core/
│   ├── constants/      # App colors, spacing, durations
│   ├── theme/          # Light/dark theme definitions
│   └── widgets/        # Reusable UI components
├── features/
│   ├── onboarding/     # Splash & onboarding screens
│   ├── home/           # Dashboard & navigation
│   ├── habit/          # Create/edit habit screens
│   ├── calendar/       # Heatmap visualization
│   ├── analytics/      # Progress analytics
│   └── settings/       # App preferences
├── models/             # Data models (Habit, Completion, Settings)
├── services/           # Hive, Notifications, Streak logic
└── main.dart           # App entry point
```

### State Management
- **Riverpod** for reactive state management
- Provider pattern for dependency injection
- StateNotifier for complex state handling

## Dependencies

- `flutter_riverpod`: State management
- `hive_flutter`: Local persistence
- `flutter_local_notifications`: Local reminders
- `animations`: Page transitions
- `shimmer`: Loading states
- `intl`: Date formatting

## Getting Started

### Prerequisites
- Flutter SDK 3.x
- Android SDK / Xcode (for iOS)

### Installation

1. Clone the repository
```bash
git clone <repository-url>
cd habit_tracker
```

2. Install dependencies
```bash
flutter pub get
```

3. Run the app
```bash
flutter run
```

### Building APK

```bash
# Debug build
flutter build apk --debug

# Release build
flutter build apk --release
```

The debug APK will be at: `build/app/outputs/flutter-apk/app-debug.apk`

## Screens

The app includes these key screens:
- **Splash Screen**: Animated logo reveal with theme color
- **Onboarding**: 3 screens introducing streaks, progress, and motivation
- **Home Dashboard**: Today's overview, progress rings, habit list, motivational quote
- **Habit Details**: Analytics, streak history, weekly chart
- **Calendar Heatmap**: 12-week consistency visualization
- **Analytics**: Time-range filtered performance metrics
- **Settings**: Theme color picker, dark mode, notifications, data management

## Key Implementation Details

### Custom Animations
- `AnimatedProgressRing`: Custom painted circular progress indicator with smooth animations
- `HabitCard`: Scale animation on tap, completion transitions
- Staggered list animations on dashboard load
- Page transitions using Flutter's animation framework

### Theme Color System
- 3 beautiful color themes: Teal (default), Pink, Light Blue
- Dynamic color switching without app restart
- Colors apply to all UI elements consistently

### Streak Logic
- Correctly handles daily, weekdays, weekends, and custom frequencies
- Streak breaks only on missed scheduled days
- Longest streak calculation from completion history

### Heatmap Implementation
- 12-week grid showing daily completion intensity
- Color gradient from 0-100% completion
- Tap to view day details
- Filter by individual habit or all habits

## Future Improvements

- Cloud sync and backup
- Habit categories and grouping
- Widgets for home screen
- Export data to CSV/JSON
- Achievement badges
- Weekly/monthly reports
- Multi-language support

