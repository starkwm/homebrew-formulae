class Sbar < Formula
  desc 'Stark Bar for macOS'
  homepage 'https://github.com/starkwm/sbar'

  version '0.0.5'

  url "https://github.com/starkwm/sbar/archive/refs/tags/v#{version}.tar.gz"
  sha256 '548df80194926f901618758adc9350b237cf3275b9a5a723c9d28108b13e683d'
  license 'BSD-3-Clause'
  head 'https://github.com/starkwm/sbar.git', branch: 'main'

  bottle do
    root_url "https://github.com/starkwm/sbar/releases/download/v0.0.5"
    sha256 arm64_golden_gate: "4394cf8090edf96cc37b052812b4fbfce7c327ca564885d464720feb3209aa8e"
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
