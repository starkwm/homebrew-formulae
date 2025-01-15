cask "stark@tip" do
  version :latest
  sha256 :no_check

  url "https://stark-builds.s3.amazonaws.com/stark-tip.zip", verified: "stark-builds.s3.amazonaws.com/"
  name "Stark"
  desc "Power your window management with JavaScript"
  homepage "https://github.com/starkwm/stark"

  conflicts_with cask: ["stark"]
  depends_on macos: :sonoma

  app "Stark.app"

  zap delete: [
    "~/Library/LaunchAgents/dev.tombell.Stark.plist",
    "~/Library/Preferences/dev.tombell.Stark.plist",
  ]
end
