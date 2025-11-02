import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../screens/home_screen.dart';
import '../screens/wallpaper_browse_screen.dart';
import '../screens/placeholder_screen.dart';

enum WallpaperCategory {
  nature('Nature', 'Mountains, Forest and Landscapes', 3, Color(0xFF4CAF50), 'assets/images/categories/nature_background.png'),
  abstract('Abstract', 'Modern Geomentric and artistic designs', 4, Color(0xFF9C27B0), 'assets/images/categories/abstract_background.png'),
  urban('Urban', 'Cities, architecture and street', 6, Color(0xFF2196F3), 'assets/images/categories/urban_background.png'),
  space('Space', 'Cosmos, planets, and galaxies', 3, Color(0xFF673AB7), 'assets/images/categories/space_background.png'),
  minimalist('Minimalist', 'Clean, simple, and elegant', 6, Color(0xFF607D8B), 'assets/images/categories/minimalist_background.png'),
  animals('Animals', 'Wildlife and nature photography', 4, Color(0xFFFF9800), 'assets/images/categories/animals_background.png');

  const WallpaperCategory(
    this.displayName,
    this.description,
    this.wallpaperCount,
    this.color,
    this.backgroundImage,
  );

  final String displayName;
  final String description;
  final int wallpaperCount;
  final Color color;
  final String backgroundImage;
}

enum NavigationItem {
  home('Home', 'assets/icons/grid_nine.svg'),
  browse('Browse', 'assets/icons/grid_nine_browse.svg'),
  favourites('Favourites', 'assets/icons/heart.svg'),
  settings('Settings', 'assets/icons/gear_six.svg');

  const NavigationItem(this.displayName, this.iconPath);
  final String displayName;
  final String iconPath;
}

class WallpaperProvider with ChangeNotifier {
  NavigationItem _selectedNav = NavigationItem.home;
  WallpaperCategory? _selectedCategory;
  final List<String> _favoriteWallpapers = [];
  final List<String> _localWallpapers = [];
  bool _isLoading = false;

  NavigationItem get selectedNav => _selectedNav;
  WallpaperCategory? get selectedCategory => _selectedCategory;
  List<String> get favoriteWallpapers => _favoriteWallpapers;
  List<String> get localWallpapers => _localWallpapers;
  bool get isLoading => _isLoading;

  void selectNavigationItem(NavigationItem item) {
    _selectedNav = item;
    notifyListeners();
  }

  void selectCategory(WallpaperCategory category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void toggleFavorite(String wallpaperPath) {
    if (_favoriteWallpapers.contains(wallpaperPath)) {
      _favoriteWallpapers.remove(wallpaperPath);
    } else {
      _favoriteWallpapers.add(wallpaperPath);
    }
    notifyListeners();
  }

  bool isFavorite(String wallpaperPath) {
    return _favoriteWallpapers.contains(wallpaperPath);
  }

  Future<void> pickLocalWallpapers() async {
    _isLoading = true;
    notifyListeners();

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
      );

      if (result != null) {
        _localWallpapers.addAll(result.paths.where((path) => path != null).cast<String>());
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error picking wallpapers: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearLocalWallpapers() {
    _localWallpapers.clear();
    notifyListeners();
  }

  Widget getScreenForNavigationItem(BuildContext context) {
    switch (_selectedNav) {
      case NavigationItem.home:
        return const HomeScreen();
      case NavigationItem.browse:
        return const WallpaperBrowseScreen();
      case NavigationItem.favourites:
        return const PlaceholderScreen(title: 'Favourites');
      case NavigationItem.settings:
        return const PlaceholderScreen(title: 'Settings');
    }
  }
}