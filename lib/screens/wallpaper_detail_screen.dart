import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/wallpaper_provider.dart';

class WallpaperDetailScreen extends StatefulWidget {
  final String wallpaperName;
  final String imagePath;
  final String category;
  final List<String> tags;
  final String description;

  const WallpaperDetailScreen({
    super.key,
    required this.wallpaperName,
    required this.imagePath,
    required this.category,
    this.tags = const [],
    this.description = '',
  });

  @override
  State<WallpaperDetailScreen> createState() => _WallpaperDetailScreenState();
}

class _WallpaperDetailScreenState extends State<WallpaperDetailScreen> {
  final List<Map<String, String>> relatedWallpapers = [
    {'name': 'Nature 1', 'image': 'assets/images/nature1.png', 'category': 'Nature'},
    {'name': 'Nature 2', 'image': 'assets/images/nature2.png', 'category': 'Nature'},
    {'name': 'Nature 3', 'image': 'assets/images/nature3.png', 'category': 'Nature'},
    {'name': 'Nature 4', 'image': 'assets/images/nature4.png', 'category': 'Nature'},
    {'name': 'Nature 5', 'image': 'assets/images/nature5.png', 'category': 'Nature'},
    {'name': 'Nature 6', 'image': 'assets/images/nature6.png', 'category': 'Nature'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 47, vertical: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0x0A000000),
                  offset: Offset(0, 1),
                  blurRadius: 0,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/codemagic.svg',
                      width: 16,
                      height: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Wallpaper Studio',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Consumer<WallpaperProvider>(
                  builder: (context, provider, child) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildNavItem(
                            context,
                            'Home',
                            'assets/icons/grid_nine.svg',
                            provider.selectedNav == NavigationItem.home,
                            () => provider.selectNavigationItem(NavigationItem.home),
                          ),
                          const SizedBox(width: 12),
                          _buildNavItem(
                            context,
                            'Browse',
                            'assets/icons/grid_nine_active.svg',
                            provider.selectedNav == NavigationItem.browse,
                            () => provider.selectNavigationItem(NavigationItem.browse),
                          ),
                          const SizedBox(width: 12),
                          _buildNavItem(
                            context,
                            'Favourites',
                            'assets/icons/heart.svg',
                            provider.selectedNav == NavigationItem.favourites,
                            () => provider.selectNavigationItem(NavigationItem.favourites),
                          ),
                          const SizedBox(width: 12),
                          _buildNavItem(
                            context,
                            'Settings',
                            'assets/icons/gear.svg',
                            provider.selectedNav == NavigationItem.settings,
                            () => provider.selectNavigationItem(NavigationItem.settings),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          // Main Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                left: 47,
                right: 47,
                top: 50,
                bottom: 30,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Section - Related Wallpapers
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Back Navigation
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/arrow_left.svg',
                                  width: 15.58,
                                  height: 15.17,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Back to Categories',
                                  style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF979797),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Category Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.category,
                              style: const TextStyle(
                                fontFamily: 'Clash Display',
                                fontSize: 48,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            SvgPicture.asset(
                              'assets/icons/category.svg',
                              width: 87,
                              height: 40,
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // Related Wallpapers Grid
                        _buildRelatedWallpapersGrid(),
                      ],
                    ),
                  ),
                  const SizedBox(width: 50),
                  // Right Section - Preview and Details
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(40),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            offset: const Offset(0, 4),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Preview Section
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Preview',
                                      style: GoogleFonts.poppins(
                                        fontSize: 32,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 37),
                                    _buildWallpaperDetails(),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 41),
                              _buildMainPreview(),
                            ],
                          ),
                          const SizedBox(height: 40),
                          // Action Buttons
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: const Color(0xFFDFDFDF),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(21),
                                  ),
                                  child: Consumer<WallpaperProvider>(
                                    builder: (context, provider, child) {
                                      final isFavorite = provider.isFavorite(widget.imagePath);
                                      return GestureDetector(
                                        onTap: () {
                                          provider.toggleFavorite(widget.imagePath);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                isFavorite ? 'Removed from favorites' : 'Added to favorites',
                                              ),
                                              duration: const Duration(seconds: 2),
                                            ),
                                          );
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/icons/heart.svg',
                                              width: 18,
                                              height: 16,
                                              colorFilter: ColorFilter.mode(
                                                isFavorite ? Colors.red : Colors.black,
                                                BlendMode.srcIn,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              isFavorite ? 'Remove from Favorites' : 'Save to Favorites',
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFBB03B),
                                    borderRadius: BorderRadius.circular(21),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Wallpaper set successfully!'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    },
                                    child: Center(
                                      child: Text(
                                        'Set to Wallpaper',
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, String title, String iconPath, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFF5F5F5) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: isActive ? Border.all(color: Colors.black.withOpacity(0.1)) : null,
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              iconPath,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                isActive ? Colors.black : Colors.black.withValues(alpha: 0.5),
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: isActive ? Colors.black : Colors.black.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRelatedWallpapersGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildRelatedWallpaperItem(relatedWallpapers[0]),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _buildRelatedWallpaperItem(relatedWallpapers[1]),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _buildRelatedWallpaperItem(relatedWallpapers[2]),
            ),
          ],
        ),
        const SizedBox(height: 23),
        Row(
          children: [
            Expanded(
              child: _buildRelatedWallpaperItem(relatedWallpapers[3]),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _buildRelatedWallpaperItem(relatedWallpapers[4]),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _buildRelatedWallpaperItem(relatedWallpapers[5]),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRelatedWallpaperItem(Map<String, String> wallpaper) {
    return GestureDetector(
      onTap: () {
        // Navigate to wallpaper detail
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => WallpaperDetailScreen(
              wallpaperName: wallpaper['name']!,
              imagePath: wallpaper['image']!,
              category: wallpaper['category']!,
              tags: ['Nature', 'Ambience', 'Flowers'],
              description: 'Discover the pure beauty of Natural Essence – your gateway to authentic, nature-inspired experiences.',
            ),
          ),
        );
      },
      child: Container(
        height: 290.71,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(wallpaper['image']!),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withValues(alpha: 0.3),
              BlendMode.darken,
            ),
          ),
        ),
        child: Stack(
          children: [
            // Content at bottom
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      wallpaper['name']!,
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        wallpaper['category']!,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Heart icon at top right
            Positioned(
              top: 12,
              right: 12,
              child: Consumer<WallpaperProvider>(
                builder: (context, provider, child) {
                  final isFavorite = provider.isFavorite(wallpaper['image']!);
                  return Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isFavorite
                          ? Colors.white.withValues(alpha: 0.2)
                          : Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.5),
                        width: 0.5,
                      ),
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/heart.svg',
                      width: 18,
                      height: 16,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainPreview() {
    return Column(
      children: [
        Container(
          width: 258.04,
          height: 524.99,
          decoration: BoxDecoration(
            color: const Color(0xFFD9D9D9),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Colors.black,
              width: 3.31,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(26.69),
            child: Image.asset(
              widget.imagePath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(
                      Icons.image,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 24.82),
        // Preview label
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'Preview',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWallpaperDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Name
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF808080),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.wallpaperName,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        // Tags
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tags',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF808080),
              ),
            ),
            const SizedBox(height: 4),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: widget.tags.map((tag) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFBFBFBF).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    tag,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
        const SizedBox(height: 30),
        // Description
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Description',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF808080),
              ),
            ),
            const SizedBox(height: 4),
            SizedBox(
              width: 280.81,
              child: Text(
                widget.description.isNotEmpty
                    ? widget.description
                    : 'Discover the pure beauty of "Natural Essence" – your gateway to authentic, nature-inspired experiences. Let this unique collection elevate your senses and connect you with the unrefined elegance of the natural world. Embrace "Natural Essence" for a truly organic transformation in your daily life.',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}