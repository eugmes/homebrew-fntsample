class Fntsample < Formula
  desc "Program for making font samples"
  homepage "https://github.com/eugmes/fntsample"
  url "https://github.com/eugmes/fntsample/archive/release/5.4.tar.gz"
  sha256 "69eb3d83bce78b6610f4a8f19d089059079ebc475c36d456ebcb4c8add431166"

  head "https://github.com/eugmes/fntsample.git"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "cairo"
  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "gettext"
  depends_on "glib"
  depends_on "pango"

  resource "unicode-blocks" do
    url "https://unicode.org/Public/13.0.0/ucd/Blocks.txt"
    sha256 "81a82b6a9fcf1a9c12f588d7a1decd73a9afdc4cac95b0eb7e576e7942d6c19f"
  end

  def install
    resource("unicode-blocks").stage do
      buildpath.install "Blocks.txt"
    end

    system "cmake", "-Bbuild", "-DUNICODE_BLOCKS=#{buildpath}/Blocks.txt", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system "#{bin}/fntsample", "--help"
  end
end
