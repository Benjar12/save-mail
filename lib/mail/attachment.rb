require_relative '../fs_util/fs'
include FSUtil

class Attachment
  @@filename
  @@payload
  @@is_body

  def initialize(filename, payload, is_body)
    @@filename = filename
    @@payload = payload
    @@is_body = is_body
  end

  def set_path(file_path)
    @@file_path = file_path
  end

  def write(email_address)
    path = FSUtil.create_and_write(email_address, @@filename, @@payload, false)
    self.set_path(path)
  end
end
