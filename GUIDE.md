# Mobile Wallpaper Selector - Task 2

## Project Overview
Design a clean and minimal web app that allows users to browse wallpapers by category, preview them, and set them as active wallpapers. The app should focus on strong visuals, smooth navigation, and a seamless browsing-to-activation experience.

## Figma Design
- **Design Link**: https://www.figma.com/design/WnHFPfZ7uW2vxy4sHqtb12/MOBILE-WALLPAPER-SELECTOR?node-id=28-81&t=1Q1FK8jNVLyvCcws-4

## Seven Core Pages Required

1. **Home Page (Before Selection)**  Wallpaper categories with preview thumbnails
2. **Dynamic Category Page**  Wallpapers in grid/list view
3. **Single Wallpaper View**  Full-screen preview with category tag
4. **Setup Page**  Options for activating, deactivating, and auto-rotation
5. **Home Page (After Selection)**  Shows active wallpaper + browsing option
6. **Favorites Page**  (optional, save preferred wallpapers)
7. **Settings / Profile Page**  for customization

## Deliverables

- Style guide: typography, colours, UI elements
- High-fidelity wireframes (at least 7 screens as specified above)

## Flutter Components Code

### 1. Radio Button Component

```dart
import 'package:flutter/material.dart';

class CustomRadioButton extends StatelessWidget {
  final bool isSelected;
  final ValueChanged<bool> onChanged;
  final String? label;

  const CustomRadioButton({
    Key? key,
    required this.isSelected,
    required this.onChanged,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!isSelected),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? const Color(0xFFFBB03B) : const Color(0xFFD8D8D8),
                width: 1,
              ),
            ),
            child: isSelected
                ? Center(
                    child: Container(
                      width: 18.6,
                      height: 18.6,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFFBB03B),
                      ),
                    ),
                  )
                : null,
          ),
          if (label != null) ...[
            const SizedBox(width: 8),
            Text(
              label!,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
```

### 2. Checkbox Component

```dart
import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final bool isChecked;
  final ValueChanged<bool> onChanged;
  final String? label;

  const CustomCheckbox({
    Key? key,
    required this.isChecked,
    required this.onChanged,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!isChecked),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 30.91,
            height: 30.91,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              border: Border.all(
                color: const Color(0xFFFBB03B),
                width: 1,
              ),
              color: isChecked ? const Color(0xFFFBB03B) : Colors.white,
            ),
            child: isChecked
                ? Center(
                    child: Container(
                      width: 19.49,
                      height: 19.49,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.62),
                        color: const Color(0xFFFBB03B),
                      ),
                    ),
                  )
                : null,
          ),
          if (label != null) ...[
            const SizedBox(width: 8),
            Text(
              label!,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
```

### 3. Status Badge Component

```dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum BadgeStatus { active, inactive }

class StatusBadge extends StatelessWidget {
  final BadgeStatus status;
  final String text;

  const StatusBadge({
    Key? key,
    required this.status,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isActive = status == BadgeStatus.active;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFC8FFBD) : const Color(0xFFEBEBEB),
        borderRadius: BorderRadius.circular(38),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isActive) ...[
            Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                size: 18,
                color: Color(0xFF1BA400),
              ),
            ),
            const SizedBox(width: 10),
          ],
          Text(
            text,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: isActive ? const Color(0xFF1BA400) : const Color(0xFF9C9C9C),
            ),
          ),
        ],
      ),
    );
  }
}
```

### 4. Toggle Switch Component

```dart
import 'package:flutter/material.dart';

class CustomToggleSwitch extends StatelessWidget {
  final bool isOn;
  final ValueChanged<bool> onChanged;

  const CustomToggleSwitch({
    Key? key,
    required this.isOn,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!isOn),
      child: Container(
        width: 78.54,
        height: 40,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: isOn ? const Color(0xFFFBB03B) : const Color(0xFFD8D8D8),
          borderRadius: BorderRadius.circular(15),
          border: isOn
              ? Border.all(
                  color: const Color(0xFFFFA821),
                  width: 1,
                )
              : null,
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: isOn ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 17.27,
            height: 17.27,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
```

### 5. Button Components

```dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum ButtonType { primary, secondary, icon }

class CustomButton extends StatelessWidget {
  final String text;
  final ButtonType type;
  final VoidCallback onPressed;
  final IconData? icon;
  final String? svgIconPath;

  const CustomButton({
    Key? key,
    required this.text,
    required this.type,
    required this.onPressed,
    this.icon,
    this.svgIconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? leadingWidget;

    if (type == ButtonType.icon && svgIconPath != null) {
      leadingWidget = SvgPicture.asset(
        svgIconPath!,
        width: 24,
        height: 24,
      );
    } else if (type == ButtonType.icon && icon != null) {
      leadingWidget = Icon(
        icon,
        size: 24,
        color: Colors.black,
      );
    }

    return SizedBox(
      width: 200,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: _getBackgroundColor(),
          foregroundColor: Colors.black,
          side: const BorderSide(
            color: Color(0xFFDFDFDF),
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(21),
          ),
          padding: const EdgeInsets.all(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leadingWidget != null) ...[
              leadingWidget,
              const SizedBox(width: 10),
            ],
            Text(
              text,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    switch (type) {
      case ButtonType.primary:
        return const Color(0xFFFBB03B);
      case ButtonType.secondary:
      case ButtonType.icon:
        return const Color(0xFFF8F8F8);
    }
  }
}
```

### 6. Usage Examples

```dart
import 'package:flutter/material.dart';

class ComponentDemo extends StatefulWidget {
  const ComponentDemo({Key? key}) : super(key: key);

  @override
  State<ComponentDemo> createState() => _ComponentDemoState();
}

class _ComponentDemoState extends State<ComponentDemo> {
  bool _radioSelected = false;
  bool _checkboxChecked = false;
  bool _toggleIsOn = false;
  BadgeStatus _badgeStatus = BadgeStatus.inactive;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Component Demo'),
        backgroundColor: const Color(0xFFFBB03B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Radio Buttons', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                CustomRadioButton(
                  isSelected: _radioSelected,
                  onChanged: (value) => setState(() => _radioSelected = value),
                  label: 'Option 1',
                ),
                const SizedBox(width: 20),
                CustomRadioButton(
                  isSelected: !_radioSelected,
                  onChanged: (value) => setState(() => _radioSelected = !value),
                  label: 'Option 2',
                ),
              ],
            ),

            const SizedBox(height: 24),
            const Text('Checkboxes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            CustomCheckbox(
              isChecked: _checkboxChecked,
              onChanged: (value) => setState(() => _checkboxChecked = value),
              label: 'Check me',
            ),

            const SizedBox(height: 24),
            const Text('Status Badges', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                StatusBadge(status: BadgeStatus.active, text: 'Active'),
                const SizedBox(width: 12),
                StatusBadge(status: BadgeStatus.inactive, text: 'Inactive'),
              ],
            ),

            const SizedBox(height: 24),
            const Text('Toggle Switch', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            CustomToggleSwitch(
              isOn: _toggleIsOn,
              onChanged: (value) => setState(() => _toggleIsOn = value),
            ),

            const SizedBox(height: 24),
            const Text('Buttons', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Column(
              children: [
                CustomButton(
                  text: 'Primary Button',
                  type: ButtonType.primary,
                  onPressed: () {},
                ),
                const SizedBox(height: 12),
                CustomButton(
                  text: 'Secondary Button',
                  type: ButtonType.secondary,
                  onPressed: () {},
                ),
                const SizedBox(height: 12),
                CustomButton(
                  text: 'Icon Button',
                  type: ButtonType.icon,
                  icon: Icons.download,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

### 7. Typography System

Based on the Figma design, here's the complete typography system:

#### Font Configuration
```yaml
# pubspec.yaml
flutter:
  fonts:
    - family: Poppins
      fonts:
        - asset: assets/fonts/Poppins-Regular.ttf
          weight: 400
        - asset: assets/fonts/Poppins-Medium.ttf
          weight: 500
        - asset: assets/fonts/Poppins-SemiBold.ttf
          weight: 600
        - asset: assets/fonts/Poppins-Bold.ttf
          weight: 700
        - asset: assets/fonts/Poppins-ExtraBold.ttf
          weight: 800

    - family: ClashDisplay
      fonts:
        - asset: assets/fonts/ClashDisplay-Regular.ttf
        - asset: assets/fonts/ClashDisplay-Bold.ttf
          weight: 700
```

#### Text Styles
```dart
import 'package:flutter/material.dart';

class AppTextStyles {
  // Primary Font: Poppins
  static const String primaryFont = 'Poppins';

  // Secondary Font: Clash Display
  static const String secondaryFont = 'ClashDisplay';

  // H1 - Primary heading (60px, Bold, Clash Display)
  static const TextStyle h1 = TextStyle(
    fontFamily: secondaryFont,
    fontSize: 60,
    fontWeight: FontWeight.w700,
    height: 1.23,
    color: Color(0xFFFFFFFF),
  );

