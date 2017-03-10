# Validates attributes saved as a psql array
#
# At the moment it's a bit barebones because of its simplicity, but if needed I can just add more
# complex logic to it.
class ArrayValidator < ActiveModel::EachValidator
  def validate_each(*args)
    validate_array(*args)
    validate_may_include(*args)
  end

  private

  # Validates that value is an array
  def validate_array(_record, attribute, value)
    errors.add(attribute, 'not an array.') unless value.is_a? Array
  end

  # Validates that value only contains values defined with the option :may_include
  def validate_may_include(_record, attribute, value)
    return unless options[:may_include]
    surplus = value - options[:may_include]
    errors.add(attribute, "has invalid values: #{surplus}") if surplus.any?
  end
end
