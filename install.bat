@echo off
echo ===============================================
echo 🏛️ Memorial Website - Quick Install Script
echo ===============================================
echo.

echo ⚡ Checking Node.js version...
node -v
if %ERRORLEVEL% neq 0 (
    echo ❌ Node.js not found! Please install Node.js 18+ first
    echo Download: https://nodejs.org/
    pause
    exit /b 1
)

echo.
echo ⚡ Installing latest PNPM...
npm install -g pnpm@latest

echo.
echo ⚡ Cleaning old files...
if exist node_modules rmdir /s /q node_modules
if exist pnpm-lock.yaml del pnpm-lock.yaml
if exist .vite rmdir /s /q .vite
if exist dist rmdir /s /q dist

echo.
echo ⚡ Clearing PNPM cache...
pnpm store prune

echo.
echo ⚡ Installing dependencies...
pnpm install

if %ERRORLEVEL% neq 0 (
    echo.
    echo ⚠️ PNPM failed, trying NPM fallback...
    npm install --legacy-peer-deps
    
    if %ERRORLEVEL% neq 0 (
        echo ❌ Installation failed! Please check README for troubleshooting
        pause
        exit /b 1
    )
    
    echo.
    echo ✅ NPM installation successful!
    echo 🚀 Starting with NPM...
    npm run dev
) else (
    echo.
    echo ✅ PNPM installation successful!
    echo 🚀 Starting development server...
    pnpm run dev
)

echo ⚡ Clearing PNPM cache...
pnpm cache clean --force
echo ⚡ Clearing NPM cache...
npm cache clean --force