  // H2 - Secondary heading (20px, Semi Bold, Poppins)
  static const TextStyle h2 = TextStyle(
    fontFamily: primaryFont,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.5,
    color: Color(0xFFFFFFFF),
  );

  // Body - Regular text (16px, Regular, Poppins)
  static const TextStyle body = TextStyle(
    fontFamily: primaryFont,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: Color(0xFFFFFFFF),
  );

  // Caption - Small text (12px, Medium, Poppins)
  static const TextStyle caption = TextStyle(
    fontFamily: primaryFont,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.5,
    color: Color(0xFFFFFFFF),
  );

  // Small label - Very small text (10px, Semi Bold, Poppins)
  static const TextStyle label = TextStyle(
    fontFamily: primaryFont,
    fontSize: 10,
    fontWeight: FontWeight.w600,
    height: 1.5,
    color: Color(0xFFFFFFFF),
  );

  // Extra Bold label (10px, Extra Bold, Poppins)
  static const TextStyle labelBold = TextStyle(
    fontFamily: primaryFont,
    fontSize: 10,
    fontWeight: FontWeight.w800,
    height: 1.5,
    color: Color(0xFFFFFFFF),
  );
}

class AppTypography {
  // Text theme for MaterialApp
  static TextTheme get textTheme => TextTheme(
    displayLarge: AppTextStyles.h1,
    displayMedium: AppTextStyles.h2,
    bodyLarge: AppTextStyles.body,
    bodySmall: AppTextStyles.caption,
    labelSmall: AppTextStyles.label,
  );

  // Custom text styles with color variations
  static TextStyle h1({Color? color}) => AppTextStyles.h1.copyWith(color: color);
  static TextStyle h2({Color? color}) => AppTextStyles.h2.copyWith(color: color);
  static TextStyle body({Color? color}) => AppTextStyles.body.copyWith(color: color);
  static TextStyle caption({Color? color}) => AppTextStyles.caption.copyWith(color: color);
  static TextStyle label({Color? color}) => AppTextStyles.label.copyWith(color: color);
}
```

#### Typography Usage Examples
```dart
import 'package:flutter/material.dart';

class TypographyDemo extends StatelessWidget {
  const TypographyDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFA821),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(33.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Typography Section Header
              Text(
                'Typography'.toUpperCase(),
                style: AppTextStyles.labelBold,
              ),
              const SizedBox(height: 12),

              // Font Information
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Primary Font: Poppins',
                    style: AppTextStyles.body,
                  ),
                  Text(
                    'Secondary Font: Clash Display',
                    style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w800),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              // Divider
              Container(
                height: 1,
                color: Colors.white.withOpacity(0.42),
              ),
              const SizedBox(height: 25),

              // Typography Examples Table
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text Style Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Text Style', style: AppTextStyles.label),
                        const SizedBox(height: 16),
                        Text('H1', style: AppTextStyles.label),
                        Text('H2', style: AppTextStyles.label),
                        Text('Body', style: AppTextStyles.label),
                        Text('Caption', style: AppTextStyles.label),
                      ],
                    ),
                  ),
                  const SizedBox(width: 37),

                  // Font Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Font', style: AppTextStyles.label),
                        const SizedBox(height: 16),
                        Text('Clash Display', style: AppTypography.h1()),
                        Text('Poppins', style: AppTypography.h2()),
                        Text('Poppins', style: AppTypography.body()),
                        Text('Poppins', style: AppTypography.caption()),
                      ],
                    ),
                  ),
                  const SizedBox(width: 37),

                  // Size Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Size', style: AppTextStyles.label),
                        const SizedBox(height: 16),
                        Text('60px', style: AppTypography.h1()),
                        Text('20px', style: AppTypography.h2()),
                        Text('16px', style: AppTypography.body()),
                        Text('12px', style: AppTypography.caption()),
                      ],
                    ),
                  ),
                  const SizedBox(width: 37),

                  // Weight Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Weight', style: AppTextStyles.label),
                        const SizedBox(height: 16),
                        Text('Bold', style: AppTypography.h1()),
                        Text('Semi bold', style: AppTypography.h2()),
                        Text('Regular', style: AppTypography.body()),
                        Text('Medium', style: AppTypography.caption()),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

