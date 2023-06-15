flutter build macos --release
rm -rf ./build/macos/Cheber\ Terminal.app
mv ./build/macos/Build/Products/Release/cheber_terminal.app ./build/macos/Cheber\ Terminal.app
rm -rf ./CheberTerminal.dmg
npx appdmg ./create_dmg.json ./CheberTerminal.dmg
