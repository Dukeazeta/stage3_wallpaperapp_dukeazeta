import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/wallpaper_provider.dart';

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({super.key});

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
                      'assets/icons/app_logo.svg',
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
                            'assets/icons/grid_nine_browse.svg',
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
                            'assets/icons/gear_six.svg',
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
              child: Consumer<WallpaperProvider>(
                builder: (context, provider, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ShaderMask(
                                  shaderCallback: (bounds) => const LinearGradient(
                                    colors: [Color(0xFFFBB03B), Color(0xFFEC0C43)],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ).createShader(bounds),
                                  child: const Text(
                                    'Browse Categories',
                                    style: TextStyle(
                                      fontFamily: 'Clash Display',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 60,
                                      height: 1.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              // View Toggle
                              Consumer<WallpaperProvider>(
                                builder: (context, provider, child) {
                                  return GestureDetector(
                                    onTap: provider.toggleViewMode,
                                    child: SvgPicture.asset(
                                      provider.viewMode == ViewMode.grid
                                          ? 'assets/icons/view_toggle_grid_active.svg'
                                          : 'assets/icons/view_toggle_list_active.svg',
                                      width: 87,
                                      height: 40,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Explore our curated collections of stunning wallpapers',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF575757),
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      // Categories Grid or List
                      Consumer<WallpaperProvider>(
                        builder: (context, provider, child) {
                          if (provider.viewMode == ViewMode.grid) {
                            return _buildGridView(context, provider);
                          } else {
                            return _buildListView(context, provider);
                          }
                        },
                      ),
                    ],
                  );
                },
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

  Widget _buildGridView(BuildContext context, WallpaperProvider provider) {
    return Wrap(
      spacing: 20,
      runSpacing: 23,
      children: WallpaperCategory.values.map((category) {
        return SizedBox(
          width: (MediaQuery.of(context).size.width - 94 - 40) / 3, // Account for padding and spacing
          child: _buildCategoryCard(context, category),
        );
      }).toList(),
    );
  }

  Widget _buildListView(BuildContext context, WallpaperProvider provider) {
    return Column(
      children: [
        _buildListCategoryCard(context, WallpaperCategory.nature),
        const SizedBox(height: 20),
        _buildListCategoryCard(context, WallpaperCategory.abstract),
        const SizedBox(height: 20),
        _buildListCategoryCard(context, WallpaperCategory.urban),
        const SizedBox(height: 20),
        _buildListCategoryCard(context, WallpaperCategory.space),
        const SizedBox(height: 20),
        _buildListCategoryCard(context, WallpaperCategory.minimalist),
        const SizedBox(height: 20),
        _buildListCategoryCard(context, WallpaperCategory.animals),
      ],
    );
  }

  Widget _buildCategoryCard(BuildContext context, WallpaperCategory category) {
    return GestureDetector(
      onTap: () {
        // Navigate to category wallpapers
      },
      child: Container(
        width: double.infinity,
        height: 290.71,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          image: DecorationImage(
            image: AssetImage(category.backgroundImage),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withValues(alpha: 0.3),
              BlendMode.darken,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              offset: const Offset(0, 4),
              blurRadius: 10,
            ),
          ],
        ),
        child: Stack(
          children: [
            // Content
            Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    category.displayName,
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Expanded(
                    child: Text(
                      category.description,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        height: 1.5,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.5),
                        width: 0.5,
                      ),
                    ),
                    child: Text(
                      '${category.wallpaperCount} wallpapers',
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
          ],
        ),
      ),
    );
  }

  Widget _buildListCategoryCard(BuildContext context, WallpaperCategory category) {
    return GestureDetector(
      onTap: () {
        // Navigate to category wallpapers
      },
      child: Container(
        width: double.infinity,
        height: 185.12,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image
            Container(
              width: MediaQuery.of(context).size.width * 0.3, // 30% of screen width
              height: 185.12,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.56),
                image: DecorationImage(
                  image: AssetImage(category.backgroundImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 20),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    category.displayName,
                    style: GoogleFonts.poppins(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    category.description,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 19),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF878787).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.black.withValues(alpha: 0.05),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      '${category.wallpaperCount} wallpapers',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}