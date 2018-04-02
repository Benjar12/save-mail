require 'securerandom'
require 'json'

require_relative '../fs_util/fs'
include FSUtil

class Message
  @@id
  @@from
  @@attachments
  @@recieved_at_epoch

 def initialize(from)
   @@id = SecureRandom.uuid
   @@from = from
   @@attachments = Array.new
   @@recieved_at_epoch = Time.now.to_i
 end

 def add_attachment(attachment)
   @@attachments.insert(attachment)
 end

 # This method will be called first. it writes out all of the attachments. In
 # this process it will also set file_path on the attachment. We will then store
 # that info in the meta data file.
 def write_attachments
   @@attachments.each {|part| part.write()}
 end

 # TODO there is probobly a better way to be serializing json
 # Write_meta_data will be called after write attachments. We need to know where
 # the attachments are on disk.
 def write_meta_data
   # This creates an array of maps
   attachments = @@attachments.map { |a| {
       "file_path" => a.get_file_path(),
       "is_body" => a.get_is_body()
     }
   }

   meta_data = {
     "id" => @@id,
     "from" => @@from,
     "attachment_count" => attachments.length,
     "attachments" => attachments,
     "recieved_at_epoch" => @@recieved_at_epoch
   }

   json = meta_data.to_json
   file_name = @@id + '.json'

   path = FSUtil.create_and_write(email_address, file_name, meta_data, true)
 end

 # This is pretty much the only method i'll be accessing externally
 def write
   self.write_attachments
   self.write_meta_data
 end
end
