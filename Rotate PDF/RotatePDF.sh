#!/bin/bash
cd ~/desktop || exit
/System/Library/Frameworks/Ruby.framework/Versions/2.0/usr/bin/ruby -w
<<'EOF' - 90 *.pdf out
# 
#      ARGV = angle pdf [pdf ...] [output_directory]
# 
#      * angle is measured in clock-wise and must be one of [-270, -180, -90, 90, 180, 270]
#      

require 'osx/cocoa'
OSX.require_framework 'PDFKit'
include OSX

def usage
     raise ArgumentError, "Usage: #{File.basename($0)} angle pdf [pdf ...] [output_directory]"
end

usage unless ARGV.length > 1
outdir = File.directory?(ARGV.last) ? ARGV.pop : nil
usage unless ARGV.length > 1
rota = (ARGV.shift.to_i + 360) % 360
usage unless [90, 180, 270].include? rota

ARGV.select { |f| File.file?(f) }.each do |f|
     url = NSURL.fileURLWithPath(f)
     doc = PDFDocument.alloc.initWithURL(url)
     unless doc
          $stderr.puts "Not a pdf file: %s" % [File.expand_path(f)]
          next
     end
     (0 .. (doc.pageCount - 1)).each { |i| doc.pageAtIndex(i).setRotation(rota) }
     bname = File.basename(f).sub(/\.pdf$/i, '')
     odir = outdir ? outdir : File.dirname(f) 
     doc.writeToFile("#{odir}/#{bname}_RC#{rota}.pdf")
end
EOF

# You may use something like the following script, which will rotate pdf files on desktop by 90° CW (clock-wise) and save the rotated pdfs in ~/desktop/out directory with name with _RC90 appended; e.g. Given original name = abc.pdf, rotated pdf = abc_RC90.pdf. The ouput directory, if specified, must be present in advance. If ouput directory is not specified, rotated file is save in the same directory as the original resides in. Specify -90 or 270 to rotate 90° CCW (counter-clock-wise)
# https://discussions.apple.com/thread/6513696?start=0&tstart=0 