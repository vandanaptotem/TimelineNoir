json.array!(@image_libraries) do |image_library|
  json.extract! image_library, :id, :image
  json.url image_library_url(image_library, format: :json)
end
