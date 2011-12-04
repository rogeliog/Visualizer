# encoding: utf-8
require 'csv'

class UploadedFilesController < ApplicationController

  def new
  end

  def create
    @uploaded_file = save_file(params[:file])
    @dataset = Dataset.new
    respond_to { |format| format.js }
  end


  def show
    @uploaded_file = UploadedFile.find(params[:id])
    @dataset = Dataset.new
  end


  def save_file(file)
    data = CSV.read(file.path)

    # get column names
    column_names = data.shift

    # get all rows
    content = []

    data.each do |row|
      new_row = {}

      column_names.each_with_index { |name, idx| new_row[name] = row[idx] }

      content << new_row
    end

    UploadedFile.create(:column_names => column_names, :content => content)
  end

end
