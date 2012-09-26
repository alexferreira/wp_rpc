module WpRpc
  module Collection
    class Attachments < Base
      def new(attributes)
        WpRpc::Attachment.new(attributes, :conn => conn)
      end
    end 
  end
end