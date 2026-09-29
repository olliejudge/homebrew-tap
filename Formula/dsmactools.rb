class Dsmactools < Formula
  desc "Controller workbench for Mac game developers"
  homepage "https://github.com/olliejudge/dsmactools"
  url "https://github.com/olliejudge/dsmactools/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "c8d3a89e661b33fb405212129d30de38c8d5a24935c9910e321467ceb23f4ec9"
  license "MIT"

  depends_on "rust" => :build
  depends_on :macos

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "dsmactools #{version}", shell_output("#{bin}/dsmactools --version")
    assert_match "DS Mac Tools", shell_output("#{bin}/dsmactools --help")
    assert_match "needs a terminal", shell_output("#{bin}/dsmactools --interactive", 1)
  end
end
