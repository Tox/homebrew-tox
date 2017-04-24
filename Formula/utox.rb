require 'formula'

class Utox < Formula
  head "git://github.com/uTox/uTox", :using => :git, :branch => "develop"
  homepage "https://tox.chat"

  depends_on "pkg-config" => :build
  depends_on "cmake" => :build
  depends_on "libtoxcore"
  depends_on "libfilteraudio"

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make"
      prefix.install "utox.app"
    end
  end
end