#### Typography Widget Helper
```dart
import 'package:flutter/material.dart';

enum AppTextType { h1, h2, body, caption, label, labelBold }

class AppText extends StatelessWidget {
  final String text;
  final AppTextType type;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const AppText(
    this.text, {
    Key? key,
    required this.type,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: _getTextStyle(color),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  TextStyle _getTextStyle(Color? color) {
    switch (type) {
      case AppTextType.h1:
        return AppTypography.h1(color: color);
      case AppTextType.h2:
        return AppTypography.h2(color: color);
      case AppTextType.body:
        return AppTypography.body(color: color);
      case AppTextType.caption:
        return AppTypography.caption(color: color);
      case AppTextType.label:
        return AppTypography.label(color: color);
      case AppTextType.labelBold:
        return AppTextStyles.labelBold.copyWith(color: color);
    }
  }
}
```

#### Usage in MaterialApp
```dart
import 'package:flutter/material.dart';

class WallpaperApp extends StatelessWidget {
  const WallpaperApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallpaper Selector',
      theme: ThemeData(
        fontFamily: AppTextStyles.primaryFont,
        textTheme: AppTypography.textTheme,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
        ),
      ),
      home: const TypographyDemo(),
    );
  }
}
```

### 8. Color Palette System

Based on the Figma design, here's the complete color palette system:

#### Color Definitions
```dart
import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFFFBB03B);    // Main Yellow/Orange
  static const Color primaryDark = Color(0xFFFFA821); // Darker Yellow/Orange
  static const Color primaryLight = Color(0xFFFFD4A3); // Lighter variant (calculated)

  // Accent Colors
  static const Color accent = Color(0xFFEC0C43);      // Pink/Red accent

  // Neutral Colors
  static const Color black = Color(0xFF000000);       // Pure Black
  static const Color white = Color(0xFFFFFFFF);       // Pure White
  static const Color background = Color(0xFFF8F8F8);  // Light Gray Background
  static const Color surface = Color(0xFFE8E8E8);     // Surface/Container Gray

  // Text Colors
  static const Color textPrimary = Color(0xFF000000); // Primary text color
  static const Color textSecondary = Color(0xFF666666); // Secondary text (calculated)
  static const Color textOnPrimary = Color(0xFFFFFFFF); // Text on primary colors

  // Status Colors (from components)
  static const Color successBg = Color(0xFFC8FFBD);
  static const Color successText = Color(0xFF1BA400);
  static const Color inactiveBg = Color(0xFFEBEBEB);
  static const Color inactiveText = Color(0xFF9C9C9C);

  // Border Colors
  static const Color border = Color(0xFFDFDFDF);
  static const Color primaryBorder = Color(0xFFFFA821);
  static const Color disabled = Color(0xFFD8D8D8);

  // Overlay Colors
  static const Color overlay = Color(0x6AFFFFFF); // 42% white opacity
  static const Color shadow = Color(0x1A000000);  // 10% black opacity
}

// Color Extensions for easy access
extension AppColorsExtension on Color {
  // Get lighter version of color
  Color lighten([double amount = 0.1]) {
    final hsl = HSLColor.fromColor(this);
    return hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0)).toColor();
  }

  // Get darker version of color
  Color darken([double amount = 0.1]) {
    final hsl = HSLColor.fromColor(this);
    return hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0)).toColor();
  }

  // Get color with opacity
  Color withOpacity(double opacity) {
    return Color.fromARGB(
      (opacity * 255).round(),
      red,
      green,
      blue,
    );
  }
}
```

#### Color Palette Demo Widget
```dart
import 'package:flutter/material.dart';

class ColorPaletteDemo extends StatelessWidget {
  const ColorPaletteDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text('Color Palette'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(33.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                'Colors',
                style: AppTypography.h1(color: AppColors.textPrimary),
              ),
              const SizedBox(height: 20),

              // Color Grid
              Wrap(
                spacing: 19,
                runSpacing: 19,
                children: [
                  _ColorTile(
                    color: AppColors.primary,
                    name: 'FBB03B',
                    description: 'Primary',
                  ),
                  _ColorTile(
                    color: AppColors.primaryDark,
                    name: 'FFA821',
                    description: 'Primary Dark',
                  ),
                  _ColorTile(
                    color: AppColors.accent,
                    name: 'EC0C43',
                    description: 'Accent',
                  ),
                  _ColorTile(
                    color: AppColors.black,
                    name: '000000',
                    description: 'Black',
                    textColor: AppColors.white,
                  ),
                  _ColorTile(
                    color: AppColors.background,
                    name: 'F8F8F8',
                    description: 'Background',
                  ),
                  _ColorTile(
                    color: AppColors.surface,
                    name: 'E8E8E8',
                    description: 'Surface',
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Usage Examples
              Text(
                'Usage Examples',
                style: AppTypography.h2(color: AppColors.textPrimary),
              ),
              const SizedBox(height: 16),

              // Example Cards
              Row(
                children: [
                  Expanded(
                    child: _ExampleCard(
                      title: 'Primary Button',
                      color: AppColors.primary,
                      textColor: AppColors.textOnPrimary,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _ExampleCard(
                      title: 'Accent Element',
                      color: AppColors.accent,
                      textColor: AppColors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ColorTile extends StatelessWidget {
  final Color color;
  final String name;
  final String description;
  final Color? textColor;

  const _ColorTile({
    required this.color,
    required this.name,
    required this.description,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveTextColor = textColor ?? AppColors.textPrimary;

    return Container(
      width: 122.49,
      child: Column(
        children: [
          // Color Swatch
          Container(
            width: 122.49,
            height: 122.49,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Color Name
          Text(
            name,
            style: AppTextStyles.body.copyWith(
              color: effectiveTextColor,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ExampleCard extends StatelessWidget {
  final String title;
  final Color color;
  final Color textColor;

  const _ExampleCard({
    required this.title,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            Icons.palette,
            color: textColor,
            size: 32,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: AppTextStyles.body.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
```

