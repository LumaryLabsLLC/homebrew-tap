cask "hyperkeys" do
  version "2.0"
  sha256 "d7f1450bf7790c94c85cdb393da6e4639a63b8acb205dcd3b9b3e0e6b678e57b"

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
