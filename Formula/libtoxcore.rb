require 'formula'

class Libtoxcore < Formula
  head "git://github.com/irungentoo/ProjectTox-Core", :using => :git
  homepage "https://tox.im"

  depends_on "libsodium"

  # Following dependencies are only required in build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "check" => :build
  depends_on "pkg-config" => :build

  depends_on "libconfig" if build.with? "daemon"

  depends_on "opus" unless build.include? "without-av"
  depends_on "libvpx" unless build.include? "without-av"

  option "without-av", "Compile with A/V support"
  option "with-daemon", "Builds the bootstrap server daemon"

  def install
    ENV["PKG_CONFIG_PATH"] = "/usr/local/lib/pkgconfig"

    args = []
    if build.include? "without-av"
      args.push "--disable-av"
    end

    if build.with? "daemon"
      args.push "--enable-daemon"
    end

    system "autoreconf", "-if"
    system "./configure", "--prefix=#{prefix}", *args
    system "make"
    system "make", "install"
  end

  def caveats
    <<-EOF.undent
    libtoxcore has no UI. If you want to make use of it, try Toxic for a CLI:
      brew install --HEAD toxic
    or uTox for a GUI (X11):
      brew install --HEAD utox
    EOF
  end
end
