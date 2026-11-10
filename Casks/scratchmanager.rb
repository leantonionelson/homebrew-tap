cask "scratchmanager" do
  version "1.5.8,60"
  sha256 "0383cdb5ab3a6e5006c83160ea819cae21ada9025dc5c5f570071b8bda8183b6"

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
