require 'formula'

class Venom < Formula
  head "https://github.com/naxuroqa/Venom", :using => :git
  homepage "https://github.com/naxuroqa/Venom"

  depends_on "cmake"
  depends_on "gtk+3"
  depends_on "json-glib"
  depends_on "libgee"
  depends_on "sqlite"
  depends_on "vala"
  depends_on "libtoxcore"

  def install
    system "mkdir", "build"
    chdir "build"
    system "cmake", ".."
    system "make"
    system "make", "install"
  end
end
