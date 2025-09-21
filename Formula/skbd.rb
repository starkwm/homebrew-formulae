class Skbd < Formula
  desc "Stark Keybind Daemon for macOS, bind keys to shell commands"
  homepage "https://github.com/starkwm/skbd"
  url "https://github.com/starkwm/skbd.git", tag: "v0.0.7", revision: "39cfcd7d026977a4ed21b1a41dfb28db7e372eaf"
  head "https://github.com/starkwm/skbd.git", branch: "main"

  bottle do
    root_url "https://starkwm-builds.s3.amazonaws.com"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "707ec2d9e67306bd99d3465630dbd8980b2bf3fcf40daf6cf1c5c9fb56d5195d"
  end

  depends_on xcode: :build

  depends_on arch: :arm64
  depends_on macos: :sequoia

  def install
    system "make", "release"
    bin.install "#{buildpath}/.build/release/skbd"
  end

  service do
    run opt_bin/"skbd"
    keep_alive true
    log_path var/"log/skbd.log"
    error_log_path var/"log/skbd.log"
    environment_variables PATH: std_service_path_env
  end

  test do
    assert_match "skbd version #{version}", shell_output("#{bin}/skbd --version")
  end
end
