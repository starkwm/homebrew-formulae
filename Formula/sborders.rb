class Sborders < Formula
  desc 'Stark Borders for macOS'
  homepage 'https://github.com/starkwm/sborders'

  version '0.0.1'

  url "https://github.com/starkwm/sborders/archive/refs/tags/v#{version}.tar.gz"
  sha256 '918b2600b0075d4b8dfd9b97654a49bdc1c2b174c62eac2db3d0978c82d94017'
  license 'BSD-3-Clause'
  head 'https://github.com/starkwm/sborders.git', branch: 'main'

  bottle do
    root_url 'https://github.com/starkwm/sborders/releases/download/v0.0.1'
    sha256 cellar: :any_skip_relocation,
           arm64_golden_gate: '44c3c84a379922095e552966c5b2a9fe96cbc38ffcf4828c984fae25853a4cbf'
  end

  depends_on xcode: :build
  depends_on arch: :arm64
  depends_on macos: :tahoe

  def install
    system 'swift', 'build', '--configuration', 'release', '--disable-sandbox'
    bin.install "#{buildpath}/.build/release/sborders"
    generate_completions_from_executable bin / 'sborders', '--generate-completion-script'
  end

  service do
    run opt_bin / 'sborders'
    keep_alive true
    log_path var / 'log/sborders.log'
    error_log_path var / 'log/sborders.log'
    environment_variables PATH: std_service_path_env
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/sborders --version")
  end
end
