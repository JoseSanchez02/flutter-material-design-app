# Asset Placeholder Files

This directory contains placeholder images and icons for the app.

## Directory Structure

```
assets/
├── images/
│   ├── placeholder_1.png
│   ├── placeholder_2.png
│   └── placeholder_3.png
└── icons/
    └── app_icon.png
```

## Image Guidelines

### Item Images

- **Format**: PNG or JPG
- **Dimensions**: 1920×1080 recommended (16:9 aspect ratio)
- **Size**: < 500KB per image
- **Usage**: Item cards and detail views

### Icons

- **Format**: PNG with transparency
- **Dimensions**: 512×512 or 1024×1024
- **Usage**: App icon, feature illustrations

## Adding Your Own Assets

1. Place images in the appropriate directory
2. Reference in code:

   ```dart
   Image.asset('assets/images/your_image.png')
   ```

3. For app icons, update:
   - `android/app/src/main/res/mipmap-*/ic_launcher.png`
   - Use Android Studio's Image Asset tool

## Image Attribution

If using stock photos or icons, ensure you have proper licensing and add attribution here:

- [Example] Photo by Photographer Name on Unsplash
- [Example] Icon from Material Design Icons

## Optimization Tips

### Before Adding Images

1. Resize to appropriate dimensions
2. Compress using tools like:

   - TinyPNG (https://tinypng.com/)
   - ImageOptim (https://imageoptim.com/)
   - Squoosh (https://squoosh.app/)

3. Consider WebP format for better compression

### During Development

- Test on low-end devices
- Monitor app size: `flutter build apk --analyze-size`
- Use `Image.asset` caching automatically

---

**Note**: This is a placeholder file. In a production app, replace with actual design assets.
