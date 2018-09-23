# This file is generated by rake. Do not edit.

##
# The Zlib module contains several classes for compressing and decompressing
# streams, and for working with "gzip" files.
#
# == Classes
#
# Following are the classes that are most likely to be of interest to the
# user:
# - Zlib::Inflate
# - Zlib::Deflate
# - Zlib::GzipReader
# - Zlib::GzipWriter
#
# There are two important base classes for the classes above: Zlib::ZStream
# and Zlib::GzipFile.  Everything else is an error class.
#
# == Constants
#
# Here's a list.
#
#   Zlib::VERSION
#       The Ruby/zlib version string.
#
#   Zlib::ZLIB_VERSION
#       The string which represents the version of zlib.h.
#
#   Zlib::BINARY
#   Zlib::ASCII
#   Zlib::UNKNOWN
#       The integers representing data types which Zlib::ZStream#data_type
#       method returns.
#
#   Zlib::NO_COMPRESSION
#   Zlib::BEST_SPEED
#   Zlib::BEST_COMPRESSION
#   Zlib::DEFAULT_COMPRESSION
#       The integers representing compression levels which are an argument
#       for Zlib::Deflate.new, Zlib::Deflate#deflate, and so on.
#
#   Zlib::FILTERED
#   Zlib::HUFFMAN_ONLY
#   Zlib::DEFAULT_STRATEGY
#       The integers representing compression methods which are an argument
#       for Zlib::Deflate.new and Zlib::Deflate#params.
#
#   Zlib::DEF_MEM_LEVEL
#   Zlib::MAX_MEM_LEVEL
#       The integers representing memory levels which are an argument for
#       Zlib::Deflate.new, Zlib::Deflate#params, and so on.
#
#   Zlib::MAX_WBITS
#       The default value of windowBits which is an argument for
#       Zlib::Deflate.new and Zlib::Inflate.new.
#
#   Zlib::NO_FLUSH
#   Zlib::SYNC_FLUSH
#   Zlib::FULL_FLUSH
#   Zlib::FINISH
#       The integers to control the output of the deflate stream, which are
#       an argument for Zlib::Deflate#deflate and so on.
#--
# These constants are missing!
#
#   Zlib::OS_CODE
#   Zlib::OS_MSDOS
#   Zlib::OS_AMIGA
#   Zlib::OS_VMS
#   Zlib::OS_UNIX
#   Zlib::OS_VMCMS
#   Zlib::OS_ATARI
#   Zlib::OS_OS2
#   Zlib::OS_MACOS
#   Zlib::OS_ZSYSTEM
#   Zlib::OS_CPM
#   Zlib::OS_TOPS20
#   Zlib::OS_WIN32
#   Zlib::OS_QDOS
#   Zlib::OS_RISCOS
#   Zlib::OS_UNKNOWN
#       The return values of Zlib::GzipFile#os_code method.

