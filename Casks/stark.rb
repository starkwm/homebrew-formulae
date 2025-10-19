cask "stark" do
  version "3.0.0"
  sha256 "0b0f6cbdee16fb600260b5a7c2c40e1bba31b3e6446a82c818e6a6e13953fa8d"

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
