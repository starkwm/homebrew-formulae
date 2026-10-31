class SkbdAT2 < Formula
  desc 'Stark Keybind Daemon for macOS, bind shortcuts to shell commands'
  homepage 'https://github.com/starkwm/skbd'

  version '0.0.8'

  url "https://github.com/starkwm/skbd/archive/refs/tags/v#{version}.tar.gz"
  sha256 'd3f6610b44127e645acdeb67151490ba8f0da3ccf6208f7b78505966b4098c40'
  license 'BSD-3-Clause'
  head 'https://github.com/starkwm/skbd.git', branch: 'main'

  bottle do
    root_url 'https://github.com/starkwm/skbd/releases/download/v0.0.8'
    sha256 cellar: :any_skip_relocation,
           arm64_golden_gate: '3256b96e0764779e142fabba79d076e037a4b495f90e05681954eeeb9a2997c5'
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
    log_path var / 'log/skbd@2.log'
    error_log_path var / 'log/skbd@2.log'
    environment_variables PATH: std_service_path_env
  end

  test do
    assert_match "skbd #{version}", shell_output("#{bin}/skbd --version")
  end
end
