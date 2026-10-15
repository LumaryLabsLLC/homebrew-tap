cask "lumary-audio" do
  version "1.2.1"
  sha256 "9effe55d00a222cb3cf6d84bbb10535edbca2839f27c92748ca749b8c256fc0c"

  url "https://github.com/LumaryLabsLLC/lumaryaudio-releases/releases/download/v#{version}/LumaryAudio-#{version}.dmg"
  name "Lumary Audio"
  desc "Real-time voice processor, virtual microphone and tape recorder"
  homepage "https://github.com/LumaryLabsLLC/lumaryaudio-releases"

  livecheck do
    url :url
    strategy :github_latest
  end

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
