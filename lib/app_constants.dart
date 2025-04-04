class AppConstants {
  // Private constructor to prevent instantiation
  AppConstants._();

  // App Information
  static const String appName = 'Instagram Tools';
  static const String appVersion = '1.0.0';

  // Storage Keys
  static const String themeKey = 'THEME_MODE';
  static const String gridUsesKey = 'GRID_USES_REMAINING';
  static const String firstLaunchKey = 'FIRST_LAUNCH';
  static const String userPremiumKey = 'USER_PREMIUM';

  // Feature Limitations
  static const int maxFreeGridUses = 5;
  static const int maxImagesInCarousel = 10;

  // Default Image Settings
  static const double defaultAspectRatio = 4 / 5; // Instagram recommended
  static const int defaultImageWidth = 1080;
  static const int defaultImageHeight = 1350;

  // Grid Settings
  static const int gridRows = 3;
  static const int gridColumns = 3;

  // Carousel Settings
  static const double defaultCarouselSpacing = 8.0;
  static const int minCarouselImages = 3;
  static const int maxCarouselImages = 5;

  // Animation Durations
  static const int splashDuration = 2000; // milliseconds
  static const int normalAnimationDuration = 300; // milliseconds
  static const int longAnimationDuration = 500; // milliseconds

  // API URLs (if needed for future integration)
  static const String termsUrl = 'https://example.com/terms';
  static const String privacyUrl = 'https://example.com/privacy';
  static const String helpUrl = 'https://example.com/help';

  // Assets Paths
  static const String logoPath = 'assets/images/logo.png';
  static const String placeholderImagePath = 'assets/images/placeholder.png';
  static const String gridIconPath = 'assets/icons/grid_icon.svg';
  static const String carouselIconPath = 'assets/icons/carousel_icon.svg';
}
