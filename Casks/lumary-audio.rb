cask "lumary-audio" do
  version "1.0.0"
  sha256 "4058c7044cb6975b77d66ec40b17b7d40b956d1f5e0ec1498a1bb616b58a08c5"

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

  uninstall quit:    "com.lumarylabs.lumaryaudio",
            pkgutil: "com.lumarylabs.lumaryaudio.driver",
            delete:  "/Library/Audio/Plug-Ins/HAL/LumaryAudio.driver"

  zap trash: [
    "~/Library/Application Scripts/com.lumarylabs.lumaryaudio",
    "~/Library/Containers/com.lumarylabs.lumaryaudio",
  ]

  caveats <<~EOS
    To use Lumary Audio as a microphone in other apps, press INSTALL next to
    V-MIC on the Live screen once. macOS asks for your administrator password.
  EOS
end
