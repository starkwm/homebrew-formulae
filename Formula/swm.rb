class Swm < Formula
  desc 'Stark Window Manager'
  homepage 'https://github.com/starkwm/swm'
  url 'https://github.com/starkwm/swm.git', tag: 'v0.0.2', revision: '7472f429d329e9771fe94891cd40d2e5e5025341'
  head 'https://github.com/starkwm/swm.git', branch: 'main'

  bottle do
    root_url 'https://starkwm-builds.s3.amazonaws.com'
    rebuild 3
    sha256 cellar: :any_skip_relocation, arm64_tahoe: 'df91ef6cf835b92605bcf206fe82d9783bc90e4e5a5fcab5480eab81b6eb5867'
  end

  depends_on xcode: :build

  depends_on arch: :arm64
  depends_on macos: :tahoe

  def install
    system 'make', 'release'
    bin.install "#{buildpath}/.build/release/swm"
    codesign bin / 'swm'
  end

  def codesign(*args)
    system '/usr/bin/codesign', '--force', '--sign', '-', *args
  end

  service do
    run opt_bin / 'swm'
    keep_alive true
    log_path var / 'log/swm.log'
    error_log_path var / 'log/swm.log'
    environment_variables PATH: std_service_path_env
  end

  test do
    assert_match "swm #{version}", shell_output("#{bin}/skbd --version")
  end
end
