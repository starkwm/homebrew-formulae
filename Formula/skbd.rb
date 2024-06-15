class Skbd < Formula
  desc "Stark Keybind Daemon for macOS, bind keys to shell commands"
  homepage "https://github.com/starkwm/skbd"
  url "https://github.com/starkwm/skbd.git", tag: "v0.0.3", revision: "12e296cab7cf9bea778fbcc39813719ca916e5e1"
  head "https://github.com/starkwm/skbd.git", branch: "main"

  bottle do
    root_url "https://skbd-builds.s3.amazonaws.com"
    sha256 cellar: :any_skip_relocation, sonoma: "94a5e73750acd522d9c3da69fc22a703abeee41c81be8f09aeac3b79e232b504"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "39e5ae8168c92f9cac1f12f14b04313080dd2c7062eb1b680c28139988906502"
  end

  depends_on xcode: :build
  depends_on macos: :ventura

  def install
    system "make", "release"
    bin.install "#{buildpath}/.build/release/skbd"
  end

  service do
    run opt_bin/"skbd"
    keep_alive true
    log_path var/"log/skbd/out.log"
    error_log_path var/"log/skbd/err.log"
    environment_variables PATH: std_service_path_env
  end

  test do
    assert_match "skbd version #{version}", shell_output("#{bin}/skbd --version")
  end
end
