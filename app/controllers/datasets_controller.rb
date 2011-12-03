class DatasetsController < ApplicationController

  def create
    params[:dataset][:processing] = "t"
    @dataset = Dataset.create(params[:dataset])
    @uploaded_file = UploadedFile.find(params[:uploaded_file_id])
    Delayed::Job.enqueue(DatasetJob.new(@dataset.id, @uploaded_file.id))
    redirect_to @dataset, :notice => "Ya se creo el dataset"
  end

  def show
    @dataset = Dataset.find(params[:id])
  end
end
