cask "hyperkeys" do
  version "2.2"
  sha256 "502d8c371e64f22e2ab435028b4c0323c0ca84e0de2c2f2ee2fcd57467f88328"

  url "https://github.com/LumaryLabsLLC/hyperkeysapp/releases/download/v#{version}/HyperKeys.zip"
  name "HyperKeys"
  desc "Turn Caps Lock into a Hyper key for app, window and menu shortcuts"
  homepage "https://github.com/LumaryLabsLLC/hyperkeysapp"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sequoia

  app "HyperKeys.app"

  uninstall quit: "com.hyperkeys.app"

  zap trash: [
    "~/Library/Application Support/HyperKeys",
    "~/Library/Caches/com.hyperkeys.app",
    "~/Library/Preferences/com.hyperkeys.app.plist",
  ]

  caveats <<~EOS
    HyperKeys needs Accessibility and Input Monitoring access.
    Grant both in System Settings > Privacy & Security when it asks.
  EOS
end
