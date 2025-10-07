# Responsive Material Design App

A production-ready Flutter Android app demonstrating responsive UI with Material Design 3 principles, adaptive layouts, and comprehensive CRUD functionality.

![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue.svg)
![Dart](https://img.shields.io/badge/Dart-3.0+-blue.svg)
![Android](https://img.shields.io/badge/Android-API%2021+-green.svg)
![Material Design](https://img.shields.io/badge/Material%20Design-3-purple.svg)

## 📱 Features

### Core Functionality

- **CRUD Operations**: Complete Create, Read, Update, Delete functionality with SQLite persistence
- **Responsive Design**: Adaptive layouts for phones and tablets (portrait & landscape)
- **Material Design 3**: Modern UI following Google's latest design principles
- **Image Handling**: Camera and gallery integration for item images
- **Search**: Real-time search functionality across items
- **Themes**: Light and dark mode support
- **Accessibility**: Proper semantic labels, touch targets (48dp minimum), and readable fonts

### Screens

1. **Home/Dashboard** - Responsive grid layout with search functionality
2. **Detail View** - Full item details with hero animations and metadata
3. **Create/Edit Form** - Validated form with image picker integration
4. **Settings/About** - Theme toggle, platform info, and app details

## 🏗️ Architecture

### Project Structure

```
lib/
├── main.dart                    # App entry point
├── models/
│   └── item.dart               # Data model
├── screens/
│   ├── home_screen.dart        # Main dashboard
│   ├── detail_screen.dart      # Item details
│   ├── create_edit_screen.dart # Form screen
│   └── settings_screen.dart    # Settings & about
├── services/
│   └── database_service.dart   # SQLite database layer
└── utils/
    ├── responsive_utils.dart   # Responsive utilities
    └── theme_provider.dart     # Theme management

test/
├── responsive_test.dart        # Responsive layout tests
└── form_validation_test.dart   # Form validation tests
```

### Design Patterns

- **Repository Pattern**: Database service abstracts data access
- **Singleton**: DatabaseService uses singleton pattern
- **Provider Pattern**: ThemeProvider for state management
- **Material Design 3**: Latest Material components and theming

## 🎨 Responsive Design Implementation

### Breakpoints

Following Material Design guidelines:

- **Mobile**: < 600dp (2-3 columns)
- **Tablet**: 600-840dp (3-4 columns)
- **Desktop**: > 840dp (4-6 columns)

### Adaptive Layouts

- **Portrait/Landscape**: Dynamic column count based on orientation
- **Master-Detail**: Split view on tablets in landscape mode
- **Responsive Padding**: Scales from 16dp (mobile) to 32dp (desktop)
- **Font Scaling**: 1.0x (mobile), 1.1x (tablet), 1.2x (desktop)

### Implementation

```dart
 Utilities provided:
- ResponsiveUtils.getDeviceType(context)
- ResponsiveUtils.getGridColumns(context)
- ResponsiveUtils.getResponsivePadding(context)
- ResponsiveBuilder widget for conditional layouts
```

## 📦 Installation & Setup

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / VS Code
- Android SDK (API 21+)
- Android device or emulator

### Steps

1. **Clone the repository**

```powershell
git clone <repository-url>
cd "UI Flutter"
```

2. **Install dependencies**

```powershell
flutter pub get
```

3. **Verify setup**

```powershell
flutter doctor
```

4. **Run the app**

```powershell
# Debug mode
flutter run

# Profile mode (for performance testing)
flutter run --profile

# Release mode
flutter run --release
```

5. **Run tests**

```powershell
flutter test
```

## 🔨 Building APK

### Debug APK

```powershell
flutter build apk --debug
```

### Release APK (optimized)

```powershell
flutter build apk --release
```

The APK will be located at:
`build/app/outputs/flutter-apk/app-release.apk`

### App Bundle (for Play Store)

```powershell
flutter build appbundle --release
```

## 🧪 Testing

### Run All Tests

```powershell
flutter test
```

### Test Coverage

```powershell
flutter test --coverage
```

### Widget Tests Included

1. **Responsive Layout Tests** (`test/responsive_test.dart`)

   - Mobile, tablet, and desktop layout rendering
   - Grid column adaptation
   - Device type detection
   - Breakpoint validation

2. **Form Validation Tests** (`test/form_validation_test.dart`)
   - Required field validation
   - Minimum length validation
   - Form submission flow
   - UI element presence

## 🎯 Requirements Coverage

### ✅ Technical Stack

- ✓ Flutter (stable channel, 3.0+)
- ✓ Dart with null-safety
- ✓ Target Android API 21+
- ✓ Material Design 3 components

### ✅ Responsive Design

- ✓ LayoutBuilder and MediaQuery usage
- ✓ Two breakpoints (mobile < 600dp, tablet 600-840dp)
- ✓ Portrait and landscape support
- ✓ Adaptive column counts
- ✓ Master-detail layout on tablets

### ✅ Material Design Implementation

- ✓ Material 3 components (Cards, Buttons, AppBar, etc.)
- ✓ Proper elevation and shadows
- ✓ Motion and transitions (Hero animations)
- ✓ Color system (primary, secondary, surface)
- ✓ Typography scale

### ✅ Required Screens

- ✓ **Home/Dashboard**: Responsive grid with search
- ✓ **Detail View**: Full item display with actions
- ✓ **Create/Edit Form**: Validated form with image picker
- ✓ **Settings/About**: Theme toggle and platform info

### ✅ Data Management

- ✓ SQLite database (sqflite package)
- ✓ Full CRUD operations
- ✓ Sample dataset (6 items)
- ✓ Repository pattern

### ✅ Accessibility

- ✓ Minimum touch targets: 48dp
- ✓ Semantic labels on interactive widgets
- ✓ Readable font sizes (scaled)
- ✓ Text scale factor clamping (0.8-1.5)
- ✓ High contrast support (dark mode)

### ✅ Testing

- ✓ Widget tests for responsive layouts
- ✓ Form validation tests
- ✓ Device type detection tests
- ✓ Breakpoint validation tests

### ✅ Documentation

- ✓ Comprehensive README
- ✓ Installation instructions
- ✓ Build instructions
- ✓ Architecture documentation
- ✓ Design decisions explained
- ✓ Requirements mapping

## 📸 Screenshots

### Phone (Portrait)

- Grid view with 2 columns
- Compact navigation
- Full-width cards

### Phone (Landscape)

- Grid view with 3 columns
- Optimized spacing

### Tablet (Portrait)

- Grid view with 3 columns
- Larger padding
- Enhanced typography

### Tablet (Landscape)

- Master-detail layout OR 4-column grid
- Split view on detail screens
- Maximum content width constraint

## 🎨 Design Assets

### Included Assets

- Placeholder images in `assets/images/`
- App icons in `assets/icons/`
- Material Design icons from Flutter

### Color Scheme

- **Primary**: Blue (Material seed color)
- **Light Mode**: Surface colors, proper elevation
- **Dark Mode**: Dark surface colors, adjusted contrast

## 🔧 Configuration

### Minimum SDK

```gradle
minSdkVersion 21   Android 5.0 (Lollipop)
targetSdkVersion 33  Android 13
```

### Permissions

- Camera access (for taking photos)
- Storage access (for gallery images)

## 📚 Dependencies

```yaml
dependencies:
  flutter: sdk
  sqflite: ^2.3.0 # SQLite database
  path_provider: ^2.1.1 # File system paths
  image_picker: ^1.0.4 # Camera/gallery
  intl: ^0.18.1 # Date formatting

dev_dependencies:
  flutter_test: sdk
  flutter_lints: ^3.0.0 # Linting rules
```

## 🚀 Performance Optimizations

- **Lazy Loading**: GridView.builder for efficient rendering
- **Image Caching**: Proper image disposal
- **Database Indexing**: Optimized queries
- **Hero Animations**: Smooth transitions
- **Release Mode**: Minification and shrinking enabled

## 👥 Author

Flutter Developer + UI/UX Designer

## 🔗 Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Material Design 3](https://m3.material.io/)
- [Responsive Design Guidelines](https://material.io/design/layout/responsive-layout-grid.html)
- [Android Developer Guide](https://developer.android.com/)

---

## 📋 Rubric Mapping

This section explicitly maps project features to assignment requirements:

### 1. Technology Stack ✓

- **Requirement**: Flutter (stable), Dart, null-safety, Android API 21+
- **Implementation**:
  - Flutter 3.0+ with null-safety enabled
  - `minSdkVersion 21` in Android configuration
  - All dependencies use latest stable versions

### 2. Responsive Design ✓

- **Requirement**: Adapt to portrait/landscape, 2+ breakpoints
- **Implementation**:
  - `ResponsiveUtils` class with mobile/tablet/desktop breakpoints
  - Dynamic grid columns (2-6 based on screen)
  - Master-detail layout on tablets
  - Files: `lib/utils/responsive_utils.dart`

### 3. Material Design ✓

- **Requirement**: Google Material Design components, motion, elevation
- **Implementation**:
  - Material 3 theme with ColorScheme
  - Card elevation, rounded corners
  - Hero animations between screens
  - Files: All screen files, `lib/utils/theme_provider.dart`

### 4. Required Screens ✓

- **Home/Dashboard**: `lib/screens/home_screen.dart` - responsive grid
- **Detail View**: `lib/screens/detail_screen.dart` - hero animations
- **Create/Edit Form**: `lib/screens/create_edit_screen.dart` - validation + image picker
- **Settings/About**: `lib/screens/settings_screen.dart` - theme toggle + platform info

### 5. Data Persistence ✓

- **Requirement**: Local persistence, CRUD, sample data
- **Implementation**:
  - SQLite via sqflite package
  - Full CRUD in `DatabaseService`
  - 6 sample items auto-inserted
  - Files: `lib/services/database_service.dart`, `lib/models/item.dart`

### 6. Assets ✓

- **Requirement**: Placeholder images, icons
- **Implementation**:
  - Asset folders configured in pubspec.yaml
  - Material Design icons throughout
  - Image placeholder widgets

### 7. Accessibility ✓

- **Requirement**: Readable fonts, touch targets, semantic labels
- **Implementation**:
  - Minimum 48dp touch targets on buttons
  - Semantic labels on interactive widgets
  - Text scale factor clamping (0.8-1.5)
  - High contrast dark mode

### 8. Testing ✓

- **Requirement**: Widget tests for responsive layouts and form validation
- **Implementation**:
  - `test/responsive_test.dart` - 7 tests for layouts
  - `test/form_validation_test.dart` - 8 tests for validation

---
