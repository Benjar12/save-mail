require 'mail'
require_relative './message'
require_relative './attachment'

module MailParser
  def parse_and_add_part(message, part)
    content_type = part.content_type
    # If it includes content-type multipart/alternative text/plain or text/html
    # we treat it as the email body, otherwise we treat it as an attachment.
    if content_type.include? 'multipart/alternative' ||
      content_type.include? 'text/'
      payload = m.parts[0].body
      file_name = message.id + ".txt"
      is_body = true
    else
      payload = part.decoded
      file_name = part.filename
      is_body = false
    end

    message.add_attachment(Attachment.new(file_name, payload, is_body))
  end

  def get_message_from_string(raw_email)
    # TODO we should add error handling around this in case from is empty or something
    # First we will parse the email and create a new Message.
    m = Mail.read_from_string(raw_email)
    message = Message.new(m.from[0])

    # TODO we might need to add handling for non multipart emails.
    # Next we will iterate of all of the parts in the email and append to the
    # message.
    m.parts.each {|part| parse_and_add_part(message, part)}

    # After that we can return the instance of the message object
    message
  end
end
