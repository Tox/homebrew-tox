require 'formula'

class Ratox < Formula
  homepage 'http://ratox.2f30.org'
  url 'http://git.2f30.org/ratox/snapshot/ratox-0.2.tar.gz'
  sha1 '2fbb39cce23adebff82d70ceb0a397637c9f359e'
  head 'git://git.2f30.org/ratox'

  depends_on 'libtoxcore'

  patch do
    url 'http://ratox.2f30.org/ratox-os_x.patch'
    sha1 '71e0b0d4a3e40a74e80b781c19eca36589422273'
  end

  def install
    system 'make'
    system 'make install'
  end
end
