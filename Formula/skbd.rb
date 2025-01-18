class Skbd < Formula
  desc "Stark Keybind Daemon for macOS, bind keys to shell commands"
  homepage "https://github.com/starkwm/skbd"
  url "https://github.com/starkwm/skbd.git", tag: "v0.0.5", revision: "51f04a31ec059c7683c16e476abbd328d7cfc86c"
  head "https://github.com/starkwm/skbd.git", branch: "main"

  bottle do
    root_url "https://starkwm-builds.s3.amazonaws.com"
    sha256 cellar: :any_skip_relocation, sonoma: "728a2751909c6376a49eec308d55b8fc2f840cb8f34db2637e851b57ffb8d30c"
  end

  depends_on xcode: :build
  depends_on macos: :ventura

  def install
    system "make", "release"
    bin.install "#{buildpath}/.build/release/skbd"
  end

  service do
    run opt_bin/"skbd"
    keep_alive true
    log_path var/"log/skbd/out.log"
    error_log_path var/"log/skbd/err.log"
    environment_variables PATH: std_service_path_env
  end

  test do
    assert_match "skbd version #{version}", shell_output("#{bin}/skbd --version")
  end
end
