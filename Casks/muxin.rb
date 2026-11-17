cask "muxin" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.16.0"
  sha256 arm:          "1daae4a19a8c8c3e30e32e2c4e3b3972e8c4dfb7529f68e128310a4c9a259789",
         intel:        "1daae4a19a8c8c3e30e32e2c4e3b3972e8c4dfb7529f68e128310a4c9a259789",
         arm64_linux:  "ea5f71a1e0dc20f4283b37b5e6ff574bdd5f5fd749b2e059ddcd65e9bc21993a",
         x86_64_linux: "066d393af9ba82f7cd8ce45395c2b7b0186ee4e3e91749bd9d4eae06fcec4996"

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
