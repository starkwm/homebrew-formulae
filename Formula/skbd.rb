class Skbd < Formula
  desc "Stark Keybind Daemon for macOS, bind keys to shell commands"
  homepage "https://github.com/starkwm/skbd"
  url "https://github.com/starkwm/skbd.git", tag: "v0.0.4", revision: "ae492af5a5ab6210040b3929bad99aa42c2ba002"
  head "https://github.com/starkwm/skbd.git", branch: "main"

  bottle do
    root_url "https://skbd-builds.s3.amazonaws.com"
    sha256 cellar: :any_skip_relocation, sonoma: "bab350a352a3c53f5a2d2b6c6dc7022ed3dcec22d09bb19a424f3d9f0de420e1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "f0a978dd69232474bea7210eeb26fe7066eeb73ba4935147b0aaa2c65a93c88f"
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
