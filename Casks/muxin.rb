cask "muxin" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.5.6"
  sha256 arm:          "7028e2fa9adee6ea11c696406966b39879f2f0eee79a90041b265d2349bbe4b7",
         intel:        "7028e2fa9adee6ea11c696406966b39879f2f0eee79a90041b265d2349bbe4b7",
         arm64_linux:  "305d24e637387dc13e20ae0594241a90b56db93afd72c1185bdc2fd1fff36ef9",
         x86_64_linux: "b56487673de9fef1b0ffe17cb71055f5f18d15ddb21b9afd4d8186a0c84b59fb"

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
