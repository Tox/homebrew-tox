class Libfilteraudio < Formula
  homepage "https://github.com/irungentoo/filter_audio"
  url "https://github.com/irungentoo/filter_audio.git"

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

end
