class Skbd < Formula
  desc "Stark Keybind Daemon"
  homepage "https://usestark.app"
  url "https://github.com/starkwm/skbd.git", tag: "v0.0.11", revision: "a2afbd559911bbe5aff82342ae702ac8ca46ce94"
  head "https://github.com/starkwm/skbd.git", branch: "main"

  bottle do
    root_url "https://skbd-builds.s3.amazonaws.com"
    sha256 cellar: :any_skip_relocation, ventura: "3f57cb034128f7b696133919a44084bf683816613451602e0db6aaf39be8c818"
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
