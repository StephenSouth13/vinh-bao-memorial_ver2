#!/bin/bash

echo "==============================================="
echo "🏛️ Memorial Website - Quick Install Script"
echo "==============================================="
echo

# Check Node.js version
echo "⚡ Checking Node.js version..."
if ! command -v node &> /dev/null; then
    echo "❌ Node.js not found! Please install Node.js 18+ first"
    echo "Download: https://nodejs.org/"
    exit 1
fi

NODE_VERSION=$(node -v | sed 's/v//')
REQUIRED_VERSION="18.0.0"

if [ "$(printf '%s\n' "$REQUIRED_VERSION" "$NODE_VERSION" | sort -V | head -n1)" != "$REQUIRED_VERSION" ]; then
    echo "❌ Node.js version $NODE_VERSION is too old. Required: $REQUIRED_VERSION+"
    exit 1
fi

echo "✅ Node.js version: $NODE_VERSION"

# Install latest PNPM
echo
echo "⚡ Installing latest PNPM..."
npm install -g pnpm@latest

# Clean old files
echo
echo "⚡ Cleaning old files..."
rm -rf node_modules pnpm-lock.yaml .vite dist

# Clear PNPM cache
echo
echo "⚡ Clearing PNPM cache..."
pnpm store prune

# Install dependencies
echo
echo "⚡ Installing dependencies..."
if pnpm install; then
    echo
    echo "✅ PNPM installation successful!"
    echo "🚀 Starting development server..."
    pnpm run dev
else
    echo
    echo "⚠️ PNPM failed, trying NPM fallback..."
    
    if npm install --legacy-peer-deps; then
        echo
        echo "✅ NPM installation successful!"
        echo "🚀 Starting with NPM..."
        npm run dev
    else
        echo "❌ Installation failed! Please check README for troubleshooting"
        exit 1
    fi
fi
