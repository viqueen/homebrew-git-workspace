require "language/node"

class GitDevbox < Formula
  desc "Collection of useful git extensions that enhance one's local dev environment"
  homepage "https://github.com/viqueen/git-devbox"
  url "https://registry.npmjs.org/git-devbox/-/git-devbox-2.0.3.tgz"
  sha256 "f2c541017dba4131fe25901662395155a732d33b202122c43590e8b032e2fcdf"
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
