import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/wallpaper_provider.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WallpaperProvider>(
      builder: (context, provider, child) {
        return Row(
          children: NavigationItem.values.map((item) {
            final isSelected = provider.selectedNav == item;
            return GestureDetector(
              onTap: () => provider.selectNavigationItem(item),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFF5F5F5) : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: isSelected
                      ? Border.all(
                          color: Colors.black.withValues(alpha: 0.1),
                          width: 1,
                        )
                      : null,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      item.iconPath,
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withValues(alpha: isSelected ? 1.0 : 0.5),
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      item.displayName,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black.withValues(alpha: isSelected ? 1.0 : 0.5),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}