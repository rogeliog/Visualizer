class DatasetJob
  
  def initialize(dataset_id, uploaded_file_id)
    @dataset_id = dataset_id
    @uploaded_file_id = uploaded_file_id
  end

  def perform
    @dataset = Dataset.find(@dataset_id)
    @uploaded_file = UploadedFile.find(@uploaded_file_id)
    geo = Geoutils::Utils.new

    @dataset.content = []
    @uploaded_file.content.each do |row|
      name = row.delete(@dataset.state_column_name)
      lat, lng = geo.getcoords(name)
      data = {
        :id => name,
        :type => 'Feature',
        :geometry => {:type => 'Point', :coordinates => [lat, lng]},
        :properties => row
      }

      @dataset.content << data
    end

    @dataset.column_names = @uploaded_file.column_names
    @dataset.column_names.delete(@dataset.state_column_name)
    @dataset.processing = "f"
    @dataset.save!
  end
end
