#!/bin/sh

cd build

INSTALLER_IDENTITY="Developer ID Installer: E Tagarira (3AMCJ5B2Q4)"
APPLICATION_IDENTITY="Developer ID Application: E Tagarira (3AMCJ5B2Q4)"

SUB_PKG_DESTINATION="Smart-Organise.mpkg/Contents/Packages"

echo ""
productsign --sign "$INSTALLER_IDENTITY" Smart-Organise-Automator.pkg "$SUB_PKG_DESTINATION/Smart-Organise-Automator.pkg"

echo ""
productsign --sign "$INSTALLER_IDENTITY" Smart-Organise-Services.pkg "$SUB_PKG_DESTINATION/Smart-Organise-Services.pkg"

echo ""
productsign --sign "$INSTALLER_IDENTITY" Smart-Organise-FolderActions.pkg "$SUB_PKG_DESTINATION/Smart-Organise-FolderActions.pkg"

echo ""
codesign -s "$APPLICATION_IDENTITY" Smart-Organise.mpkg
codesign -d -vvvv Smart-Organise.mpkg

echo ""
cp -R Smart-Organise.mpkg ../Smart-Organise.mpkg
