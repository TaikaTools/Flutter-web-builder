#!/bin/bash
set -e  # Exit immediately if any command fails

# ========================= BUILD =========================
echo "Building Flutter Web..."
flutter build web --release \
    --tree-shake-icons \
    --no-source-maps

cd build/web || { echo "Failed to enter build/web directory"; exit 1; }

# ========================= CACHE BUSTING =========================
echo "Applying Cache Busting..."

TIMESTAMP=$(date +%s)
echo "   Timestamp: $TIMESTAMP"

# Backup original file
#cp flutter_bootstrap.js flutter_bootstrap.js.bak

if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    sed -i '' "s|main\.dart\.js|main\.dart\.js?cache=$TIMESTAMP|g" flutter_bootstrap.js
else
    # Linux
    sed -i "s|main\.dart\.js|main\.dart\.js?cache=$TIMESTAMP|g" flutter_bootstrap.js
fi

echo "Cache busting applied (main.dart.js?cache=$TIMESTAMP)"

# ========================= COMPRESSION =========================
echo "Compressing files with Gzip + Brotli..."

find . -type f \( -name "*.js" -o -name "*.css" -o -name "*.json" \
    -o -name "*.wasm" -o -name "*.svg" -o -name "*.html" \) \
    -exec gzip -f -9 -k {} \; \
    -exec brotli -f -Z -k {} \;

echo "Compression completed (Gzip + Brotli)"

# ========================= SUMMARY =========================
echo ""
echo "========================================"
echo "Flutter Web Build Completed Successfully!"
echo "Build time     : $(date)"
echo "Cache Buster   : $TIMESTAMP"
echo "Output folder  : $(pwd)"
echo "========================================"
echo ""
echo "You can now sync this folder to your server."