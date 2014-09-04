require 'formula'

class Utox < Formula
  head "git://github.com/notsecure/uTox", :using => :git
  homepage "https://tox.im"

  depends_on "libtoxcore"
  depends_on "freealut"

  def install
    includes = ["-I/usr/local/include", "-I/usr/X11/include",
                "-I/usr/X11/include/freetype2"]
    libdirs  = ["-L/usr/local/lib", "-L/usr/X11/lib"]
    libs = ["-ltoxcore", "-ltoxav", "-ltoxdns", "-lresolv",
            "-framework", "OpenAL", "-lX11", "-lXext", "-lXrender",
            "-lXft", "-lfontconfig", "-lfreetype", "-lvpx"]
    Dir.mkdir("#{prefix}/bin", 0775)
    system("cc", "-o", "#{prefix}/bin/utox", *includes, *libdirs, *libs,
           *Dir.glob("*.c"), "png/png.c")
  end

end
