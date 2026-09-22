class AgentBeacon < Formula
  desc "MacBook Caps Lock LED status light for Codex"
  homepage "https://github.com/rynzh/Mac-Agent-Beacon"
  url "https://github.com/rynzh/Mac-Agent-Beacon/releases/download/v0.3.0/agent-beacon-0.3.0.tar.gz"
  sha256 "5717f713f7b60caf38d992e4c5dc650c65e5a896d6940bc55006ca4750d88377"
  license "MIT"

  bottle do
    root_url "https://github.com/rynzh/homebrew-tap/releases/download/bottles-35732333969"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "746dcdbe074df015eb04f4e13fc9653674fbab35aec000cff131e32adeced103"
    sha256 cellar: :any_skip_relocation, sequoia:       "0c3b4212fc59a19d8aa65e3840776b52c7cfe0d761dd325bb3286cf011e6891a"
  end

  depends_on macos: :sequoia
  depends_on "ruby"

  def install
    system "make", "all"
    libexec.install "bin", "build"
    (bin/"agent-beacon").write <<~SH
      #!/bin/bash
      export AGENT_BEACON_BREW="#{HOMEBREW_PREFIX}/bin/brew"
      export AGENT_BEACON_RUBY="#{Formula["ruby"].opt_bin}/ruby"
      export AGENT_BEACON_COMMAND="#{opt_bin}/agent-beacon"
      exec "#{opt_libexec}/bin/beacon" "$@"
    SH
    chmod 0755, bin/"agent-beacon"
  end

  service do
    run [opt_bin/"agent-beacon", "run"]
    keep_alive successful_exit: false
    process_type :background
    throttle_interval 30
    log_path var/"log/agent-beacon.log"
    error_log_path var/"log/agent-beacon.log"
  end

  def caveats
    "Run agent-beacon setup, then enable Input Monitoring and trust the Codex hooks."
  end

  test do
    assert_match "Agent Beacon", shell_output("#{bin}/agent-beacon --help")
  end
end
