require 'minitest/autorun'
require 'fakefs'
include FakeFS
require_relative '../../lib/mail/attachment'

class AttachmentTest < Minitest::Test
  def setup
    FakeFS.activate!
    FileSystem.clear
  end

  def teardown
    FakeFS.deactivate!
  end

  def test_attachment_writes_to_file
    puts 'in the test case'
    a = Attachment.new("sometextfile.txt", "blablabla", false)
    result_path = a.write("ben@example.com")
    puts result_path
  end
end
