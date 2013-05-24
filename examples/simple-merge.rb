#!/usr/bin/env ruby

require 'reru'

source_files = [
  'somefile.h',
  'somefile.m',
  'otherfile.h',
  'otherfile.m'
].as_stream

header_files = source_files.select{ |value| value.end_with?('.h') }.map{ |value| "HEADER: #{value}" }
impl_files = source_files.select{ |value| value.end_with?('.m') }.map{ |value| "IMPL:   #{value}" }
all_files = header_files.merge(impl_files)
all_files.log

source_files.flush
