require 'securerandom'

class Message
 def initialize(from)
   @id = SecureRandom.uuid
   @from = from
   @attachments = Array.new
 end

 def add_attachment(attachment)
   self.attachments.insert(attachment)
 end

 # This method will be called first. it writes out all of the attachments. In
 # this process it will also set file_path on the attachment. We will then store
 # that info in the meta data file.
 def write_attachments
   m.parts.each {|part| part.write()}
 end

 # Write_meta_data will be called after write attachments. We need to know where
 # the attachments are on disk.
 def write_meta_data
   #TODO Implement
 end
end
