class SkbdAT2 < Formula
  desc 'Stark Keybind Daemon for macOS, bind shortcuts to shell commands'
  homepage 'https://github.com/starkwm/skbd.next'
  url 'https://github.com/starkwm/skbd.next.git', tag: 'v0.0.3', revision: '85030171cd70f7a1e4e1d71a87d3787b9785d5ef'
  head 'https://github.com/starkwm/skbd.next.git', branch: 'main'

  bottle do
    root_url 'https://starkwm-builds.s3.amazonaws.com'
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_tahoe: '969cf06e53f7825c0984dff4d5b97685825d17f54ce8197994bf09b278d74a90'
  end

  depends_on xcode: :build

  depends_on arch: :arm64
  depends_on macos: :sequoia

  def install
    system 'make', 'release'
    bin.install "#{buildpath}/.build/release/skbd"
  end

  service do
    run opt_bin / 'skbd'
    keep_alive true
    log_path var / 'log/skbd.next.log'
    error_log_path var / 'log/skbd.next.log'
    environment_variables PATH: std_service_path_env
  end

  test do
    assert_match "skbd #{version}", shell_output("#{bin}/skbd --version")
  end
end
