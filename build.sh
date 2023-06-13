flutter build macos --release
mv ./build/macos/Build/Products/Release/cheber_terminal.app ./build/macos/Cheber\ Terminal.app
npx appdmg ./create_dmg.json ./CheberTerminal.dmg
