cask "muxin" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.13.0"
  sha256 arm:          "b8145ddaf008f587f95d14fdfe91f7d3d9cc8ccfba6f015e4a6a2cc9f689cabb",
         intel:        "b8145ddaf008f587f95d14fdfe91f7d3d9cc8ccfba6f015e4a6a2cc9f689cabb",
         arm64_linux:  "d2886a75bb9096daf403444f007347a66d4d490c6f24a98fed521335935b08c7",
         x86_64_linux: "536d7e70c49eb0d8de778bf8666ba201ba0cb64069d9d5b84d0fdb3a0578bac4"

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
