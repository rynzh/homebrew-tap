# Agent Beacon Homebrew Tap

Use your MacBook Caps Lock LED to follow Codex tasks.

```sh
brew install rynzh/tap/agent-beacon && agent-beacon setup
```

Enable Input Monitoring for the helper path printed by setup, then review and
trust Agent Beacon hooks in Codex CLI's `/hooks` screen.

Precompiled bottles are built for macOS 15 on Apple Silicon and Intel. Homebrew
manages the Ruby dependency. Other platforms may fall back to source compilation.

```sh
agent-beacon status
brew services restart agent-beacon
brew upgrade agent-beacon
agent-beacon setup
```

To remove the integration and package:

```sh
agent-beacon uninstall
brew uninstall agent-beacon
```

See the [project documentation](https://github.com/rynzh/Mac-Agent-Beacon/blob/main/docs/HOMEBREW.md)
for migration from the source installer, compatibility, and release details.
