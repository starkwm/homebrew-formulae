class Swm < Formula
  desc 'Stark Window Manager'
  homepage 'https://github.com/starkwm/swm'

  version '0.0.24'

  url "https://github.com/starkwm/swm/archive/refs/tags/v#{version}tar.gz"
  sha256 'e0b5ca1de9937ff872e69a1adea5abafb945e8214f6be422c8c8937fa65426c0'
  head 'https://github.com/starkwm/swm.git', branch: 'main'

  bottle do
    root_url 'https://github.com/starkwm/swm/releases/download/v0.0.23'
    sha256 cellar: :any_skip_relocation,
           arm64_golden_gate: 'bd43deb7f764d42f38858b8a9daad3e56c62670690ddcdd8175b17b7f8e5deab'
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
    assert_match "swm #{version}", shell_output("#{bin}/swm --version")
  end
end
