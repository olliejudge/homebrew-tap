class Dsmactools < Formula
  desc "Controller workbench for Mac game developers"
  homepage "https://github.com/olliejudge/dsmactools"
  url "https://github.com/olliejudge/dsmactools/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "3c027f826dfaad7a03633a7e849f5d866c011050a54f25a10afc3ecdba70cf31"
  license "MIT"

  bottle do
    root_url "https://github.com/olliejudge/dsmactools/releases/download/v0.4.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "d95288eb288f66b3621d41e3b092678e0130ef28223afd68c4e5758a90dd38db"
  end

  env :std if Hardware::CPU.intel?

  depends_on "rust" => :build
  depends_on :macos

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "dsmactools #{version}", shell_output("#{bin}/dsmactools --version")
    assert_match "DS Mac Tools", shell_output("#{bin}/dsmactools --help")
    assert_match "needs a terminal", shell_output("#{bin}/dsmactools --interactive 2>&1", 1)
  end
end
