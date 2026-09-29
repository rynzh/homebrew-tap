class AgentBeacon < Formula
  desc "MacBook Caps Lock LED status light for Codex"
  homepage "https://github.com/rynzh/Mac-Agent-Beacon"
  url "https://github.com/rynzh/Mac-Agent-Beacon/releases/download/v0.3.2/agent-beacon-0.3.2.tar.gz"
  sha256 "4d74b73987027f16ad56a6eb13a60bc8913b48f893b84b8f517f3248fa4636a2"
  license "MIT"

  depends_on macos: :sequoia
  depends_on "ruby"

  def install
    system "make", "all"
    libexec.install "bin", "build"
    (bin/"agent-beacon").write <<~SH
      #!/bin/bash
      export AGENT_BEACON_BREW="#{HOMEBREW_PREFIX}/bin/brew"
      export AGENT_BEACON_RUBY="#{formula_opt_bin("ruby")}/ruby"
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
