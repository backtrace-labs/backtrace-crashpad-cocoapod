set -x
set -e

### Setup
rm -rf Sources
rm -rf vendor
mkdir vendor
cd vendor

### Install depot_tools
git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
export PATH=$PATH:${PWD}/depot_tools
fetch Crashpad
gclient sync

### Build Crashpad
cd crashpad
gn gen out/Default
ninja -C out/Default
cd ..

### Replace Crashpad's library with Backtrace's fork
mkdir backtrace-crashpad
cd backtrace-crashpad
git clone https://github.com/backtrace-labs/crashpad.git
cd crashpad
git checkout backtrace
cd .. && cd ..

### Update Crashpad with Backtrace's fork
cp -r backtrace-crashpad/crashpad/. crashpad

### Rebuild Crashpad
cd crashpad
gclient sync
gn gen out/Default
ninja -C out/Default
cd ..

cd .. #  go to vendor's parent directory

### Move generated files to `Sources` directory
rsync -zarv  --prune-empty-dirs --include "*/"  --include="*.a" --include="*.h" --include="out/Default/crashpad_handler" --include="out/Default/crashpad_database_util" --exclude="*" vendor/crashpad Sources

### Clean up
rm -rf vendor
