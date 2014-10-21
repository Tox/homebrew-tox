require 'formula'

class Utox < Formula
  head "git://github.com/notsecure/uTox", :using => :git
  homepage "https://tox.im"

  depends_on "libtoxcore"
  depends_on "freealut"
  depends_on :x11

  def install
    Dir.mkdir("#{prefix}/bin", 0775)

    libs = %w[-ltoxcore -ltoxav -ltoxdns -lresolv
              -framework OpenAL -lX11 -lXext -lXrender
              -lXft -lfontconfig -lfreetype -lvpx]

    cflags = ENV.cflags || ""
    ldflags = ENV.ldflags || ""
    args = cflags.split(" ") + ldflags.split(" ") + libs + Dir["*.c"] + ["png/png.c"]

    system ENV.cc, "-o", "#{prefix}/bin/utox", *args
  end

end
