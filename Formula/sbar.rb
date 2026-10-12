class Sbar < Formula
  desc 'Stark Bar for macOS'
  homepage 'https://github.com/starkwm/sbar'

  version '0.0.2'

  url "https://github.com/starkwm/sbar/archive/refs/tags/v#{version}.tar.gz"
  sha256 'aac00d950bf2bccc57a98e39e36e08cecd269666e70030955243bd1ac576039a'
  license 'BSD-3-Clause'
  head 'https://github.com/starkwm/sbar.git', branch: 'main'

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
