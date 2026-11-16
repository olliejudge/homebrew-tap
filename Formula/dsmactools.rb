class Dsmactools < Formula
  desc "Controller workbench for Mac game developers"
  homepage "https://github.com/olliejudge/dsmactools"
  url "https://github.com/olliejudge/dsmactools/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "3c027f826dfaad7a03633a7e849f5d866c011050a54f25a10afc3ecdba70cf31"
  license "MIT"

  bottle do
    root_url "https://github.com/olliejudge/dsmactools/releases/download/v0.4.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "d95288eb288f66b3621d41e3b092678e0130ef28223afd68c4e5758a90dd38db"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4fe071a32619c6c5f785f0f0de8171179a5e30032cfa578f4fbe50de12279f2d"
    sha256 cellar: :any_skip_relocation, tahoe:         "4efb4d955a78318908661b02822c3be64426a2041aafe686f1cd8841c3798701"
    sha256 cellar: :any_skip_relocation, sequoia:       "c3d1ea558ae82da9ec34f20cf0244d45ef3dc54d0fa4c1c6fe0b5adacd82a5a2"
  end

  env :std

  depends_on "rust" => :build
  depends_on :macos

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    # Argument validation runs before any HID access, so no controller or network is needed.
    assert_match "Feedback duration must be 1–30 seconds",
                 shell_output("#{bin}/dsmactools --feedback rumble --duration 99 2>&1", 1)
    assert_match "require --feedback lightbar",
                 shell_output("#{bin}/dsmactools --feedback rumble --color red 2>&1", 1)
    assert_match "end must exceed start",
                 shell_output("#{bin}/dsmactools --feedback triggers --effect weapon --start 5 --end 3 2>&1", 1)
    assert_match "Only Sony DualSense and DualSense Edge",
                 shell_output("#{bin}/dsmactools --feedback rumble --pid 0x1234 2>&1", 1)
    assert_match "Use a color name",
                 shell_output("#{bin}/dsmactools --feedback lightbar --color notacolor 2>&1", 2)
    assert_match "needs a terminal", shell_output("#{bin}/dsmactools --interactive 2>&1", 1)
  end
end
