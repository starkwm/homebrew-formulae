class SkbdAT2 < Formula
  desc "Stark Keybind Daemon for macOS, bind shortcuts to shell commands"
  homepage "https://github.com/starkwm/skbd"

  url "https://github.com/starkwm/skbd/archive/refs/tags/v0.0.7.tar.gz"
  sha256 "7ed9985fc861bf3073f3a8169998282ff5613155b696713a82179e3d3360ad8b"
  head "https://github.com/starkwm/skbd.git", branch: "main"

  bottle do
    root_url "https://starkwm-builds.s3.amazonaws.com"
    rebuild 3
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "d38b300f9f24939537906bc5293910bac3f5e2448d6ca955f5fe4aa3a5cf924d"
  end

  depends_on xcode: :build
  depends_on arch: :arm64
  depends_on macos: :sequoia

  def install
    system "make", "release"
    bin.install "#{buildpath}/.build/release/skbd"
  end

  service do
    run opt_bin / "skbd"
    keep_alive true
    log_path var / "log/skbd@2.log"
    error_log_path var / "log/skbd@2.log"
    environment_variables PATH: std_service_path_env
  end

  test do
    assert_match "skbd #{version}", shell_output("#{bin}/skbd --version")
  end
end
