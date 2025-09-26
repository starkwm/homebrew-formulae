cask "stark" do
  version "3.0.0"
  sha256 "a7394f3a4f79b536f5e96056d719b7179b88fa9765fa07b760e31b7a9fbd422e"

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
