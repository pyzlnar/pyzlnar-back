# Seeds the application
seeds = Dir[Rails.root.join(*%w[db seeds ** *])]

seeds.each do |seed|
  parsed_yaml = YAML.load_file(seed)
  model, attributes = parsed_yaml.first

  begin
    model = model.camelize.singularize.constantize
  rescue
    puts "No '#{model.camelize}' class found"
  end

  begin
    model.create!(attributes)
  rescue ActiveRecord::RecordInvalid => e
    puts "Could not create #{model}"
    puts e.message
  end
end
