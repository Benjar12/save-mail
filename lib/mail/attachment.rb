require_relative '../fs_util/fs'
include FSUtil

class Attachment
  @@filename
  @@payload
  @@is_body

  @@file_path

  def initialize(filename, payload, is_body)
    @@filename = filename
    @@payload = payload
    @@is_body = is_body

    @@file_path = ""
  end

  # TODO raise an exception if the write method has not been called first
  def file_path
    @@file_path
  end

  def set_file_path(file_path)
    @@file_path = file_path
  end

  def is_body
    @@is_body
  end

  def write(email_address)
    path = FSUtil.create_and_write(email_address, @@filename, @@payload, false)
    self.set_file_path(path)
  end
end
