class Skbd < Formula
  desc "Stark Keybind Daemon"
  homepage "https://github.com/starkwm/skbd"
  url "https://github.com/starkwm/skbd.git", tag: "v0.0.9", revision: "ddae27606bc92e970b00321fe9631f4300bf0cf8"
  head "https://github.com/starkwm/skbd.git", branch: "main"

  bottle do
    root_url "https://skbd-builds.s3.amazonaws.com"
    sha256 cellar: :any_skip_relocation, monterey: "6c4682b0c7fcef413beb141658ed4e7d11a20a590be1aa87e6903db2a118c581"
  end

  depends_on xcode: :build
  depends_on macos: :monterey

  def install
    system "make", "package"
    bin.install "#{buildpath}/.build/release/skbd"
  end

  service do
    run opt_bin/"skbd"
    keep_alive true
    log_path var/"log/skbd.log"
    error_log_path var/"log/skbd.log"
    environment_variables PATH: std_service_path_env
  end

  test do
    assert_match "skbd version #{version}", shell_output("#{bin}/skbd --version")
  end
end
