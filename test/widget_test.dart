import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:stage3_wallpaperapp_dukeazeta/main.dart';
import 'package:stage3_wallpaperapp_dukeazeta/providers/wallpaper_provider.dart';

void main() {
  testWidgets('Wallpaper Studio app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => WallpaperProvider(),
        child: const WallpaperStudioApp(),
      ),
    );

    // Verify that the app starts with the home screen
    expect(find.text('Wallpaper Studio'), findsOneWidget);
    expect(find.text('Discover Beautiful'), findsOneWidget);
    expect(find.text('Wallpapers'), findsOneWidget);
    expect(find.text('Categories'), findsOneWidget);
  });
}