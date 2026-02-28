class SkbdAT2 < Formula
  desc 'Stark Keybind Daemon for macOS, bind shortcuts to shell commands'
  homepage 'https://github.com/starkwm/skbd.next'
  url 'https://github.com/starkwm/skbd.next.git', tag: 'v0.0.2', revision: '1191e778a8bed6b0938e84747c35d790d8759776'
  head 'https://github.com/starkwm/skbd.next.git', branch: 'main'

  bottle do
    root_url 'https://starkwm-builds.s3.amazonaws.com'
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe: 'b631a9ceddcac81b3b0d0222a43a2d953237552477ff7037dfd089b4ade028ef'
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
