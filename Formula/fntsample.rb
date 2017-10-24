class Fntsample < Formula
  desc "Program for making font samples"
  homepage "https://github.com/eugmes/fntsample"
  # TODO: add actual release link
  url "https://github.com/eugmes/fntsample/archive/master.tar.gz"
  version "5.0"
  sha256 "c3869cd8aace59cccd96054da146525f603a593b132656417ff08ef1cb8ec83c"

  head "https://github.com/eugmes/fntsample.git"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "gettext"
  depends_on "cairo"
  depends_on "pango"
  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "glib"

  resource "unicode-blocks" do
    url "https://unicode.org/Public/10.0.0/ucd/Blocks.txt"
    sha256 "5ae1649a42ed8ae8cb885af79563f00a9ae17e602405a56ed8aca214da14eea7"
  end

  def install
    resource("unicode-blocks").stage do
      buildpath.install "Blocks.txt"
    end

    mkdir "build" do
      # setlocale is owerriden by libintl for some reaso without this hack... :/
      system "cmake", "..", "-DUNICODE_BLOCKS=#{buildpath}/Blocks.txt", "-DCMAKE_C_FLAGS=-DGNULIB_defined_setlocale", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    system "#{bin}/fntsample", "--help"
  end
end
