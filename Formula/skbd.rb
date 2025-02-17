class Skbd < Formula
  desc "Stark Keybind Daemon for macOS, bind keys to shell commands"
  homepage "https://github.com/starkwm/skbd"
  url "https://github.com/starkwm/skbd.git", tag: "v0.0.6", revision: "d19b3f748dbfa586196dae4347e04258e8d021a2"
  head "https://github.com/starkwm/skbd.git", branch: "main"

  bottle do
    root_url "https://starkwm-builds.s3.amazonaws.com"
    rebuild 1
    sha256 cellar: :any_skip_relocation, sonoma: "aa465f52fb5cadc1011208c2c24abc611d54e5a5483b6ce32def09fba525e242"
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
    log_path var/"log/skbd.log"
    error_log_path var/"log/skbd.log"
    environment_variables PATH: std_service_path_env
  end

  test do
    assert_match "skbd version #{version}", shell_output("#{bin}/skbd --version")
  end
end