#### Color Utility Functions
```dart
import 'package:flutter/material.dart';

class ColorUtils {
  // Get contrast color (black or white) based on background
  static Color getContrastColor(Color backgroundColor) {
    // Calculate luminance
    double luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  // Check if color is light
  static bool isLightColor(Color color) {
    return color.computeLuminance() > 0.5;
  }

  // Generate Material color swatch from single color
  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  // Blend two colors
  static Color blendColors(Color color1, Color color2, double ratio) {
    return Color.fromRGBO(
      (color1.red * (1 - ratio) + color2.red * ratio).round(),
      (color1.green * (1 - ratio) + color2.green * ratio).round(),
      (color1.blue * (1 - ratio) + color2.blue * ratio).round(),
      1,
    );
  }
}
```

#### Theme Configuration
```dart
import 'package:flutter/material.dart';

class AppTheme {
  // Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
        primary: AppColors.primary,
        secondary: AppColors.accent,
        surface: AppColors.background,
        background: AppColors.background,
        onPrimary: AppColors.textOnPrimary,
        onSecondary: AppColors.white,
        onSurface: AppColors.textPrimary,
        onBackground: AppColors.textPrimary,
      ),
      fontFamily: AppTextStyles.primaryFont,
      textTheme: AppTypography.textTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(21),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          side: const BorderSide(color: AppColors.border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(21),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
    );
  }

  // Dark Theme (if needed)
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.dark,
        primary: AppColors.primary,
        secondary: AppColors.accent,
        surface: const Color(0xFF1E1E1E),
        background: const Color(0xFF121212),
        onPrimary: AppColors.textOnPrimary,
        onSecondary: AppColors.white,
        onSurface: AppColors.white,
        onBackground: AppColors.white,
      ),
      fontFamily: AppTextStyles.primaryFont,
      textTheme: AppTypography.textTheme.apply(
        bodyColor: AppColors.white,
        displayColor: AppColors.white,
      ),
    );
  }
}
```

### 9. Complete Color Scheme (Updated)

```dart
class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFFFBB03B);    // Main Yellow/Orange
  static const Color primaryDark = Color(0xFFFFA821); // Darker Yellow/Orange
  static const Color primaryBorder = Color(0xFFFFA821);
  static const Color primaryBackground = Color(0xFFFFA821);

  // Accent Colors
  static const Color accent = Color(0xFFEC0C43);      // Pink/Red accent

  // Neutral Colors
  static const Color black = Color(0xFF000000);       // Pure Black
  static const Color white = Color(0xFFFFFFFF);       // Pure White
  static const Color background = Color(0xFFF8F8F8);  // Light Gray Background
  static const Color surface = Color(0xFFE8E8E8);     // Surface/Container Gray

  // Text Colors
  static const Color textPrimary = Color(0xFF000000); // Primary text color
  static const Color textSecondary = Color(0xFF666666); // Secondary text (calculated)
  static const Color textOnPrimary = Color(0xFFFFFFFF); // Text on primary colors

  // Status Colors
  static const Color successBg = Color(0xFFC8FFBD);
  static const Color successText = Color(0xFF1BA400);
  static const Color inactiveBg = Color(0xFFEBEBEB);
  static const Color inactiveText = Color(0xFF9C9C9C);

  // Border Colors
  static const Color border = Color(0xFFDFDFDF);
  static const Color disabled = Color(0xFFD8D8D8);

  // Overlay Colors
  static const Color overlay = Color(0x6AFFFFFF); // 42% white opacity
  static const Color shadow = Color(0x1A000000);  // 10% black opacity
}
```