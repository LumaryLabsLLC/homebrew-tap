cask "lumary-audio" do
  version "1.5.1"
  sha256 "7d1b5dc91739181c36356da1a3eb5380309f131f057515cd782575bb368fddfb"

  url "https://github.com/LumaryLabsLLC/lumaryaudio-releases/releases/download/v#{version}/LumaryAudio-#{version}.dmg"
  name "Lumary Audio"
  desc "Real-time voice processor, virtual microphone and tape recorder"
  homepage "https://github.com/LumaryLabsLLC/lumaryaudio-releases"

  livecheck do
    url :url
    strategy :github_latest
  end

  # The app updates itself (Sparkle).
  auto_updates true
  depends_on macos: :tahoe

  app "LumaryAudio.app"

  uninstall quit: "com.lumarylabs.lumaryaudio"

  # The virtual mic's driver is installed from inside the app, not by this cask, so
  # upgrades (which run uninstall) must leave it; zap removes it.
  zap pkgutil: "com.lumarylabs.lumaryaudio.driver",
      delete:  "/Library/Audio/Plug-Ins/HAL/LumaryAudio.driver",
      trash:   [
        "~/Library/Application Scripts/com.lumarylabs.lumaryaudio",
        "~/Library/Containers/com.lumarylabs.lumaryaudio",
      ]

  caveats <<~EOS
    To use Lumary Audio as a microphone in other apps, press INSTALL next to
    V-MIC on the Live screen once. macOS asks for your administrator password.
    brew uninstall --zap lumary-audio also removes the virtual mic.
  EOS
end
