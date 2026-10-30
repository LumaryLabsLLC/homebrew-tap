cask "lumary-cam" do
  version "1.3.0"
  sha256 "f44fb660cd94ef18faf148c011ddfe4f1250180fc3785094dad5c62c52c842b1"

  url "https://github.com/LumaryLabsLLC/lumarycam-releases/releases/download/v#{version}/LumaryCam-#{version}.dmg"
  name "Lumary Cam"
  desc "Local-first virtual camera with on-device enhancement and iPhone USB-C input"
  homepage "https://lumarylabs.com/lumarycam"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :tahoe

  app "LumaryCam.app"

  uninstall quit: "com.lumarylabs.lumarycam"

  zap trash: [
    "~/Library/Application Support/LumaryCam",
    "~/Library/Caches/com.lumarylabs.lumarycam",
    "~/Library/Group Containers/group.com.lumarylabs.lumarycam.shared",
    "~/Library/HTTPStorages/com.lumarylabs.lumarycam",
    "~/Library/Preferences/com.lumarylabs.lumarycam.plist",
  ]

  caveats <<~EOS
    The virtual camera requires a one-time system extension approval:
    move the app to /Applications if prompted, then approve it in
    System Settings > General > Login Items & Extensions.
  EOS
end
