cask "lights-off" do
  version "0.1.0"
  sha256 "01638206b8e46a6436fcd8b4b7728f2b76205b49753fd41713cea5e1b9da57f6"

  url "https://github.com/matthias-matthies/lights-off/releases/download/v#{version}/lights-off_v#{version}_darwin_arm64.tar.gz"
  name "lights-off"
  desc "Takes GitHub tickets from start to merge using sandboxed agents"
  homepage "https://github.com/matthias-matthies/lights-off"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :sonoma
  depends_on cask: "docker/tap/sbx"
  depends_on formula: "gh"

  binary "lights-off"

  # The binary isn't notarized, and Homebrew quarantines every cask download,
  # so Gatekeeper would refuse to run it.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-d", "com.apple.quarantine", "{{staged_path}}/lights-off"],
        must_succeed: false
  end

  zap trash: [
    "~/.cache/lights-off",
    "~/.config/lights-off",
    "~/.local/state/lights-off",
  ]
end
