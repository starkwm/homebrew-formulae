class Stags < Formula
  desc 'Stark window tags for macOS'
  homepage 'https://github.com/starkwm/stags'

  version '0.0.1'

  url "https://github.com/starkwm/stags/archive/refs/tags/v#{version}.tar.gz"
  sha256 'f6d538841e25664f15cc809f4ee6093cc99c29bfc6cd9f3e15d06b8e83f72225'
  license 'BSD-3-Clause'
  head 'https://github.com/starkwm/stags.git', branch: 'main'

  depends_on xcode: :build
  depends_on arch: :arm64
  depends_on macos: :tahoe

  def install
    system 'swift', 'build', '--configuration', 'release', '--disable-sandbox'
    bin.install "#{buildpath}/.build/release/stags"
  end

  service do
    run [opt_bin / 'stags', 'daemon']
    keep_alive true
    log_path var / 'log/stags.log'
    error_log_path var / 'log/stags.log'
    environment_variables PATH: std_service_path_env
  end

  test do
    assert_match "stags version v#{version}", shell_output("#{bin}/stags --version")
  end
end
