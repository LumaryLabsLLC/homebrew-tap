cask "hyperkeys" do
  version "2.4"
  sha256 "1b275e67e5d0c54a76bb78ea7ede5520b9b8a474cc9aad8a27b94c7f66be1b66"

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
