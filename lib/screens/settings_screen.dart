import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/wallpaper_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _selectedImageQuality = 'High ( Best Quality )';
  bool _notificationsEnabled = true;
  bool _isConnectedToDevice = true;

  final List<String> _imageQualityOptions = [
    'High ( Best Quality )',
    'Medium',
    'Low',
  ];

  @override
  void initState() {
    super.initState();
    // Ensure Settings navigation is selected when this screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final provider = Provider.of<WallpaperProvider>(context, listen: false);
        if (provider.selectedNav != NavigationItem.settings) {
          provider.selectNavigationItem(NavigationItem.settings);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(context),
            // Main Content
            Expanded(
              child: _buildMainContent(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 98,
      padding: const EdgeInsets.symmetric(horizontal: 47),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x10000000),
            offset: Offset(0, 1),
            blurRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo and Title
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
          // Navigation
          Consumer<WallpaperProvider>(
            builder: (context, provider, child) {
              return Row(
                children: [
                  _buildNavItem(
                    context,
                    'Home',
                    'assets/icons/grid_nine.svg',
                    isActive: provider.selectedNav == NavigationItem.home,
                    onTap: () => provider.selectNavigationItem(NavigationItem.home),
                  ),
                  const SizedBox(width: 12),
                  _buildNavItem(
                    context,
                    'Browse',
                    'assets/icons/grid_nine_browse.svg',
                    isActive: provider.selectedNav == NavigationItem.browse,
                    onTap: () => provider.selectNavigationItem(NavigationItem.browse),
                  ),
                  const SizedBox(width: 12),
                  _buildNavItem(
                    context,
                    'Favourites',
                    'assets/icons/heart.svg',
                    isActive: provider.selectedNav == NavigationItem.favourites,
                    onTap: () => provider.selectNavigationItem(NavigationItem.favourites),
                  ),
                  const SizedBox(width: 12),
                  _buildNavItem(
                    context,
                    'Settings',
                    'assets/icons/gear_six.svg',
                    isActive: provider.selectedNav == NavigationItem.settings,
                    onTap: () => provider.selectNavigationItem(NavigationItem.settings),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    String label,
    String iconPath, {
    bool isActive = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFF5F5F5) : Colors.transparent,
          border: isActive
              ? Border.all(
                  color: const Color(0x1A000000),
                  width: 1,
                )
              : null,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Opacity(
          opacity: isActive ? 1.0 : 0.5,
          child: Row(
            children: [
              SvgPicture.asset(
                iconPath,
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  Colors.black,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 47, right: 47, top: 50, bottom: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [
                    Color(0xFFFBB03B), // Orange
                    Color(0xFFEC0C43), // Red
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ).createShader(bounds),
                child: const Text(
                  'Settings',
                  style: TextStyle(
                    fontFamily: 'Clash Display',
                    fontSize: 60,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Customize your Wallpaper Studio experience',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF575757),
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
          // Settings Card and Phone Mockup
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Settings Card
              Expanded(
                flex: 2,
                child: _buildSettingsCard(context),
              ),
              const SizedBox(width: 214),
              // Phone Mockup
              Expanded(
                flex: 1,
                child: _buildPhoneMockup(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(35),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0x1A000000),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(36),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Wallpaper Setup Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Wallpaper Setup',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Configure your wallpaper settings and enable auto-rotation',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 26),
          // Image Quality Setting
          _buildImageQualitySetting(),
          const SizedBox(height: 16),
          // Notification Setting
          _buildNotificationSetting(),
          const SizedBox(height: 20),
          // Action Buttons
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildImageQualitySetting() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFE5E5E5),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Setting Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 191,
                  child: Text(
                    'Image Quality',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Dropdown
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFE5E5E5),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: DropdownButton<String>(
                    value: _selectedImageQuality,
                    isExpanded: true,
                    underline: const SizedBox(),
                    icon: SvgPicture.asset(
                      'assets/icons/down_arrow.svg',
                      width: 24,
                      height: 24,
                    ),
                    items: _imageQualityOptions.map((String quality) {
                      return DropdownMenuItem<String>(
                        value: quality,
                        child: Text(
                          quality,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF9C9C9C),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedImageQuality = newValue!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationSetting() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0x1A000000),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Setting Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Notification',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Get notified about new wallpapers and updates',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF9C9C9C),
                  ),
                ),
              ],
            ),
          ),
          // Toggle Switch
          GestureDetector(
            onTap: () {
              setState(() {
                _notificationsEnabled = !_notificationsEnabled;
              });
            },
            child: Container(
              width: 39,
              height: 22,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: _notificationsEnabled
                    ? const Color(0xFFFBB03B)
                    : const Color(0xFFD9D9D9),
                border: Border.all(
                  color: _notificationsEnabled
                      ? const Color(0xFFFFA821)
                      : Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 200),
                alignment: _notificationsEnabled
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Container(
                  width: 17,
                  height: 17,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(9),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Cancel Button
        Container(
          width: 200,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: const Color(0xFFDFDFDF),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(21),
          ),
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        // Save Settings Button
        Container(
          width: 200,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFFFBB03B),
            borderRadius: BorderRadius.circular(21),
          ),
          child: TextButton(
            onPressed: () {
              // Save settings logic here
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Settings saved successfully!'),
                  backgroundColor: Color(0xFFFBB03B),
                ),
              );
            },
            child: Text(
              'Save Settings',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneMockup(BuildContext context) {
    return SizedBox(
      width: 258,
      height: 525,
      child: Stack(
        children: [
          // Phone Frame (Outer border)
          Container(
            width: 258,
            height: 525,
            decoration: BoxDecoration(
              color: const Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(35.57),
            ),
          ),
          // Phone Screen (Inner white area)
          Positioned(
            left: 4.76,
            top: 2.48,
            child: Container(
              width: 248.51,
              height: 520.03,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                border: Border.all(
                  color: const Color(0xFFBABABA),
                  width: 3.31,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28.69),
                child: Stack(
                  children: [
                    // Phone Screen Background (white)
                    Positioned.fill(
                      child: Container(
                        color: Colors.white,
                      ),
                    ),
                    // Status Bar (black rectangle at top)
                    Positioned(
                      top: 17.27,
                      left: 92.83,
                      child: Container(
                        width: 72.36,
                        height: 20.88,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(26.47),
                        ),
                      ),
                    ),
                    // Notch/Camera (small circle)
                    Positioned(
                      top: 22.33,
                      left: 150.2,
                      child: Container(
                        width: 10.13,
                        height: 10.13,
                        decoration: const BoxDecoration(
                          color: Color(0xFF2A2A2A),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    // Device Connection Status
                    Positioned(
                      bottom: 240.5,
                      left: 38.52,
                      child: SizedBox(
                        width: 181,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Connection Indicator
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFCFFFC3),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/link_icon.svg',
                                    width: 24,
                                    height: 24,
                                    colorFilter: const ColorFilter.mode(
                                      Color(0xFF168200),
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: Text(
                                      'Connected to device',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF168200),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 11),
                            // Disconnect Button
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isConnectedToDevice = !_isConnectedToDevice;
                                });
                              },
                              child: Text(
                                'Click to disconnect',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF020202),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Home Indicator (bottom bar)
                    Positioned(
                      bottom: 6,
                      left: 86.99,
                      child: Container(
                        width: 84.05,
                        height: 2.58,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD9D9D9),
                          borderRadius: BorderRadius.circular(30.61),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}