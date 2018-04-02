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
    FSUtil.write("./test2.txt", "foo,bar")
    assert File.file?("./test2.txt")
  end

  def test_gens_correct_paths
    tc = [['content', false], ['meta', true]]

    tc.each {|t|
      folder_part = t[0]
      is_meta = t[1]

      r = FSUtil.gen_path('foo@bar.com', is_meta)
      current_day = Time.now.strftime('%Y/%m/%d/')
      assert r == '/tmp/' + folder_part + '/' + current_day + '8237'
    }
  end

  def test_create_dir_if_does_not_exist
    FSUtil.create_dir_if_does_not_exist('/tmp/batman')
    assert File.exists?('/tmp/batman')
  end
end
