class Swm < Formula
  desc 'Stark Window Manager'
  homepage 'https://github.com/starkwm/swm'

  version '0.0.34'

  url "https://github.com/starkwm/swm/archive/refs/tags/v#{version}.tar.gz"
  sha256 '56df1232563fc644885ab3a5e018acfb142fcf412d1715d37713f37beaf30383'
  license 'BSD-3-Clause'
  head 'https://github.com/starkwm/swm.git', branch: 'main'

  bottle do
    root_url "https://github.com/starkwm/swm/releases/download/v0.0.34"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "dd7195b7df35e396eea9f17c7d0533389cbb333f102ccf9605697ab602690d8d"
  end

  depends_on xcode: :build
  depends_on arch: :arm64
  depends_on macos: :tahoe

  def install
    system 'make', 'release'
    bin.install "#{buildpath}/.build/release/swm"
    generate_completions_from_executable bin / 'swm', '--generate-completion-script'
  end

  service do
    run opt_bin / 'swm'
    keep_alive true
    log_path var / 'log/swm.log'
    error_log_path var / 'log/swm.log'
    environment_variables PATH: std_service_path_env
  end

  test do
    assert_match "swm version v#{version}", shell_output("#{bin}/swm --version")
  end
end
