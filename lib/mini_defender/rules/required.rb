# frozen_string_literal: true

require 'action_dispatch'

class MiniDefender::Rules::Required < MiniDefender::Rule
  def self.signature
    'required'
  end

  def implicit?(validator)
    true
  end

  def passes?(attribute, value, validator)
    p value
    case value
    when nil
      false
    when String
      value.strip.length > 0
    when Enumerable
      value.length > 0
    when ActionDispatch::Http::UploadedFile
      value.path && value.path.length > 0 && value.size > 0
    else
      true
    end
  end

  def message(attribute, value, validator)
    I18n.t('mini_defender.required', field: attribute.humanize)
  end
end
