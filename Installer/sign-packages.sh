#!/bin/sh

cd build

INSTALLER_IDENTITY="Developer ID Installer: E Tagarira (3AMCJ5B2Q4)"
APPLICATION_IDENTITY="Developer ID Application: E Tagarira (3AMCJ5B2Q4)"

SUB_PKG_DESTINATION="Smart-Organise.mpkg/Contents/Packages"

productsign --sign "$INSTALLER_IDENTITY" Smart-Organise-Automator.pkg "$SUB_PKG_DESTINATION/Smart-Organise-Automator.pkg"
productsign --sign "$INSTALLER_IDENTITY" Smart-Organise-Services.pkg "$SUB_PKG_DESTINATION/Smart-Organise-Services.pkg"
productsign --sign "$INSTALLER_IDENTITY" Smart-Organise-FolderActions.pkg "$SUB_PKG_DESTINATION/Smart-Organise-FolderActions.pkg"

productsign --sign "$APPLICATION_IDENTITY" Smart-Organise.mpkg ../Smart-Organise.mpkg
codesign -d -vvvv ../Smart-Organise.mpkg