import 'package:flutter/material.dart';
import 'constants.dart';

extension ContextExtensions on BuildContext {
  // Theme
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;

  // MediaQuery
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get size => mediaQuery.size;
  double get width => size.width;
  double get height => size.height;
  EdgeInsets get padding => mediaQuery.padding;
  EdgeInsets get viewInsets => mediaQuery.viewInsets;

  // Device Type
  bool get isMobile => width < AppConstants.mobileBreakpoint;
  bool get isTablet => width >= AppConstants.mobileBreakpoint && width < AppConstants.tabletBreakpoint;
  bool get isDesktop => width >= AppConstants.desktopBreakpoint;
  bool get isLargeDesktop => width >= AppConstants.largeDesktopBreakpoint;
  bool get isWeb => width >= AppConstants.tabletBreakpoint;
  bool get isSmallScreen => width < 480;
  bool get isMediumScreen => width >= 480 && width < 768;
  bool get isLargeScreen => width >= 768 && width < 1024;
  bool get isExtraLargeScreen => width >= 1024;

  // Navigation
  void pop() => Navigator.of(this).pop();
  void pushNamed(String routeName) => Navigator.of(this).pushNamed(routeName);
  void pushReplacementNamed(String routeName) => Navigator.of(this).pushReplacementNamed(routeName);

  // Responsive values
  T responsive<T>({
    required T mobile,
    T? tablet,
    T? desktop,
    T? largeDesktop,
  }) {
    if (isLargeDesktop && largeDesktop != null) return largeDesktop;
    if (isDesktop && desktop != null) return desktop;
    if (isTablet && tablet != null) return tablet;
    return mobile;
  }

  double responsiveValue({
    required double mobile,
    double? tablet,
    double? desktop,
    double? largeDesktop,
  }) {
    return responsive(
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      largeDesktop: largeDesktop,
    );
  }

  // Responsive padding
  EdgeInsets responsivePadding({
    required EdgeInsets mobile,
    EdgeInsets? tablet,
    EdgeInsets? desktop,
    EdgeInsets? largeDesktop,
  }) {
    return responsive(
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      largeDesktop: largeDesktop,
    );
  }

  // Responsive font size
  double responsiveFontSize({
    required double mobile,
    double? tablet,
    double? desktop,
    double? largeDesktop,
  }) {
    return responsive(
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      largeDesktop: largeDesktop,
    );
  }
}

extension StringExtensions on String {
  String get capitalize {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }

  String get titleCase {
    return split(' ').map((word) => word.capitalize).join(' ');
  }
}

extension ListExtensions on List<Widget> {
  List<Widget> separatedBy(Widget separator) {
    if (length <= 1) return this;

    final result = <Widget>[];
    for (int i = 0; i < length; i++) {
      result.add(this[i]);
      if (i < length - 1) {
        result.add(separator);
      }
    }
    return result;
  }
}