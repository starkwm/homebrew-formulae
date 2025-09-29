cask "stark" do
  version "3.0.0"
  sha256 "6ef606405c1210d47c6200582f27714a8df246ac1ad2c659eb2c0ef3ed5815fb"

  url "https://starkwm-builds.s3.amazonaws.com/stark-3.0.0.zip", verified: "stark-builds.s3.amazonaws.com/"
  name "Stark"
  desc "Power your window management with JavaScript"
  homepage "https://github.com/starkwm/stark"

  conflicts_with cask: ["stark@tip"]
  depends_on macos: ">= :sonoma"

  app "Stark.app"

  zap delete: [
    "~/Library/LaunchAgents/app.usestark.Stark.plist",
    "~/Library/Preferences/app.usestark.Stark.plist",
  ]
end
