cask "lumary-cam" do
  version "1.2.1"
  sha256 "5631515fb6d942e1d5ad9357f469955de3966fea4d46746686b1ff54d1c3a29c"

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
