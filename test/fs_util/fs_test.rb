require 'minitest/autorun'
require 'fakefs'
include FakeFS
require_relative '../../lib/fs_util/fs'
include FSUtil

class FSUtilTest < Minitest::Test
  def setup
    FakeFS.activate!
    FileSystem.clear
  end

  def teardown
    FakeFS.deactivate!
  end

  def test_wrties_to_file
    FSUtil.write("/test.txt", "foo,bar")
    assert File.file?("/test.txt")
  end

  def test_gens_correct_path
    r = FSUtil.gen_path('foo@bar.com')
    current_day = Time.now.strftime('%Y/%m/%d/')
    assert r == '/tmp/' + current_day + '8237'
  end

  def test_create_dir_if_does_not_exist
    FSUtil.create_dir_if_does_not_exist('/tmp/batman')
    assert File.exists?('/tmp/batman')
  end
end
