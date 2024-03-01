class Skbd < Formula
  desc 'Stark Keybind Daemon'
  homepage 'https://github.com/starkwm/skbd'

  url 'https://github.com/starkwm/skbd.git', tag: 'v0.0.2', revision: '14664e07c75e5859d5349261d8d1c59bc893ae86'
  head 'https://github.com/starkwm/skbd.git', branch: 'main'

  bottle do
    root_url 'https://skbd-builds.s3.amazonaws.com'
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sonoma: '0aad7b1d4dc7d8ede56bec1818910ba79ecac3d18db3e77643559a8314d6c650'
    sha256 cellar: :any_skip_relocation, sonoma:       '277a60e386d6b2af7718f94d79278c9ca28f9ab3b15d4b13ec25c346cef457a7'
  end

  depends_on xcode: :build
  depends_on macos: :ventura

  def install
    system 'make', 'release'
    bin.install '#{buildpath}/.build/release/skbd'
  end

  service do
    run opt_bin/'skbd'
    keep_alive true
    log_path var/'log/skbd.log'
    error_log_path var/'log/skbd.log'
    environment_variables PATH: std_service_path_env
  end

  test do
    assert_match 'skbd version #{version}', shell_output('#{bin}/skbd --version')
  end
end
