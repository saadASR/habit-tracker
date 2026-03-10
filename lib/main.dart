import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';
import 'features/onboarding/presentation/screens/splash_screen.dart';
import 'features/onboarding/presentation/screens/onboarding_screen.dart';
import 'features/home/presentation/screens/main_navigation.dart';
import 'services/hive_service.dart';
import 'services/notification_service.dart';

// Global provider for theme mode
final themeProvider = StateNotifierProvider<ThemeNotifier, bool>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier() : super(HiveService.getSettings().isDarkMode);

  void setDarkMode(bool value) {
    state = value;
  }

  void toggle() {
    state = !state;
  }
}

// Global provider for theme type (color)
final themeTypeProvider = StateNotifierProvider<ThemeTypeNotifier, AppThemeType>((ref) {
  return ThemeTypeNotifier();
});

class ThemeTypeNotifier extends StateNotifier<AppThemeType> {
  ThemeTypeNotifier() : super(HiveService.getSettings().themeType) {
    AppColors.setTheme(state);
  }

  void setThemeType(AppThemeType type) {
    state = type;
    AppColors.setTheme(type);
  }
}

// Global refresh counter for forcing rebuilds
final refreshProvider = StateProvider<int>((ref) => 0);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

  // Initialize services
  await HiveService.init();
  await NotificationService.init();

  // Initialize theme
  final settings = HiveService.getSettings();
  AppColors.setTheme(settings.themeType);

  // Note: Sample data seeding removed for fresh start
  // To add sample data, uncomment: await HiveService.seedSampleData();

  runApp(const ProviderScope(child: HabitTrackerApp()));
}

class HabitTrackerApp extends ConsumerStatefulWidget {
  const HabitTrackerApp({super.key});

  @override
  ConsumerState<HabitTrackerApp> createState() => _HabitTrackerAppState();
}

class _HabitTrackerAppState extends ConsumerState<HabitTrackerApp> {
  @override
  Widget build(BuildContext context) {
    // Listen to theme type changes to rebuild app
    ref.listen(themeTypeProvider, (previous, next) {
      setState(() {});
    });

    final isDarkMode = ref.watch(themeProvider);

    return MaterialApp(
      title: 'Habit Tracker',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const AppEntryPoint(),
    );
  }
}

class AppEntryPoint extends StatefulWidget {
  const AppEntryPoint({super.key});

  @override
  State<AppEntryPoint> createState() => _AppEntryPointState();
}

class _AppEntryPointState extends State<AppEntryPoint> {
  bool _showSplash = true;
  bool _showOnboarding = false;

  @override
  void initState() {
    super.initState();
    _checkOnboarding();
  }

  void _checkOnboarding() {
    final settings = HiveService.getSettings();
    if (!settings.hasCompletedOnboarding) {
      setState(() {
        _showOnboarding = true;
      });
    }
  }

  void _onSplashComplete() {
    setState(() {
      _showSplash = false;
    });
  }

  void _onOnboardingComplete() async {
    final settings = HiveService.getSettings();
    await HiveService.saveSettings(settings.copyWith(hasCompletedOnboarding: true));
    setState(() {
      _showOnboarding = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showSplash) {
      return SplashScreen(onComplete: _onSplashComplete);
    }

    if (_showOnboarding) {
      return OnboardingScreen(onComplete: _onOnboardingComplete);
    }

    return const MainNavigation();
  }
}
