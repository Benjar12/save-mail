require 'minitest/autorun'
require 'fakefs'
include FakeFS
require_relative '../../lib/mail/attachment'

# TODO add better code coverage
class AttachmentTest < Minitest::Test
  def setup
    FakeFS.activate!
    FileSystem.clear
  end

  def teardown
    FakeFS.deactivate!
  end

  def test_attachment_writes_to_file
    a = Attachment.new("sometextfile.txt", "blablabla", false)
    result_path = a.write("ben@example.com")
    assert result_path.include? '283c17ae3eae66fca8cdd3a5cd16ff78e0bb150b'
    assert result_path.include? '/content/'
  end
end
