class Sugerencia < MailForm::Base
  attribute :iglesia,      :validate => true
  attribute :sugerencia,   :validate => true
  attribute :mensaje

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      :subject => "Sugerencia #{sugerencia}",
      :to => "ac@clmdevelopers.com",
      :from => %("#{iglesia}" <contacto@clmdevelopers.com>)
    }
  end
end