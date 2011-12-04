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
      row[:coords] = geo.getcoords(row[@dataset.state_column_name])
      @dataset.content << row
    end

    @dataset.processing = "f"
    @dataset.save!
  end
end
