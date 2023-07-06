require "language/node"

class GitWorkspace < Formula
  desc "Collection of useful git extensions that enhance one's local dev environment"
  homepage "https://github.com/viqueen/git-workspace"
  url "https://registry.npmjs.org/@labset/git-workspace/-/git-workspace-1.0.0.tgz"
  sha256 "f9933611aa8dbbca1ab7d588a017adc4db0fae35f44b0cf310a572ed89d755d5"
  license "Apache-2.0"

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    system "false"
  end
end
