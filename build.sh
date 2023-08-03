flutter build macos --release
rm -rf ./build/macos/Oshmes\ Terminal.app
mv ./build/macos/Build/Products/Release/oshmes_terminal.app ./build/macos/Oshmes\ Terminal.app
rm -rf ./OshmesTerminal.dmg
npx appdmg ./create_dmg.json ./OshmesTerminal.dmg
