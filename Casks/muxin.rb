cask "muxin" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.14.0"
  sha256 arm:          "f0f1ebea79c7cac241d7ca70754774c5f917681e02ba74df9e197c493c81d403",
         intel:        "f0f1ebea79c7cac241d7ca70754774c5f917681e02ba74df9e197c493c81d403",
         arm64_linux:  "665562e019c4d668fd0a19c7ea90f8eb402e0cc08a4dee868b1326814978cbf0",
         x86_64_linux: "ac39adbaa98b7e1000159a895f35b31f56512919d7fb465d531c43df387d6367"

  on_macos do
    url "https://github.com/LumaryLabsLLC/muxin/releases/download/v#{version}/Muxin-#{version}-macos.dmg"

    depends_on macos: :monterey

    app "Muxin.app"
    binary "#{appdir}/Muxin.app/Contents/MacOS/muxin"
    binary "#{appdir}/Muxin.app/Contents/MacOS/muxin", target: "muxen"
  end
  on_linux do
    url "https://github.com/LumaryLabsLLC/muxin/releases/download/v#{version}/Muxin-#{version}-linux-#{arch}.tar.gz"

    binary "Muxin/muxin"
    binary "Muxin/muxin", target: "muxen"
    artifact "Muxin/muxin.desktop", target: "~/.local/share/applications/muxin.desktop"

    preflight_steps do
      inreplace "Muxin/muxin.desktop", "Exec=muxin", "Exec={{HOMEBREW_PREFIX}}/bin/muxin"
      inreplace "Muxin/muxin.desktop", "Icon=muxin", "Icon={{staged_path}}/Muxin/muxin.png"
    end
  end

  name "Muxin"
  desc "All your machines in one app, for you and your AI agents"
  homepage "https://muxin.dev/"

  livecheck do
    url :url
    strategy :github_latest
  end

  zap trash: [
    "~/.cache/muxen",
    "~/.config/muxen",
    "~/.config/muxin",
    "~/.muxen",
    "~/Library/Caches/muxen",
    "~/Library/Preferences/com.lumarylabs.muxen.plist",
  ]
end
