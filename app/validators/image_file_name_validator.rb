# class ImageFileNameValidator < ActiveModel::EachValidator
#   def validate_each(record, attribute, value)
#     supported_extensions = options.fetch(:supported_extensions, %w{.jpg .png .jpeg})
#     if value.present? && !supported_extensions.include?(File.extname(value.downcase))
#       record.errors.add(:file_name, :invalid_extension, valid_extensions: supported_extensions)
#     end
#   end
# end