#!/bin/bash

SCRIPT_DIR=$(dirname "$0")
BASE_DIR="$1"

# Identify Product/System_ext directories
if [ -d "$BASE_DIR/product" ] && [ ! -L "$BASE_DIR/product" ]; then
    product="$BASE_DIR/product"
elif [ -d "$BASE_DIR/system/product" ] && [ ! -L "$BASE_DIR/system/product" ]; then
    product="$BASE_DIR/system/product"
else
    # Fallback to system/product if it exists as symlink or folder
    product="$BASE_DIR/system/product"
fi

if [ -d "$BASE_DIR/system_ext" ] && [ ! -L "$BASE_DIR/system_ext" ]; then
    system_ext="$BASE_DIR/system_ext"
elif [ -d "$BASE_DIR/system/system_ext" ] && [ ! -L "$BASE_DIR/system/system_ext" ]; then
    system_ext="$BASE_DIR/system/system_ext"
else
    system_ext="$BASE_DIR/system/system_ext"
fi

echo "==> Starting Nuclear Debloat..."

# ==========================================
# 1. HEAVY FILES (Prism, Optic, Recovery, Preloads)
# ==========================================
# These folders often contain region specific bloat, carrier apps, and SwiftKey languages (huge)
rm -rf $BASE_DIR/system/prism/*
rm -rf $BASE_DIR/system/optics/*
rm -rf $BASE_DIR/system/preload/*
rm -rf $BASE_DIR/system/hidden/*
rm -rf $BASE_DIR/system/container/*
rm -rf $BASE_DIR/system/saiv/*
rm -rf $BASE_DIR/system/recovery-from-boot.p
rm -rf $BASE_DIR/system/etc/recovery-resource.dat

# Wallpapers and Media
rm -rf $BASE_DIR/system/wallpaper/*
rm -rf $BASE_DIR/system/media/video/*
rm -rf $BASE_DIR/system/media/wallpaper/*

# TTS (Text To Speech) - often hundreds of MBs of voice data
rm -rf $BASE_DIR/system/tts/*
rm -rf $BASE_DIR/system/voicebwt/*

# ==========================================
# 2. SYSTEM APPS (Bloatware)
# ==========================================
# AR / VR / Bixby / Print / Stickers
rm -rf $BASE_DIR/system/app/AR*
rm -rf $BASE_DIR/system/app/Bixby*
rm -rf $BASE_DIR/system/app/Sticker*
rm -rf $BASE_DIR/system/app/PrintSpooler
rm -rf $BASE_DIR/system/app/EasterEgg
rm -rf $BASE_DIR/system/app/DictDiotekForSec
rm -rf $BASE_DIR/system/app/FBAppManager_NS
rm -rf $BASE_DIR/system/app/Facebook*
rm -rf $BASE_DIR/system/app/Game*
rm -rf $BASE_DIR/system/app/GearManager*
rm -rf $BASE_DIR/system/app/KidsHome*
rm -rf $BASE_DIR/system/app/LinkSharing*
rm -rf $BASE_DIR/system/app/LiveDrawing*
rm -rf $BASE_DIR/system/app/LiveStickers*
rm -rf $BASE_DIR/system/app/MSSkype*
rm -rf $BASE_DIR/system/app/OneDrive*
rm -rf $BASE_DIR/system/app/SamsungBilling
rm -rf $BASE_DIR/system/app/SamsungCheckout
rm -rf $BASE_DIR/system/app/SamsungCloud*
rm -rf $BASE_DIR/system/app/SamsungConnect*
rm -rf $BASE_DIR/system/app/SamsungFree*
rm -rf $BASE_DIR/system/app/SamsungDaily*
rm -rf $BASE_DIR/system/app/SamsungGlobalGoals
rm -rf $BASE_DIR/system/app/SamsungKids*
rm -rf $BASE_DIR/system/app/SamsungMembers*
rm -rf $BASE_DIR/system/app/SamsungMusic*
rm -rf $BASE_DIR/system/app/SamsungNews*
rm -rf $BASE_DIR/system/app/SamsungPass*
rm -rf $BASE_DIR/system/app/SamsungPay*
rm -rf $BASE_DIR/system/app/SamsungSocial*
rm -rf $BASE_DIR/system/app/SamsungTTS*
rm -rf $BASE_DIR/system/app/SamsungVideo*
rm -rf $BASE_DIR/system/app/SamsungWeather*
rm -rf $BASE_DIR/system/app/SBrowser*
rm -rf $BASE_DIR/system/app/SecureFolder*
rm -rf $BASE_DIR/system/app/SmartCapture
rm -rf $BASE_DIR/system/app/SmartReminder
rm -rf $BASE_DIR/system/app/SmartSwitch*
rm -rf $BASE_DIR/system/app/StoryService
rm -rf $BASE_DIR/system/app/Tips*
rm -rf $BASE_DIR/system/app/Upday*
rm -rf $BASE_DIR/system/app/VideoEditor*
rm -rf $BASE_DIR/system/app/VideoTrimmer
rm -rf $BASE_DIR/system/app/VoiceWakeup
rm -rf $BASE_DIR/system/app/WebManual
rm -rf $BASE_DIR/system/app/Yahoo*
rm -rf $BASE_DIR/system/app/YourPhone*

# ==========================================
# 3. PRIV-APPS (Deep Bloat)
# ==========================================
rm -rf $BASE_DIR/system/priv-app/AppUpdateCenter
rm -rf $BASE_DIR/system/priv-app/AssistantMenu
rm -rf $BASE_DIR/system/priv-app/AutomationTest*
rm -rf $BASE_DIR/system/priv-app/AutoDoodle
rm -rf $BASE_DIR/system/priv-app/Bixby*
rm -rf $BASE_DIR/system/priv-app/CallLogBackup
rm -rf $BASE_DIR/system/priv-app/Crane
rm -rf $BASE_DIR/system/priv-app/Dex*
rm -rf $BASE_DIR/system/priv-app/DesktopMode*
rm -rf $BASE_DIR/system/priv-app/DigitalKey
rm -rf $BASE_DIR/system/priv-app/DigitalWellbeing
rm -rf $BASE_DIR/system/priv-app/DualOutFocusViewer*
rm -rf $BASE_DIR/system/priv-app/EmergencySOS
rm -rf $BASE_DIR/system/priv-app/Excel*
rm -rf $BASE_DIR/system/priv-app/FBInstaller_NS
rm -rf $BASE_DIR/system/priv-app/FBServices
rm -rf $BASE_DIR/system/priv-app/FamilyLink*
rm -rf $BASE_DIR/system/priv-app/Finder*
rm -rf $BASE_DIR/system/priv-app/FotaAgent
rm -rf $BASE_DIR/system/priv-app/GalaxyApps*
rm -rf $BASE_DIR/system/priv-app/GalaxyCare*
rm -rf $BASE_DIR/system/priv-app/Game*
rm -rf $BASE_DIR/system/priv-app/GoogleFeedback
rm -rf $BASE_DIR/system/priv-app/HealthService
rm -rf $BASE_DIR/system/priv-app/Honeyboard
rm -rf $BASE_DIR/system/priv-app/Knox*
rm -rf $BASE_DIR/system/priv-app/LedCoverService
rm -rf $BASE_DIR/system/priv-app/LiveDrawing
rm -rf $BASE_DIR/system/priv-app/LiveStickers
rm -rf $BASE_DIR/system/priv-app/MateAgent
rm -rf $BASE_DIR/system/priv-app/Netflix*
rm -rf $BASE_DIR/system/priv-app/OMCAgent
rm -rf $BASE_DIR/system/priv-app/OneDrive*
rm -rf $BASE_DIR/system/priv-app/OnlineHelp
rm -rf $BASE_DIR/system/priv-app/PeopleStripe
rm -rf $BASE_DIR/system/priv-app/PhotoEditor*
rm -rf $BASE_DIR/system/priv-app/PowerPoint*
rm -rf $BASE_DIR/system/priv-app/Rubin
rm -rf $BASE_DIR/system/priv-app/SOAgent*
rm -rf $BASE_DIR/system/priv-app/SamsungAccount
rm -rf $BASE_DIR/system/priv-app/SamsungBilling
rm -rf $BASE_DIR/system/priv-app/SamsungCloud*
rm -rf $BASE_DIR/system/priv-app/SamsungIntelliVoice*
rm -rf $BASE_DIR/system/priv-app/SamsungMagnifier
rm -rf $BASE_DIR/system/priv-app/SamsungPass*
rm -rf $BASE_DIR/system/priv-app/SamsungPay*
rm -rf $BASE_DIR/system/priv-app/SamsungSocial*
rm -rf $BASE_DIR/system/priv-app/SamsungVideo*
rm -rf $BASE_DIR/system/priv-app/SecureFolder
rm -rf $BASE_DIR/system/priv-app/SendHelpMessage
rm -rf $BASE_DIR/system/priv-app/ShareLive
rm -rf $BASE_DIR/system/priv-app/SingleTake*
rm -rf $BASE_DIR/system/priv-app/SKMSAgent
rm -rf $BASE_DIR/system/priv-app/SmartManager*
rm -rf $BASE_DIR/system/priv-app/SmartSwitch*
rm -rf $BASE_DIR/system/priv-app/SPPPushClient
rm -rf $BASE_DIR/system/priv-app/Sticker*
rm -rf $BASE_DIR/system/priv-app/SystemUpdate*
rm -rf $BASE_DIR/system/priv-app/Tag
rm -rf $BASE_DIR/system/priv-app/Tips*
rm -rf $BASE_DIR/system/priv-app/Upday
rm -rf $BASE_DIR/system/priv-app/Vision*
rm -rf $BASE_DIR/system/priv-app/VoiceWakeup
rm -rf $BASE_DIR/system/priv-app/VRSetup*
rm -rf $BASE_DIR/system/priv-app/Word*
rm -rf $BASE_DIR/system/priv-app/YourPhone*

# ==========================================
# 4. GOOGLE APPS (GApps) - Reduce Size
# ==========================================
# We remove massive Google apps. User can reinstall via Play Store.
rm -rf $product/app/Chrome
rm -rf $product/app/Gmail2
rm -rf $product/app/Maps
rm -rf $product/app/YouTube
rm -rf $product/app/Music2
rm -rf $product/app/Videos
rm -rf $product/app/Photos
rm -rf $product/app/Drive
rm -rf $product/app/Duo
rm -rf $product/app/Meet
rm -rf $product/app/NewsStand
rm -rf $product/app/PlayGames
rm -rf $product/app/Books
rm -rf $product/app/CalendarGoogle
rm -rf $product/app/Talkback
rm -rf $product/app/WebViewGoogle 
# ^ Removing WebViewGoogle saves ~150MB, but ensure SystemWebView is present or install Bromite later. 
# If bootloops occur, remove this line.

rm -rf $product/priv-app/Velvet  # This is the Google App (~300MB+)
rm -rf $product/priv-app/AndroidAutoStub
rm -rf $product/priv-app/Assistant
rm -rf $product/priv-app/Wellbeing

# ==========================================
# 5. CAMERA & FINAL CLEANUP
# ==========================================

# Remove Stock Camera (Libs + APK)
rm -rf $BASE_DIR/system/priv-app/SamsungCamera
rm -rf $BASE_DIR/system/lib64/libSamsungCamera*

# Inject OpenCamera
rsync -ra $SCRIPT_DIR/OpenCamera $BASE_DIR/system/priv-app/

# Switch to AOSP binaries
rsync -ra $SCRIPT_DIR/bin/ $BASE_DIR/system/bin
rsync -ra $SCRIPT_DIR/lib64/ $BASE_DIR/system/lib64

echo "==> Nuclear Debloat Complete."
