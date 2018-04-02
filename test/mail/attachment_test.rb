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
    tests = [
      {
        "name" => "should be in the content dir",
        "match" => "/content/",
        "should_be" => true
      },
      {
        "name" => "should not be in the meta dir",
        "match" => "/meta/",
        "should_be" => false
      }
    ]

    tests.each { |t|
      a = Attachment.new("sometextfile.txt", "blablabla", false)
      result_path = a.write("ben@example.com")
      assert result_path.include? '283c17ae3eae66fca8cdd3a5cd16ff78e0bb150b'
      assert (result_path.include? t["match"]) == t["should_be"]
    }
  end

  def test_sets_and_gets_file_path
    a = Attachment.new("sometextfile.txt", "blablabla", false)
    a.set_file_path("foo")
    assert a.file_path == "foo"
  end

  def test_sets_is_body_correctly
    tests = [
      {
        "name" => "should be true",
        "is_body" => true
      },
      {
        "name" => "should be false",
        "is_body" => false
      }
    ]

    tests.each { |t|
      a = Attachment.new("sometextfile.txt", "blablabla", t["is_body"])
      a.write("foo@bar.com")
      assert a.is_body == t["is_body"]
    }
  end
end
