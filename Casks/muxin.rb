cask "muxin" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.6.0"
  sha256 arm:          "318235ccd00038b1f2dac5d1a834432d77e79c7fadc8bb81418b7766b71cc950",
         intel:        "318235ccd00038b1f2dac5d1a834432d77e79c7fadc8bb81418b7766b71cc950",
         arm64_linux:  "f697fef7ed2027bcb98de8c6ff58032ce1a216401b5e25b43407332ce09c8925",
         x86_64_linux: "0d12438c5dff60c1688e666fa688579e0ca8fc1a6fdc13fb7f0a25f6ffdce837"

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
