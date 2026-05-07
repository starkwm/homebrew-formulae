class Swm < Formula
  desc 'Stark Window Manager'
  homepage 'https://github.com/starkwm/swm'
  url 'https://github.com/starkwm/swm.git', tag: 'v0.0.0', revision: '310400e4788bffd050571ef833d6ab2a2da16d4c'
  head 'https://github.com/starkwm/swm.git', branch: 'main'

  # bottle do
  #   root_url 'https://starkwm-builds.s3.amazonaws.com'
  # end

  depends_on xcode: :build

  depends_on arch: :arm64
  depends_on macos: :tahoe

  def install
    system 'make', 'release'
    bin.install "#{buildpath}/.build/release/swm"
  end

  service do
    run opt_bin / 'swm'
    keep_alive true
    log_path var / 'log/swm.log'
    error_log_path var / 'log/swm.log'
    environment_variables PATH: std_service_path_env
  end

  test do
    assert_match 'swm v0.0.0', shell_output("#{bin}/skbd --version")
  end
end
