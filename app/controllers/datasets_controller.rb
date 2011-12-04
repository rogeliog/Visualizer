class DatasetsController < ApplicationController

  def create
    params[:dataset][:processing] = "t"
    @dataset = Dataset.create(params[:dataset])
    @uploaded_file = UploadedFile.find(params[:uploaded_file_id])
    Delayed::Job.enqueue(DatasetJob.new(@dataset.id, @uploaded_file.id))
    respond_to { |format| format.js }
  end

  def show
    @dataset = Dataset.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render :json => @dataset }
    end
  end

  def add
    Dataset.find(params['id']).add(params['matcher-1'],params['matcher-2'], params['name'])
    redirect_to '/map'
  end


  def processing_status
    render :json => { :processing => Dataset.find(params[:id]).processing }
  end
end
