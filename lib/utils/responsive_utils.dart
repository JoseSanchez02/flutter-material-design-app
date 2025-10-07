import 'package:flutter/material.dart';

/// Breakpoint definitions following Material Design guidelines
enum DeviceType {
  mobile,
  tablet,
  desktop,
}

/// Utility class for responsive design calculations
class ResponsiveUtils {
  // Breakpoints (dp)
  static const double mobileBreakpoint = 600.0;
  static const double tabletBreakpoint = 840.0;

  /// Get current device type based on width
  static DeviceType getDeviceType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return getDeviceTypeFromWidth(width);
  }

  /// Get device type from width value
  static DeviceType getDeviceTypeFromWidth(double width) {
    if (width < mobileBreakpoint) {
      return DeviceType.mobile;
    } else if (width < tabletBreakpoint) {
      return DeviceType.tablet;
    } else {
      return DeviceType.desktop;
    }
  }

  /// Check if device is mobile
  static bool isMobile(BuildContext context) {
    return getDeviceType(context) == DeviceType.mobile;
  }

  /// Check if device is tablet
  static bool isTablet(BuildContext context) {
    return getDeviceType(context) == DeviceType.tablet;
  }

  /// Check if device is desktop
  static bool isDesktop(BuildContext context) {
    return getDeviceType(context) == DeviceType.desktop;
  }

  /// Get number of columns for grid based on screen width
  static int getGridColumns(BuildContext context) {
    final deviceType = getDeviceType(context);
    final orientation = MediaQuery.of(context).orientation;

    switch (deviceType) {
      case DeviceType.mobile:
        return orientation == Orientation.portrait ? 2 : 3;
      case DeviceType.tablet:
        return orientation == Orientation.portrait ? 3 : 4;
      case DeviceType.desktop:
        return orientation == Orientation.portrait ? 4 : 6;
    }
  }

  /// Get responsive padding
  static EdgeInsets getResponsivePadding(BuildContext context) {
    final deviceType = getDeviceType(context);

    switch (deviceType) {
      case DeviceType.mobile:
        return const EdgeInsets.all(16.0);
      case DeviceType.tablet:
        return const EdgeInsets.all(24.0);
      case DeviceType.desktop:
        return const EdgeInsets.all(32.0);
    }
  }

  /// Get responsive spacing
  static double getResponsiveSpacing(BuildContext context) {
    final deviceType = getDeviceType(context);

    switch (deviceType) {
      case DeviceType.mobile:
        return 8.0;
      case DeviceType.tablet:
        return 12.0;
      case DeviceType.desktop:
        return 16.0;
    }
  }

  /// Get responsive font size multiplier
  static double getFontSizeMultiplier(BuildContext context) {
    final deviceType = getDeviceType(context);

    switch (deviceType) {
      case DeviceType.mobile:
        return 1.0;
      case DeviceType.tablet:
        return 1.1;
      case DeviceType.desktop:
        return 1.2;
    }
  }

  /// Get maximum content width for large screens
  static double getMaxContentWidth(BuildContext context) {
    final deviceType = getDeviceType(context);

    switch (deviceType) {
      case DeviceType.mobile:
        return double.infinity;
      case DeviceType.tablet:
        return 800.0;
      case DeviceType.desktop:
        return 1200.0;
    }
  }

  /// Check if layout should be split (master-detail)
  static bool shouldUseMasterDetail(BuildContext context) {
    return !isMobile(context) &&
        MediaQuery.of(context).orientation == Orientation.landscape;
  }
}

/// Widget that builds different layouts based on device type
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context) mobile;
  final Widget Function(BuildContext context)? tablet;
  final Widget Function(BuildContext context)? desktop;

  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final deviceType =
            ResponsiveUtils.getDeviceTypeFromWidth(constraints.maxWidth);

        switch (deviceType) {
          case DeviceType.desktop:
            return (desktop ?? tablet ?? mobile)(context);
          case DeviceType.tablet:
            return (tablet ?? mobile)(context);
          case DeviceType.mobile:
            return mobile(context);
        }
      },
    );
  }
}
