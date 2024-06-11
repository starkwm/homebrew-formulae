cask "stark@beta" do
  version :latest
  sha256 :no_check

  url "https://stark-builds.s3.amazonaws.com/stark-beta.zip", verified: "stark-builds.s3.amazonaws.com/"
  name "Stark"
  desc "Power your window management with JavaScript"
  homepage "https://github.com/starkwm/stark"

  conflicts_with cask: ["stark"]
  depends_on macos: :sonoma

  app "Stark.app"

  zap delete: [
    "~/Library/LaunchAgents/app.usestark.Stark.plist",
    "~/Library/Preferences/app.usestark.Stark.plist",
  ]
end
