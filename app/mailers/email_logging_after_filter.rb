module EmailLoggingAfterFilter
  def self.included mailer
    mailer.class_eval do
      after_action :log_email

      private

      def log_email
        Ema::SentEmail.create(log_email_hash)
        Rails.logger.info("sent email: #{log_email_hash.to_json}") if email_was_sent?
      end

      def email_was_sent?
        to_email.present?
      end

      def to_email
        Array(headers.to).first
      end

      def log_email_hash
        {
          mailer: self.class.name,
          action: action_name,
          mailer_action: "#{self.class.name}##{action_name}",
          to: to_email,
          from: Array(headers.from).first,
          subject: headers.subject
        }
      end
    end
  end
end
