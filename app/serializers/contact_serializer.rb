class ContactSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :birthdate

  belongs_to :kind do
    link(:related) { contact_kind_url(object.id) }
  end
  has_many :phones do
    link(:related) { contact_kind_url(object.id) }
  end

  has_one :address

  link(:self) { contact_url(object.id) }
  meta do
    { author: 'D. Pozzolo' }
  end

  def attributes(*args)
    h = super(*args)
    # h[:birthdate] = (I18n.l(object.birthdate) unless object.birthdate.blank?) #pt-BR
    h[:birthdate] =   object.birthdate.to_time.iso8601 unless object.birthdate.blank?
    h
  end
end
