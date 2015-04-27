class Libfilteraudio < Formula
  homepage "https://github.com/irungentoo/filter_audio"
  url "https://github.com/irungentoo/filter_audio.git"

  def install
    ENV["CFLAGS"] = "-mmacosx-version-min=10.6"
    ENV["LDFLAGS"] = "-mmacosx-version-min=10.6"
    system "make", "install", "PREFIX=#{prefix}"
  end

end
