require "language/node"

class GitDevbox < Formula
  desc "Collection of useful git extensions that enhance one's local dev environment"
  homepage "https://github.com/viqueen/git-devbox"
  url "https://registry.npmjs.org/git-devbox/-/git-devbox-2.0.2.tgz"
  sha256 "bbbf0e7f5a26b7780135c5793519dfa2552fba6465d4bf23d495b972c476c813"
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
