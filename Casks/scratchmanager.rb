cask "scratchmanager" do
  version "1.5.6,56"
  sha256 "981b4c2c2245979649eb03f488c9318f306d1fa5de43c5cd0fae3c818a2e64e4"

  url "https://scratchmanager.com/updates/ScratchManager-#{version.csv.first}-#{version.csv.second}.dmg"
  name "ScratchManager"
  desc "Moves app caches, scratch data and folders to an external SSD"
  homepage "https://scratchmanager.com/"

  livecheck do
    url "https://scratchmanager.com/updates/appcast.xml"
    strategy :sparkle
  end

  auto_updates true
  depends_on macos: :sonoma

  app "ScratchManager.app"

  uninstall quit: [
    "com.scratchmanager.app",
    "com.scratchmanager.core",
  ]

  # Application Support/ScratchManager and the ExternalSSD* caches are left alone on purpose:
  # they hold the journals and registry that locate data moved to the SSD, and the internal
  # fallback copies. Deleting them while anything is moved would strand that data.
  zap trash: [
    "~/Library/Caches/com.scratchmanager.app",
    "~/Library/Caches/com.scratchmanager.core",
    "~/Library/HTTPStorages/com.scratchmanager.app",
    "~/Library/Preferences/com.scratchmanager.app.plist",
    "~/Library/Preferences/com.scratchmanager.core.plist",
    "~/Library/Saved Application State/com.scratchmanager.app.savedState",
  ]

  caveats <<~EOS
    Before uninstalling, open ScratchManager and restore anything you moved to your
    external drive back to this Mac. Its records in ~/Library/Application Support/ScratchManager
    are kept even with --zap so moved data is never stranded.
  EOS
end
