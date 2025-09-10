import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppHelpers {
  // URL Launcher
  static Future<void> launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $url');
    }
  }

  static Future<void> launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    await launchURL(emailUri.toString());
  }

  static Future<void> launchPhone(String phone) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phone,
    );
    await launchURL(phoneUri.toString());
  }

  // Show snackbar
  static void showSnackBar(BuildContext context, String message, {
    Color? backgroundColor,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  // Show dialog
  static Future<T?> showCustomDialog<T>(
      BuildContext context, {
        required Widget child,
        bool barrierDismissible = true,
      }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => child,
    );
  }

  // Format duration
  static String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  // Get greeting based on time
  static String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  // Copy to clipboard
  static Future<void> copyToClipboard(BuildContext context, String text) async {
    // Note: In a real app, you'd use clipboard package
    // For this demo, we'll just show a snackbar
    showSnackBar(context, 'Copied to clipboard: $text');
  }

  // Animate list items
  static Widget animateListItem(
      Widget child,
      int index, {
        Duration delay = const Duration(milliseconds: 100),
      }) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 300 + (index * 100)),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  // Get platform-specific padding
  static EdgeInsets getPlatformPadding(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return EdgeInsets.only(
      top: mediaQuery.padding.top,
      bottom: mediaQuery.padding.bottom,
    );
  }
}