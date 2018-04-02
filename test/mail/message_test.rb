require 'minitest/autorun'
require 'fakefs'
include FakeFS
require_relative '../../lib/mail/message'

# TODO add better code coverage
class MessageTest < Minitest::Test
  def setup
    FakeFS.activate!
    FileSystem.clear
  end

  def teardown
    FakeFS.deactivate!
  end

  def test_writes_json_meta_data
    m = Message.new("ben@foo.com")
    m.write()
  end
end
