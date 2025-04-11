cask "stark" do
  version "2.5.0"
  sha256 "8fdb44b29eddf79e288c5a813bd03877b435447286e94cd1ffbed4147f1ad9d7"

  url "https://starkwm-builds.s3.amazonaws.com/stark-2.5.0.zip", verified: "stark-builds.s3.amazonaws.com/"
  name "Stark"
  desc "Power your window management with JavaScript"
  homepage "https://github.com/starkwm/stark"

  depends_on macos: ">= :sonoma"

  app "Stark.app"

  zap delete: [
    "~/Library/LaunchAgents/app.usestark.Stark.plist",
    "~/Library/Preferences/app.usestark.Stark.plist",
  ]
end
