class Sbar < Formula
  desc 'Stark Bar for macOS'
  homepage 'https://github.com/starkwm/sbar'

  version '0.0.4'

  url "https://github.com/starkwm/sbar/archive/refs/tags/v#{version}.tar.gz"
  sha256 '1718a5393ec194d027bd515551951c1bf826b1406c418c7ece098623a727ca6a'
  license 'BSD-3-Clause'
  head 'https://github.com/starkwm/sbar.git', branch: 'main'

  bottle do
    root_url "https://github.com/starkwm/sbar/releases/download/v0.0.4"
    sha256 arm64_golden_gate: "f51fe6fff80d3f3a95d83692e3ca7b3116276cca50b69ce84fdf9f1e07e6f637"
  end

  depends_on xcode: :build
  depends_on arch: :arm64
  depends_on macos: :tahoe

  def install
    system 'make', 'release'
    bin.install "#{buildpath}/.build/release/sbar"
    generate_completions_from_executable bin / 'sbar', '--generate-completion-script'
  end

  service do
    run opt_bin / 'sbar'
    keep_alive true
    log_path var / 'log/sbar.log'
    error_log_path var / 'log/sbar.log'
    environment_variables PATH: std_service_path_env
  end

  test do
    assert_match "sbar version v#{version}", shell_output("#{bin}/sbar --version")
  end
end
