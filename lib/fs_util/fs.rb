require 'fileutils'
require 'digest/sha1'

module FSUtil
  def gen_path(email, is_meta_data)
    base_path = ENV['RUBY_BASE_PATH'] || '/tmp'
    base_path = !is_meta_data ? base_path + '/content' : base_path + '/meta'
    current_day = Time.now.strftime('%Y/%m/%d/')
    base_path + '/' + current_day + Digest::SHA1.hexdigest(email)[0, 4]
  end

  def create_dir_if_does_not_exist(dir)
    FileUtils.mkdir_p(dir) unless File.exists?(dir)
  end

  def gen_file_path(path, file)
    extension = filename.split(".").last
    file_hash = Digest::SHA1.hexdigest(path)
    path + '/' + file_hash + '.' + extension
  end

  def write(filepath, payload)
    File.open(filepath, 'w') { |file| file.write(payload) }
  end

  # Pretty much the only method that is going to be called outside of this module
  # Returns the path it wrote to.
  def create_and_write(email_address, filename, payload, is_meta_data = false)
    dir = self.gen_path(email_address, is_meta_data)
    ext = filename.split(".").last
    hashed_filename = Digest::SHA1.hexdigest(filename)
    absolute_path = dir + '/' + hashed_filename + '.' + ext

    self.create_dir_if_does_not_exist(dir)
    write(absolute_path, payload)

    absolute_path
  end
end
