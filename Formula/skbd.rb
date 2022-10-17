class Skbd < Formula
  desc "Stark Keybind Daemon"
  homepage "https://usestark.app"
  url "https://github.com/starkwm/skbd.git", tag: "v0.0.10", revision: "9bd3b25b172a781857646e80b1144aae6b2bc9e3"
  head "https://github.com/starkwm/skbd.git", branch: "main"

  bottle do
    root_url "https://skbd-builds.s3.amazonaws.com"
    sha256 cellar: :any_skip_relocation, monterey: "fe59432dfb0f6f4a82d2740d75598c81b252f5fe04b6762b45a0b3bf690820f3"
  end

  depends_on xcode: :build
  depends_on macos: :monterey

  def install
    system "make", "package"
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
