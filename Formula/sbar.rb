class Sbar < Formula
  desc 'Stark Bar for macOS'
  homepage 'https://github.com/starkwm/sbar'

  version '0.0.3'

  url "https://github.com/starkwm/sbar/archive/refs/tags/v#{version}.tar.gz"
  sha256 'd0e9fc9fb7240bb5c0cb553baf0daabe0cd60bb385370739935e061a15e9ed14'
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
