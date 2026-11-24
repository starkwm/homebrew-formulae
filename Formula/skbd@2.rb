class SkbdAT2 < Formula
  desc 'Stark Keybind Daemon for macOS, bind shortcuts to shell commands'
  homepage 'https://github.com/starkwm/skbd'

  version '0.0.11'

  url "https://github.com/starkwm/skbd/archive/refs/tags/v#{version}.tar.gz"
  sha256 '28298da100d06bfc1796cec64f1da1c075ae2bee44b76c96be982acd8d5ba570'
  license 'BSD-3-Clause'
  head 'https://github.com/starkwm/skbd.git', branch: 'main'

  bottle do
    root_url "https://github.com/starkwm/skbd/releases/download/v0.0.11"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "3081ab508ee115f08cd718fff05aa5d36f1176fe8cb5d11dd57b542005101b5e"
  end

  depends_on xcode: :build
  depends_on arch: :arm64
  depends_on macos: :tahoe

  def install
    system 'make', 'release'
    bin.install "#{buildpath}/.build/release/skbd"
  end

  service do
    run opt_bin / 'skbd'
    keep_alive true
    log_path var / 'log/skbd@2.log'
    error_log_path var / 'log/skbd@2.log'
    environment_variables PATH: std_service_path_env
  end

  test do
    assert_match "skbd v#{version}", shell_output("#{bin}/skbd --version")
  end
end
