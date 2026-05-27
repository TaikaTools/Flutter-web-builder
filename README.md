# Flutter Web Deploy Script

A powerful and simple deployment script for Flutter Web that optimizes production builds with **cache busting** and **maximum pre-compression** (Gzip + Brotli).

Designed for fast loading times and reliable cache invalidation on every deployment.

---

## Features

- **Automatic Cache Busting**: Adds a unique timestamp to `main.dart.js` so browsers always load the latest version.
- **Maximum Compression**: Creates both `.gz` and `.br` (Brotli) files using highest compression levels.
- **Cross-platform**: Works on both **macOS** and **Linux**.
- **Production Optimized**: Uses recommended Flutter build flags.
- **Safe & Transparent**: Shows clear progress and summary.

---

## What This Script Does

1. Builds the Flutter Web app in release mode
2. Applies cache busting to `flutter_bootstrap.js`
3. Pre-compresses all static assets with **Gzip -9** and **Brotli -Z** (level 11)
4. Prepares everything ready for upload to your server

---

## Usage

1. Clone or download this script into your Flutter project root.
2. Make it executable:

```bash
chmod +x flutter-build.sh
