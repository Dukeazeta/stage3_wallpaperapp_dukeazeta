import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/wallpaper_provider.dart';
import '../widgets/category_card.dart';
import '../widgets/navigation_bar.dart';
import 'wallpaper_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              child: Consumer<WallpaperProvider>(
                builder: (context, provider, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Hero Section
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
                              'Discover Beautiful Wallpapers',
                              style: TextStyle(
                                fontFamily: 'Clash Display',
                                fontWeight: FontWeight.w500,
                                fontSize: 60,
                                height: 1.0,
                                letterSpacing: 0.0,
                                color: Colors.white, // This will be replaced by the gradient
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: 600,
                            child: Text(
                              'Discover curated collections of stunning wallpapers. Browse by category, preview in full-screen, and set your favorites.',
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
                      // Categories Section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Categories',
                                style: GoogleFonts.poppins(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Navigate to all categories
                                },
                                child: Text(
                                  'See All',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF808080),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          // Category Grid
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 23,
                              childAspectRatio: 1.5,
                            ),
                            itemCount: WallpaperCategory.values.length,
                            itemBuilder: (context, index) {
                              final category = WallpaperCategory.values[index];
                              return CategoryCard(
                                category: category,
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => WallpaperDetailScreen(
                                        wallpaperName: '${category.displayName} 1',
                                        imagePath: category.backgroundImage,
                                        category: category.displayName,
                                        tags: [category.displayName, 'Ambience', 'Featured'],
                                        description: 'Discover the pure beauty of ${category.displayName} – your gateway to authentic, ${category.displayName.toLowerCase()}-inspired experiences. Let this unique collection elevate your senses and connect you with the unrefined elegance of the ${category.displayName.toLowerCase()} world.',
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
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
}