module Zlib

  ZLIB_VERSION = "1.2.3"
  BEST_COMPRESSION = 9
  BEST_SPEED = 1
  BLOCK = 5
  BUF_ERROR = -5
  DATA_ERROR = -3
  DEFAULT_COMPRESSION = -1
  DEFAULT_STRATEGY = 0
  DEFLATED = 8
  ERRNO = -1
  FILTERED = 1
  FINISH = 4
  FIXED = 4
  FULL_FLUSH = 3
  HUFFMAN_ONLY = 2
  MEM_ERROR = -4
  NEED_DICT = 2
  NO_COMPRESSION = 0
  NO_FLUSH = 0
  OK = 0
  PARTIAL_FLUSH = 1
  RLE = 3
  STREAM_END = 1
  STREAM_ERROR = -2
  SYNC_FLUSH = 2
  VERSION_ERROR = -6











  # DEF_MEM_LEVEL not available
  MAX_MEM_LEVEL = 9
  MAX_WBITS = 15






  OS_MSDOS    = 0x00
  OS_AMIGA    = 0x01
  OS_VMS      = 0x02
  OS_UNIX     = 0x03
  OS_ATARI    = 0x05
  OS_OS2      = 0x06
  OS_MACOS    = 0x07
  OS_TOPS20   = 0x0a
  OS_WIN32    = 0x0b
  
  OS_VMCMS    = 0x04
  OS_ZSYSTEM  = 0x08
  OS_CPM      = 0x09
  OS_QDOS     = 0x0c
  OS_RISCOS   = 0x0d
  OS_UNKNOWN  = 0xff

  # OS_CODE not available






  unless defined? OS_CODE then
    OS_CODE = OS_UNIX
  end

  # from zutil.h
  unless defined? DEF_MEM_LEVEL then
    DEF_MEM_LEVEL = MAX_MEM_LEVEL >= 8 ? 8 : MAX_MEM_LEVEL
  end

  class Error < StandardError; end

  class StreamEnd < Error; end
  class NeedDict < Error; end
  class StreamError < Error; end
  class DataError < Error; end
  class BufError < Error; end
  class VersionError < Error; end
  class MemError < Error; end

  ##
  # Zlib::ZStream is the abstract class for the stream which handles the
  # compressed data. The operations are defined in the subclasses:
  # Zlib::Deflate for compression, and Zlib::Inflate for decompression.
  #
  # An instance of Zlib::ZStream has one stream (struct zstream in the source)
  # and two variable-length buffers which associated to the input (next_in) of
  # the stream and the output (next_out) of the stream. In this document,
  # "input buffer" means the buffer for input, and "output buffer" means the
  # buffer for output.
  #
  # Data input into an instance of Zlib::ZStream are temporally stored into
  # the end of input buffer, and then data in input buffer are processed from
  # the beginning of the buffer until no more output from the stream is
  # produced (i.e. until avail_out > 0 after processing).  During processing,
  # output buffer is allocated and expanded automatically to hold all output
  # data.
  #
  # Some particular instance methods consume the data in output buffer and
  # return them as a String.
  #
  # Here is an ascii art for describing above:
  #
  #    +================ an instance of Zlib::ZStream ================+
  #    ||                                                            ||
  #    ||     +--------+          +-------+          +--------+      ||
  #    ||  +--| output |<---------|zstream|<---------| input  |<--+  ||
  #    ||  |  | buffer |  next_out+-------+next_in   | buffer |   |  ||
  #    ||  |  +--------+                             +--------+   |  ||
  #    ||  |                                                      |  ||
  #    +===|======================================================|===+
  #        |                                                      |
  #        v                                                      |
  #    "output data"                                         "input data"
  #
  # If an error occurs during processing input buffer, an exception which is a
  # subclass of Zlib::Error is raised.  At that time, both input and output
  # buffer keep their conditions at the time when the error occurs.
  #
  # == Method Catalogue
  #
  # Many of the methods in this class are fairly low-level and unlikely to be
  # of interest to users.  In fact, users are unlikely to use this class
  # directly; rather they will be interested in Zlib::Inflate and
  # Zlib::Deflate.
  #
  # The higher level methods are listed below.
  #
  # - #total_in
  # - #total_out
  # - #data_type
  # - #adler
  # - #reset
  # - #finish
  # - #finished?
  # - #close
  # - #closed?

  class ZStream < FFI::Struct

    self.size = 64
    layout :next_in, :pointer, 0,
           :avail_in, :uint, 4,
           :total_in, :ulong, 8,
           :next_out, :pointer, 16,
           :avail_out, :uint, 20,
           :total_out, :ulong, 24,
           :msg, :string, 32,
           :state, :pointer, 36,
           :zalloc, :pointer, 40,
           :zfree, :pointer, 44,
           :opaque, :pointer, 48,
           :data_type, :int, 52,
           :adler, :ulong, 56,
           :reserved, :ulong, 60










    #--
    # HACK from MRI's zlib.c
    #++

    READY = 0x1
    IN_STREAM = 0x2
    FINISHED = 0x4
    CLOSING = 0x8
    UNUSED = 0x10

    attr_accessor :flags

    attr_reader :input

    attr_reader :output

    def self.inherited(subclass)
      subclass.instance_variable_set :@layout, @layout
      subclass.instance_variable_set :@size, @size
    end

    def initialize
      super

      self[:avail_in] = 0
      self[:avail_out] = 0
      self[:next_in] = nil
      self[:opaque] = nil
      self[:zalloc] = nil
      self[:zfree] = nil

      reset_input
      @output = nil
      @flags = 0
      @func = nil
    end

    def closing?
      @flags & CLOSING == CLOSING
    end

    def detatch_output
      if @output.nil? then
        data = ''
      else
        data = @output

        @output = nil
        self[:avail_out] = 0
        self[:next_out] = nil
      end

      data
    end

    ##
    # Closes the stream. All operations on the closed stream will raise an
    # exception.

    def end
      unless ready? then
        warn "attempt to close uninitialized stream; ignored."
        return nil
      end

      if in_stream? then
        warn "attempt to close unfinished zstream; reset forced"
        reset
      end

      reset_input

      err = Zlib.send @func_end, pointer

      Zlib.handle_error err, message

      @flags = 0

      # HACK this may be wrong
      @output = nil
      @next_out.free unless @next_out.nil?
      @next_out = nil

      nil
    end

    alias :close :end

    def expand_output
      if @output.nil? then
        @output = ''
        @next_out = MemoryPointer.new CHUNK if @next_out.nil?
        @next_out.write_string "\000" * CHUNK
        self[:next_out] = @next_out
      else
        have = CHUNK - self[:avail_out]
        @output << @next_out.read_string(have)

        self[:next_out] = @next_out # Zlib advances self[:next_out]
      end

      self[:avail_out] = CHUNK
    end

    ##
    # Finishes the stream and flushes output buffer. See Zlib::Deflate#finish
    # and Zlib::Inflate#finish for details of this behavior.

    def finish
      run '', Zlib::FINISH

      detatch_output
    end

    ##
    # Returns true if the stream is finished.

    def finished?
      @flags & FINISHED == FINISHED
    end

    ##
    # Flushes output buffer and returns all data in that buffer.

    def flush_next_out
      detatch_output
    end

    def in_stream?
      @flags & IN_STREAM == IN_STREAM
    end

    def input_empty?
      @input.nil? or @input.empty?
    end

    ##
    # The msg field of the struct

    def message
      self[:msg]
    end

    def ready
      @flags |= READY
    end

    def ready?
      @flags & READY == READY
    end

    ##
    # Resets and initializes the stream. All data in both input and output
    # buffer are discarded.

    def reset
      err = Zlib.send @func_reset, pointer

      Zlib.handle_error err, message

      @flags = READY

      reset_input
    end

    def reset_input
      @input = nil
    end

    def run(data, flush)
      if @input.nil? and data.empty? then
        data_in = MemoryPointer.new 1
        data_in.write_string "\000", 1
        self[:next_in] = data_in
        self[:avail_in] = 0
      else
        @input ||= ''
        @input << data

        data_in = MemoryPointer.new @input.length
        data_in.write_string @input, @input.length
        self[:next_in] = data_in
        self[:avail_in] = @input.length
      end

      expand_output if self[:avail_out] == 0

      loop do
        err = Zlib.send @func_run, pointer, flush

        available = self[:avail_out]

        expand_output # HACK does this work when err is set?

        if err == Zlib::STREAM_END then
          @flags &= ~IN_STREAM
          @flags |= FINISHED
          break
        end

        unless err == Zlib::OK then
          if flush != Zlib::FINISH and err == Zlib::BUF_ERROR and
             self[:avail_out] > 0 then
            @flags |= IN_STREAM
            break
          end

          if self[:avail_in] > 0 then
            @input = self[:next_in].read_string(self[:avail_in]) + @input
          end

          Zlib.handle_error err, message
        end

        if available > 0 then
          @flags |= IN_STREAM
          break
        end
      end

      reset_input

      if self[:avail_in] > 0 then
        @input = self[:next_in].read_string self[:avail_in]
      end
    ensure
      data_in.free
      self[:next_in] = nil
    end

    ##
    # Returns the number of bytes consumed

    def total_in
      self[:total_in]
    end

    ##
    # Returns the number bytes processed

    def total_out
      self[:total_out]
    end

  end

  set_ffi_lib 'libz'

  # deflateInit2 is a macro pointing to deflateInit2_
  attach_function :deflateInit2_, [
                    :pointer, # z_streamp strm
                    :int,     # int level
                    :int,     # int method
                    :int,     # int windowBits
                    :int,     # int memLevel
                    :int,     # int strategy
                    :string,  # ZLIB_VERSION
                    :int      # (int)sizeof(z_stream)
                  ], :int

  def self.deflateInit2(stream, level, method, window_bits, mem_level, strategy)
    deflateInit2_ stream, level, method, window_bits, mem_level, strategy,
                  ZLIB_VERSION, ZStream.size
  end

  attach_function :deflate,         [:pointer, :int], :int
  attach_function :deflateEnd,      [:pointer],       :int
  attach_function :deflateParams,   [:pointer, :int, :int],
                  :int
  attach_function :deflateReset,    [:pointer],       :int
  attach_function :deflateSetDictionary,
                  [:pointer, :string, :uint], :int

  # inflateInit2 is a macro pointing to inflateInit2_
  attach_function :inflateInit2_,
                  [:pointer, :int, :string, :int], :int

  def self.inflateInit2(stream, window_bits)
    inflateInit2_ stream, window_bits, ZLIB_VERSION, ZStream.size
  end

  attach_function :inflate,         [:pointer, :int], :int
  attach_function :inflateEnd,      [:pointer],       :int
  attach_function :inflateReset,    [:pointer],       :int
  attach_function :inflateSetDictionary,
                  [:pointer, :string, :uint], :int

  attach_function :adler32_c,       :adler32,         [:ulong, :string, :uint],
                  :ulong
  attach_function :crc32_c,         :crc32,           [:ulong, :string, :uint],
                  :ulong
  attach_function :get_crc_table_c, :get_crc_table,   [], :pointer

  attach_function :zError, [:int], :string

  # Chunk size for inflation and deflation

  CHUNK = 1024

  #--
  # HACK from zlib.c
  #++

  GZ_EXTRAFLAG_FAST = 0x4
  GZ_EXTRAFLAG_SLOW = 0x2

  ##
  # Zlib::Deflate is the class for compressing data.  See Zlib::ZStream for
  # more information.

  class Deflate < ZStream

    ##
    # Compresses the given +string+. Valid values of level are
    # <tt>Zlib::NO_COMPRESSION</tt>, <tt>Zlib::BEST_SPEED</tt>,
    # <tt>Zlib::BEST_COMPRESSION</tt>, <tt>Zlib::DEFAULT_COMPRESSION</tt>, and
    # an integer from 0 to 9.
    #
    # This method is almost equivalent to the following code:
    #
    #   def deflate(string, level)
    #     z = Zlib::Deflate.new(level)
    #     dst = z.deflate(string, Zlib::FINISH)
    #     z.close
    #     dst
    #   end

    def self.deflate(data, level = Zlib::DEFAULT_COMPRESSION)
      deflator = new level

      zipped = deflator.deflate data, Zlib::FINISH

      zipped
    ensure
      deflator.end
    end

    ##
    # Creates a new deflate stream for compression. See zlib.h for details of
    # each argument. If an argument is nil, the default value of that argument
    # is used.

    def initialize(level = Zlib::DEFAULT_COMPRESSION,
                   window_bits = Zlib::MAX_WBITS,
                   mem_level = Zlib::DEF_MEM_LEVEL,
                   strategy = Zlib::DEFAULT_STRATEGY)
      level ||= Zlib::DEFAULT_COMPRESSION
      window_bits ||= Zlib::MAX_WBITS
      mem_level ||= Zlib::DEF_MEM_LEVEL
      strategy ||= Zlib::DEFAULT_STRATEGY

      super()

      @func_end = :deflateEnd
      @func_reset = :deflateReset
      @func_run = :deflate

      err = Zlib.deflateInit2(pointer, level, Zlib::DEFLATED,
                              window_bits, mem_level, strategy)

      Zlib.handle_error err, message

      ready
    end

    ##
    # Same as IO.

    def <<(data)
      do_deflate data, Zlib::NO_FLUSH

      self
    end

    ##
    # Inputs +string+ into the deflate stream and returns the output from the
    # stream.  On calling this method, both the input and the output buffers
    # of the stream are flushed. If +string+ is nil, this method finishes the
    # stream, just like Zlib::ZStream#finish.
    #
    # The value of +flush+ should be either <tt>Zlib::NO_FLUSH</tt>,
    # <tt>Zlib::SYNC_FLUSH</tt>, <tt>Zlib::FULL_FLUSH</tt>, or
    # <tt>Zlib::FINISH</tt>. See zlib.h for details.

    def deflate(data, flush = Zlib::NO_FLUSH)
      do_deflate data, flush

      detatch_output
    end

    ##
    # Performs the deflate operation and leaves the compressed data in the
    # output buffer

    def do_deflate(data, flush)
      if data.nil? then
        run '', Zlib::FINISH
      else
        data = StringValue data

        if flush != Zlib::NO_FLUSH or not data.empty? then # prevent BUF_ERROR
          run data, flush
        end
      end
    end

    ##
    # Finishes compressing the deflate input stream and returns the output
    # buffer.

    def finish
      run '', Zlib::FINISH

      detatch_output
    end

    ##
    # This method is equivalent to <tt>deflate('', flush)</tt>.  If flush is
    # omitted, <tt>Zlib::SYNC_FLUSH</tt> is used as flush.  This method is
    # just provided to improve the readability of your Ruby program.

    def flush(flush = Zlib::SYNC_FLUSH)
      run '', flush unless flush == Zlib::NO_FLUSH

      detatch_output
    end

    ##
    # Changes the parameters of the deflate stream. See zlib.h for details.
    # The output from the stream by changing the params is preserved in output
    # buffer.

    def params(level, strategy)
      err = Zlib.deflateParams pointer, level, strategy

      raise Zlib::BufError, 'buffer expansion not implemented' if
        err == Zlib::BUF_ERROR

      Zlib.handle_error err, message

      nil
    end

    ##
    # Sets the preset dictionary and returns +dictionary+. This method is
    # available just only after Zlib::Deflate.new or Zlib::ZStream#reset
    # method was called.  See zlib.h for details.

    def set_dictionary(dictionary)
      dict = StringValue dictionary

      err = Zlib.deflateSetDictionary pointer, dict, dict.length

      Zlib.handle_error err, message

      dictionary
    end

  end

  ##
  # Zlib::GzipFile is an abstract class for handling a gzip formatted
  # compressed file. The operations are defined in the subclasses,
  # Zlib::GzipReader for reading, and Zlib::GzipWriter for writing.
  #
  # GzipReader should be used by associating an IO, or IO-like, object.

  class GzipFile

    SYNC            = Zlib::ZStream::UNUSED
    HEADER_FINISHED = Zlib::ZStream::UNUSED << 1
    FOOTER_FINISHED = Zlib::ZStream::UNUSED << 2

    FLAG_MULTIPART    = 0x2
    FLAG_EXTRA        = 0x4
    FLAG_ORIG_NAME    = 0x8
    FLAG_COMMENT      = 0x10
    FLAG_ENCRYPT      = 0x20
    FLAG_UNKNOWN_MASK = 0xc0

    EXTRAFLAG_FAST    = 0x4
    EXTRAFLAG_SLOW    = 0x2

    MAGIC1         = 0x1f
    MAGIC2         = 0x8b
    METHOD_DEFLATE = 8

    ##
    # Base class of errors that occur when processing GZIP files.

    class Error < Zlib::Error; end

    ##
    # Raised when gzip file footer is not found. 

    class NoFooter < Error; end

    ##
    # Raised when the CRC checksum recorded in gzip file footer is not
    # equivalent to the CRC checksum of the actual uncompressed data. 

    class CRCError < Error; end

    ##
    # Raised when the data length recorded in the gzip file footer is not
    # equivalent to the length of the actual uncompressed data. 

    class LengthError < Error; end

    ##
    # Accessor for the underlying ZStream

    attr_reader :zstream # :nodoc:

    ##
    # See Zlib::GzipReader#wrap and Zlib::GzipWriter#wrap.

    def self.wrap(*args)
      obj = new(*args)

      if block_given? then
        begin
          yield obj
        ensure
          obj.close if obj.zstream.ready?
        end
      end
    end

    def initialize
      @comment = nil
      @crc = 0
      @level = nil
      @mtime = Time.at 0
      @orig_name = nil
      @os_code = Zlib::OS_CODE
    end

    ##
    # Closes the GzipFile object. This method calls close method of the
    # associated IO object. Returns the associated IO object.

    def close
      io = finish

      io.close if io.respond_to? :close

      io
    end

    ##
    # Same as IO

    def closed?
      @io.nil?
    end

    ##
    # Returns comments recorded in the gzip file header, or nil if the
    # comment is not present.

    def comment
      raise Error, 'closed gzip stream' if @io.nil?

      @comment.dup
    end

    def end
      return if @zstream.closing?

      @zstream.flags |= Zlib::ZStream::CLOSING

      begin
        end_run
      ensure
        @zstream.end
      end
    end

    ##
    # Closes the GzipFile object. Unlike Zlib::GzipFile#close, this method
    # never calls the close method of the associated IO object. Returns the
    # associated IO object.

    def finish
      self.end

      io = @io
      @io = nil
      @orig_name = nil
      @comment = nil

      io
    end

    def finished?
      @zstream.finished? and @zstream.output.empty? # HACK I think
    end

    def footer_finished?
      @zstream.flags & Zlib::GzipFile::FOOTER_FINISHED ==
        Zlib::GzipFile::FOOTER_FINISHED
    end

    def header_finished?
      @zstream.flags & Zlib::GzipFile::HEADER_FINISHED ==
        Zlib::GzipFile::HEADER_FINISHED
    end

    ##
    # Returns last modification time recorded in the gzip file header.

    def mtime
      Time.at @mtime
    end

    ##
    # Returns original filename recorded in the gzip file header, or +nil+ if
    # original filename is not present.

    def orig_name
      raise Error, 'closed gzip stream' if @io.nil?

      @orig_name.dup
    end

  end

  ##
  # Zlib::GzipReader is the class for reading a gzipped file.  GzipReader
  # should be used an IO, or -IO-lie, object.
  #
  #   Zlib::GzipReader.open('hoge.gz') {|gz|
  #     print gz.read
  #   }
  #   
  #   File.open('hoge.gz') do |f|
  #     gz = Zlib::GzipReader.new(f)
  #     print gz.read
  #     gz.close
  #   end
  #
  # == Method Catalogue
  #
  # The following methods in Zlib::GzipReader are just like their counterparts
  # in IO, but they raise Zlib::Error or Zlib::GzipFile::Error exception if an
  # error was found in the gzip file.
  #
  # - #each
  # - #each_line
  # - #each_byte
  # - #gets
  # - #getc
  # - #lineno
  # - #lineno=
  # - #read
  # - #readchar
  # - #readline
  # - #readlines
  # - #ungetc
  #
  # Be careful of the footer of the gzip file. A gzip file has the checksum of
  # pre-compressed data in its footer. GzipReader checks all uncompressed data
  # against that checksum at the following cases, and if it fails, raises
  # <tt>Zlib::GzipFile::NoFooter</tt>, <tt>Zlib::GzipFile::CRCError</tt>, or
  # <tt>Zlib::GzipFile::LengthError</tt> exception.
  #
  # - When an reading request is received beyond the end of file (the end of
  #   compressed data). That is, when Zlib::GzipReader#read,
  #   Zlib::GzipReader#gets, or some other methods for reading returns nil.
  # - When Zlib::GzipFile#close method is called after the object reaches the
  #   end of file.
  # - When Zlib::GzipReader#unused method is called after the object reaches
  #   the end of file.
  #
  # The rest of the methods are adequately described in their own
  # documentation.

  class GzipReader < GzipFile # HACK use a buffer class

    ##
    # Creates a GzipReader object associated with +io+. The GzipReader object
    # reads gzipped data from +io+, and parses/decompresses them.  At least,
    # +io+ must have a +read+ method that behaves same as the +read+ method in
    # IO class.
    #
    # If the gzip file header is incorrect, raises an Zlib::GzipFile::Error
    # exception.

    def initialize(io)
      @io = io

      @zstream = Zlib::Inflate.new -Zlib::MAX_WBITS

      @buffer = ''

      super()

      read_header
    end

    def check_footer
      @zstream.flags |= Zlib::GzipFile::FOOTER_FINISHED

      footer = @zstream.input.slice! 0, 8
      rest = @io.read 8 - footer.length
      footer << rest if rest

      raise NoFooter, 'footer is not found' unless footer.length == 8

      crc, length = footer.unpack 'VV'

      @zstream[:total_in] += 8 # to rewind correctly

      raise CRCError, 'invalid compressed data -- crc error' unless @crc == crc

      raise LengthError, 'invalid compressed data -- length error' unless
        length == @zstream.total_out
    end

    def end_run
      check_footer if @zstream.finished? and not footer_finished?
    end

    def eof?
      @zstream.finished? and @zstream.input_empty?
    end

    def pos
      @zstream[:total_out] - @buffer.length
    end

    ##
    # See Zlib::GzipReader documentation for a description.

    def read(length = nil)
      data = @buffer

      while chunk = @io.read(CHUNK) do
        inflated = @zstream.inflate(chunk)
        @crc = Zlib.crc32 inflated, @crc
        data << inflated

        break if length and data.length > length
      end

      if length then
        @buffer = data.slice! length..-1
      else
        @buffer = ''
      end

      check_footer if @zstream.finished? and not footer_finished?

      data
    rescue Zlib::Error => e
      raise GzipFile::Error, e.message
    end

    def read_header
      header = @io.read 10

      raise Error, 'not in gzip format' unless header.length == 10

      magic1, magic2, method, flags, @mtime, extra_flags, @os_code =
        header.unpack 'CCCCVCC'

      unless magic1 == Zlib::GzipFile::MAGIC1 and
             magic2 == Zlib::GzipFile::MAGIC2 then
        raise Error, 'not in gzip format'
      end

      unless method == Zlib::GzipFile::METHOD_DEFLATE then
        raise Error, "unsupported compression method #{method}"
      end

      if flags & Zlib::GzipFile::FLAG_MULTIPART ==
           Zlib::GzipFile::FLAG_MULTIPART then
        raise Error, 'multi-part gzip file is not supported'
      end

      if flags & Zlib::GzipFile::FLAG_ENCRYPT ==
           Zlib::GzipFile::FLAG_ENCRYPT then
        raise Error, 'encrypted gzip file is not supported'
      end

      if flags & Zlib::GzipFile::FLAG_UNKNOWN_MASK ==
           Zlib::GzipFile::FLAG_UNKNOWN_MASK then
        raise Error, "unknown flags 0x#{flags.to_s 16}"
      end

      if extra_flags & Zlib::GzipFile::EXTRAFLAG_FAST ==
           Zlib::GzipFile::EXTRAFLAG_FAST then
        @level = Zlib::BEST_SPEED
      elsif extra_flags & Zlib::GzipFile::EXTRAFLAG_SLOW ==
           Zlib::GzipFile::EXTRAFLAG_SLOW then
        @level = Zlib::BEST_COMPRESSION
      else
        @level = Zlib::DEFAULT_COMPRESSION
      end

      if flags & Zlib::GzipFile::FLAG_EXTRA == Zlib::GzipFile::FLAG_EXTRA then
        length = @io.read 2
        raise Zlib::GzipFile::Error, 'unexpected end of file' if
          length.nil? or length.length != 2

        length, = length.unpack 'v'

        extra = @io.read length + 2

        raise Zlib::GzipFile::Error, 'unexpected end of file' if
          extra.nil? or extra.length != length + 2
      end

      if flags & Zlib::GzipFile::FLAG_ORIG_NAME ==
           Zlib::GzipFile::FLAG_ORIG_NAME then
        @orig_name = ''

        c = @io.getc

        until c == 0 do
          @orig_name << c.chr
          c = @io.getc
        end
      end

      if flags & Zlib::GzipFile::FLAG_COMMENT ==
           Zlib::GzipFile::FLAG_COMMENT then
        @comment = ''

        c = @io.getc

        until c == 0 do
          @comment << c.chr
          c = @io.getc
        end
      end
    end

  end

  ##
  # Zlib::GzipWriter is a class for writing gzipped files.  GzipWriter should
  # be used with an instance of IO, or IO-like, object.
  #
  # For example:
  #
  #   Zlib::GzipWriter.open('hoge.gz') do |gz|
  #     gz.write 'jugemu jugemu gokou no surikire...'
  #   end
  #   
  #   File.open('hoge.gz', 'w') do |f|
  #     gz = Zlib::GzipWriter.new(f)
  #     gz.write 'jugemu jugemu gokou no surikire...'
  #     gz.close
  #   end
  #
  # NOTE: Due to the limitation of Ruby's finalizer, you must explicitly close
  # GzipWriter objects by Zlib::GzipWriter#close etc.  Otherwise, GzipWriter
  # will be not able to write the gzip footer and will generate a broken gzip
  # file.

  class GzipWriter < GzipFile # HACK use a buffer class

    ##
    # Set the comment

    attr_writer :comment

    ##
    # Set the original name

    attr_writer :orig_name

    ##
    # Creates a GzipWriter object associated with +io+. +level+ and +strategy+
    # should be the same as the arguments of Zlib::Deflate.new.  The
    # GzipWriter object writes gzipped data to +io+.  At least, +io+ must
    # respond to the +write+ method that behaves same as write method in IO
    # class.

    def initialize(io, level = Zlib::DEFAULT_COMPRESSION,
                   strategy = Zlib::DEFAULT_STRATEGY)
      @io = io

      @zstream = Zlib::Deflate.new level, -Zlib::MAX_WBITS,
                                   Zlib::DEF_MEM_LEVEL, strategy

      @buffer = ''

      super()
    end

    def end_run
      make_header unless header_finished?

      @zstream.run '', Zlib::FINISH

      write_raw

      make_footer

      nil
    end

    ##
    # Flushes all the internal buffers of the GzipWriter object.  The meaning
    # of +flush+ is same as in Zlib::Deflate#deflate.
    # <tt>Zlib::SYNC_FLUSH</tt> is used if +flush+ is omitted.  It is no use
    # giving flush <tt>Zlib::NO_FLUSH</tt>.

    def flush
      true
    end

    ##
    # Writes out a gzip header

    def make_header
      flags = 0
      extra_flags = 0

      flags |= Zlib::GzipFile::FLAG_ORIG_NAME if @orig_name
      flags |= Zlib::GzipFile::FLAG_COMMENT   if @comment

      extra_flags |= Zlib::GzipFile::EXTRAFLAG_FAST if
        @level == Zlib::BEST_SPEED

      extra_flags |= Zlib::GzipFile::EXTRAFLAG_SLOW if
        @level == Zlib::BEST_COMPRESSION

      header = [
        Zlib::GzipFile::MAGIC1,         # byte 0
        Zlib::GzipFile::MAGIC2,         # byte 1
        Zlib::GzipFile::METHOD_DEFLATE, # byte 2
        flags,                          # byte 3
        @mtime.to_i,                    # bytes 4-7
        extra_flags,                    # byte 8
        @os_code                        # byte 9
      ].pack 'CCCCVCC'

      @io.write header

      @io.write "#{@orig_name}\0" if @orig_name
      @io.write "#{@comment}\0" if @comment

      @zstream.flags |= Zlib::GzipFile::HEADER_FINISHED
    end

    ##
    # Writes out a gzip footer

    def make_footer
      footer = [
        @crc,              # bytes 0-3
        @zstream.total_in, # bytes 4-7
      ].pack 'VV'

      @io.write footer

      @zstream.flags |= Zlib::GzipFile::FOOTER_FINISHED
    end

    ##
    # Sets the modification time of this file

    def mtime=(time)
      if header_finished? then
        raise Zlib::GzipFile::Error, 'header is already written'
      end

      @mtime = Integer time
    end

    def sync?
      @zstream.flags & Zlib::GzipFile::SYNC == Zlib::GzipFile::SYNC
    end

    ##
    # Same as IO.

    def write(data)
      make_header unless header_finished?

      data = String data

      if data.length > 0 or sync? then
        @crc = Zlib.crc32_c @crc, data, data.length

        flush = sync? ? Zlib::SYNC_FLUSH : Zlib::NO_FLUSH

        @zstream.run data, flush
      end

      write_raw
    end

    ##
    # Same as IO.

    alias << write

    def write_raw
      data = @zstream.detatch_output

      unless data.empty? then
        @io.write data
        @io.flush if sync? and io.respond_to :flush
      end
    end

  end

  ##
  # Zlib:Inflate is the class for decompressing compressed data.  Unlike
  # Zlib::Deflate, an instance of this class is not able to duplicate (clone,
  # dup) itself.

  class Inflate < ZStream

    ##
    # Decompresses +string+. Raises a Zlib::NeedDict exception if a preset
    # dictionary is needed for decompression.
    #
    # This method is almost equivalent to the following code:
    #
    #   def inflate(string)
    #     zstream = Zlib::Inflate.new
    #     buf = zstream.inflate(string)
    #     zstream.finish
    #     zstream.close
    #     buf
    #   end

    def self.inflate(data)
      inflator = new

      unzipped = inflator.inflate data

      unzipped
    ensure
      inflator.end
    end

    ##
    # Creates a new inflate stream for decompression. See zlib.h for details
    # of the argument.  If +window_bits+ is +nil+, the default value is used.

    def initialize(window_bits = Zlib::MAX_WBITS)
      super()

      @func_end = :inflateEnd
      @func_reset = :inflateReset
      @func_run = :inflate

      err = Zlib.inflateInit2 pointer, window_bits

      Zlib.handle_error err, message # HACK

      ready
    end

    ##
    # Inputs +string+ into the inflate stream just like Zlib::Inflate#inflate,
    # but returns the Zlib::Inflate object itself.  The output from the stream
    # is preserved in output buffer.

    def <<(string)
      string = StringValue string unless string.nil?

      if finished? then
        unless string.nil? then
          @input ||= ''
          @input << string
        end
      else
        run string, Zlib::SYNC_FLUSH
      end
    end

    ##
    # Inputs +string+ into the inflate stream and returns the output from the
    # stream.  Calling this method, both the input and the output buffer of
    # the stream are flushed.  If string is +nil+, this method finishes the
    # stream, just like Zlib::ZStream#finish.
    #
    # Raises a Zlib::NeedDict exception if a preset dictionary is needed to
    # decompress.  Set the dictionary by Zlib::Inflate#set_dictionary and then
    # call this method again with an empty string.  (<i>???</i>)

    def inflate(data)
      data = Type.coerce_to data, String, :to_str unless data.nil?

      if finished? then
        if data.nil? then
          unzipped = detatch_output
        else
          @input ||= ''
          @input << data

          unzipped = ''
        end
      else
        if data.nil? then
          run '', Zlib::FINISH
        elsif not data.empty? then
          run data, Zlib::SYNC_FLUSH
        end

        unzipped = detatch_output

        if finished? and not @input.nil? then
          expand_output
        end
      end

      unzipped
    end

    ##
    # Sets the preset dictionary and returns +string+.  This method is
    # available just only after a Zlib::NeedDict exception was raised.  See
    # zlib.h for details.

    def set_dictionary(dictionary)
      dict = StringValue dictionary

      err = Zlib.inflateSetDictionary pointer, dict, dict.length

      Zlib.handle_error err, message

      dictionary
    end

  end

  ##
  # Calculates Alder-32 checksum for +string+, and returns updated value of
  # +adler+. If +string+ is omitted, it returns the Adler-32 initial value. If
  # +adler+ is omitted, it assumes that the initial value is given to +adler+.

  def self.adler32(string = "", sum = 1)
    do_checksum(string, sum, :adler32_c)
  end

  ##
  # Returns the table for calculating CRC checksum as an array.

  def self.crc_table
    get_crc_table_c.read_array_of_long(256).map do |x|
      x >= 0 ? x : 2 ** 32 + x # HACK convert back to unsigned
    end
  end

  ##
  # Calculates CRC checksum for +string+, and returns updated value of +crc+.
  # If +string+ is omitted, it returns the CRC initial value. If +crc+ is
  # omitted, it assumes that the initial value is given to +crc+.

  def self.crc32(string = "", sum = 0)
    do_checksum(string, sum, :crc32_c)
  end

  ##
  # Generates a checksum using function +type+

  def self.do_checksum(string, vsum, type)
    if vsum
      raise RangeError if vsum >= (2 ** 128)
      raise "Explain why you did this: email ephoenix@engineyard.com" if vsum < 0
      sum = vsum
    elsif string.nil?
      sum = 0
    else
      sum = send(type, 0, nil, 0)
    end

    send(type, sum, string, string ? string.size : 0)
  end

  ##
  # Raises an exception of the appropriate class

  def self.handle_error(error, message = nil)
    return if error == Zlib::OK

    message = zError error if message.nil?

    klass = case error
            when Zlib::STREAM_END   then Zlib::StreamEnd
            when Zlib::NEED_DICT    then Zlib::NeedDict
            when Zlib::STREAM_ERROR then Zlib::StreamError
            when Zlib::DATA_ERROR   then Zlib::DataError
            when Zlib::BUF_ERROR    then Zlib::BufError
            when Zlib::MEM_ERROR    then Zlib::MemError
            when Errno then Errno.handle message
            else
              message = "unknown zlib error #{error}: #{message}"
              Zlib::Error
            end

    raise klass, message
  end

end

