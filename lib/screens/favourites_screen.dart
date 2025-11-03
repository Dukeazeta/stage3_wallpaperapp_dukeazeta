import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/wallpaper_provider.dart';
import '../widgets/navigation_bar.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  // Sample wallpaper data matching the Figma design
  final List<Map<String, String>> _savedWallpapers = const [
    {'title': 'Nature 1', 'category': 'Nature', 'image': 'assets/images/nature1.png'},
    {'title': 'Nature 2', 'category': 'Nature', 'image': 'assets/images/nature2.png'},
    {'title': 'Nature 3', 'category': 'Nature', 'image': 'assets/images/nature3.png'},
    {'title': 'Nature 4', 'category': 'Nature', 'image': 'assets/images/nature4.png'},
    {'title': 'Nature 5', 'category': 'Nature', 'image': 'assets/images/nature5.png'},
    {'title': 'Nature 6', 'category': 'Nature', 'image': 'assets/images/nature6.png'},
    {'title': 'Nature 5', 'category': 'Nature', 'image': 'assets/images/nature5.png'},
    {'title': 'Nature 4', 'category': 'Nature', 'image': 'assets/images/nature4.png'},
    {'title': 'Nature 2', 'category': 'Nature', 'image': 'assets/images/nature2.png'},
    {'title': 'Nature 6', 'category': 'Nature', 'image': 'assets/images/nature6.png'},
    {'title': 'Nature 1', 'category': 'Nature', 'image': 'assets/images/nature1.png'},
    {'title': 'Nature 3', 'category': 'Nature', 'image': 'assets/images/nature3.png'},
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
                      'assets/icons/codemagic_app_logo.svg',
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
                const CustomNavigationBar(),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [Color(0xFFFBB03B), Color(0xFFEC0C43)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ).createShader(bounds),
                        child: const Text(
                          'Saved Wallpapers',
                          style: TextStyle(
                            fontFamily: 'Clash Display',
                            fontWeight: FontWeight.w500,
                            fontSize: 60,
                            height: 1.0,
                            letterSpacing: 0.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Your saved wallpapers collection',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF575757),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  // Wallpaper Grid
                  Column(
                    children: [
                      // First Row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(6, (index) {
                          final wallpaper = _savedWallpapers[index];
                          return _buildWallpaperCard(context, wallpaper, index == 5);
                        }),
                      ),
                      const SizedBox(height: 23),
                      // Second Row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(6, (index) {
                          final wallpaper = _savedWallpapers[index + 6];
                          return _buildWallpaperCard(context, wallpaper, index == 5);
                        }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWallpaperCard(BuildContext context, Map<String, String> wallpaper, bool isLast) {
    return Container(
      margin: EdgeInsets.only(right: isLast ? 0 : 20),
      child: Consumer<WallpaperProvider>(
          builder: (context, provider, child) {
            return Stack(
              fit: StackFit.passthrough,
              children: [
                // Main Card
                Container(
                  width: 190.18,
                  height: 290.71,
                  constraints: const BoxConstraints(
                    minWidth: 190.18,
                    maxWidth: 190.18,
                    minHeight: 290.71,
                    maxHeight: 290.71,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: AssetImage(wallpaper['image']!),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      children: [
                        // Dark overlay at bottom
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 99,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withValues(alpha: 0.3),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Text overlay at bottom
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  wallpaper['title']!,
                                  style: GoogleFonts.poppins(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                    height: 1.5,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 2,
                                  ),
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
                      ],
                    ),
                  ),
                ),
                // Heart button at top-right
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.5),
                        width: 0.5,
                      ),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/icons/heart_filled.svg',
                        width: 18,
                        height: 16,
                        colorFilter: const ColorFilter.mode(
                          Color(0xFFFFA821),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
  }
}

