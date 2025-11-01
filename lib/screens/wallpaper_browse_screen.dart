import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/wallpaper_provider.dart';
import '../widgets/wallpaper_grid_item.dart';

class WallpaperBrowseScreen extends StatelessWidget {
  const WallpaperBrowseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Consumer<WallpaperProvider>(
          builder: (context, provider, child) {
            return Text(
              provider.selectedCategory?.displayName ?? 'Browse',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Search functionality
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              // Filter functionality
            },
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: Consumer<WallpaperProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
            children: [
              // Local wallpapers section
              if (provider.localWallpapers.isNotEmpty) ...[
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        offset: const Offset(0, 2),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Your Wallpapers',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          TextButton(
                            onPressed: provider.pickLocalWallpapers,
                            child: Text(
                              'Add More',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: const Color(0xFFFBB03B),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Local wallpapers grid
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 16 / 9,
                        ),
                        itemCount: provider.localWallpapers.length,
                        itemBuilder: (context, index) {
                          final wallpaperPath = provider.localWallpapers[index];
                          return WallpaperGridItem(
                            imagePath: wallpaperPath,
                            isFavorite: provider.isFavorite(wallpaperPath),
                            onFavoriteToggle: () => provider.toggleFavorite(wallpaperPath),
                            onTap: () {
                              // Preview wallpaper
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
              // Add wallpapers button
              if (provider.localWallpapers.isEmpty)
                Container(
                  margin: const EdgeInsets.all(16),
                  child: ElevatedButton.icon(
                    onPressed: provider.pickLocalWallpapers,
                    icon: const Icon(Icons.add_photo_alternate),
                    label: Text(
                      'Add Your Wallpapers',
                      style: GoogleFonts.poppins(),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFBB03B),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              // Placeholder for sample wallpapers
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No wallpapers yet',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Add your own wallpapers to get started',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
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

