cask "muxin" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.5.2"
  sha256 arm:          "2ba5d78434c4c958ffe779c3797e5a3ba11310c112fc3050924544030ee274c8",
         intel:        "2ba5d78434c4c958ffe779c3797e5a3ba11310c112fc3050924544030ee274c8",
         arm64_linux:  "4d7bd733512e86a223cef92f313d4512c00949957c781e3d4aadb1d5ad25a66e",
         x86_64_linux: "f8f2898fc68db1ee761ce4011713c39d5066191d5da18df8dbd6217b1ef11bab"

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
