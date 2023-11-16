flutter build macos --release
rm -rf ./build/macos/Klin.app
mv ./build/macos/Build/Products/Release/klin.app ./build/macos/Klin.app
rm -rf ./Klin.dmg
npx appdmg ./create_dmg.json ./Klin.dmg
