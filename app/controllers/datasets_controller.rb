class DatasetsController < ApplicationController

  def create
    params[:dataset][:processing] = "t"
    @dataset = Dataset.create(params[:dataset])
    @uploaded_file = UploadedFile.find(params[:uploaded_file_id])
    Delayed::Job.enqueue(DatasetJob.new(@dataset.id, @uploaded_file.id))
    respond_to { |format| format.js }
  end

  def add
    Dataset.find(params['id']).add(params['matcher-1'],params['matcher-2'], params['name'])
    redirect_to '/map'
  end
end
