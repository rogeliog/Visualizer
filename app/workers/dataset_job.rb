class DatasetJob
  
  def initialize(dataset_id, uploaded_file_id)
    @dataset_id = dataset_id
    @uploaded_file_id = uploaded_file_id
  end

  def perform
    @dataset = Dataset.find(@dataset_id)
    @uploaded_file = UploadedFile.find(@uploaded_file_id)
    @dataset.content = @uploaded_file.content
    @dataset.processing = "f"
    #raise @dataset.inspect
    @dataset.save!
  end
end
