class Vouch < Formula
  desc "Hardware-backed identity for developers"
  homepage "https://github.com/vouch-sh/vouch"
  version "2026.8.3"
  license "Apache-2.0 OR MIT"

  on_macos do
    on_arm do
      url "https://github.com/vouch-sh/vouch/releases/download/v2026.8.3/vouch-v2026.8.3-aarch64-apple-darwin.tar.gz"
      sha256 "e8b9ec14dbc8238584f555b3ceb34cac1af2a0b8db95a3686405bab0bfcaa589"
    end
  end

  def install
    bin.install "vouch"
    bin.install "vouch-agent"
    generate_completions_from_executable(bin/"vouch", "completions")
  end

  service do
    run [opt_bin/"vouch-agent", "--foreground"]
    keep_alive true
    log_path var/"log/vouch-agent.log"
    error_log_path var/"log/vouch-agent.log"
  end

  def caveats
    <<~EOS
      To restart the vouch-agent service after upgrading:
        brew services restart vouch
    EOS
  end

  test do
    assert_match "vouch", shell_output("#{bin}/vouch --version")
  end
end
