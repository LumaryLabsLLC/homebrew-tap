cask "muxin" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.9.0"
  sha256 arm:          "5155a646bf7ea6ce1e7d5e79a7b642f634a97a83b41434521896a18296c38120",
         intel:        "5155a646bf7ea6ce1e7d5e79a7b642f634a97a83b41434521896a18296c38120",
         arm64_linux:  "df974dbede1dc7ab2ff84ca1eac5087ea16502d0354b184b7dcd94f520056f08",
         x86_64_linux: "7d8f56f80d9d0fc746c126d6f2a9c1b99cf3938922b0481302335a0eb8570d74"

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
