class AgentBeacon < Formula
  desc "MacBook Caps Lock LED status light for Codex"
  homepage "https://github.com/rynzh/Mac-Agent-Beacon"
  url "https://github.com/rynzh/Mac-Agent-Beacon/releases/download/v0.2.1/agent-beacon-0.2.1.tar.gz"
  sha256 "7c85fb6f49ff8653f2c957bb29d5fc3faae039849a49a69ec5fc958a3fdfbc90"
  license "MIT"

  bottle do
    root_url "https://github.com/rynzh/homebrew-tap/releases/download/bottles-35699086854"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c2fc37a7698c32dc5625e23cba0ab28dc7086f7352fc540b41019ad4ccf6e917"
    sha256 cellar: :any_skip_relocation, sequoia:       "9449df8add5779310a3b80dbcd502799b545e7ca485e6044a2c17e2523e31b36"
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
