import 'package:get/get.dart';
import 'package:instapro/free_tools_binding.dart';
import 'package:instapro/free_tools_view.dart';
import 'package:instapro/grid_maker_binding.dart';
import 'package:instapro/grid_maker_view.dart';
import 'package:instapro/home_binding.dart';
import 'package:instapro/home_view.dart';
import 'package:instapro/reel_downloader_binding.dart';
import 'package:instapro/reel_downloader_view.dart';
import 'package:instapro/splash_binding.dart';
import 'package:instapro/splash_view.dart';
import 'package:instapro/story_downloader_binding.dart';
import 'package:instapro/story_downloader_view.dart';
import 'package:instapro/subscription_binding.dart';
import 'package:instapro/subscription_view.dart';
import 'package:instapro/carousel_maker_binding.dart';
import 'package:instapro/carousel_maker_view.dart';

part 'app_routes.dart';

class AppPages {
  // Private constructor to prevent instantiation
  AppPages._();

  // Initial route when app starts
  static const INITIAL = Routes.SPLASH;

  // All app routes defined here
  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.SUBSCRIPTION,
      page: () => const SubscriptionView(),
      binding: SubscriptionBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.FREE_TOOLS,
      page: () => const FreeToolsView(),
      binding: FreeToolsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.STORY_DOWNLOADER,
      page: () => const StoryDownloaderView(),
      binding: StoryDownloaderBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.REEL_DOWNLOADER,
      page: () => const ReelDownloaderView(),
      binding: ReelDownloaderBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.GRID_MAKER,
      page: () => const GridMakerView(),
      binding: GridMakerBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.CAROUSEL_MAKER,
      page: () => const CarouselMakerView(),
      binding: CarouselMakerBinding(),
      transition: Transition.rightToLeft,
    ),
    // Additional routes will be added as we build more features
  ];
}
