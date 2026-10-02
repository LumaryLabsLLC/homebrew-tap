cask "hyperkeys" do
  version "2.3"
  sha256 "c20e3cddd34439ac200abeee039f2b8ceb48e84d7f2b4204fd196495b0b1c8f0"

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
