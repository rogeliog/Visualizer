# encoding: utf-8
require 'csv'
require 'iconv'

class UploadedFilesController < ApplicationController

  def new
  end

  def create
    begin
      @uploaded_file = save_file(params[:file])
    rescue
      @uploaded_file = nil
    end
    @dataset = Dataset.new
    respond_to do |format| 
      format.js 
      format.html
    end
  end


  def show
    @uploaded_file = UploadedFile.find(params[:id])
    @dataset = Dataset.new
  end


  def save_file(file)
    i = Iconv.new("UTF-8","LATIN1")
    # data = CSV.parse(i.icon(file.read))
    begin
      data = CSV.parse(File.open(file.path, "r:ISO-8859-1"))
    rescue
      data = CSV.parse(i.iconv File.open(file.path, "r:ISO-8859-1").read)
    end
    # CSV.parse(File.open(file.path, "r:UTF-8")) 
    # get column names
    column_names = data.shift

    # get all rows
    content = []

    data.each do |row|
      new_row = {}

      column_names.each_with_index { |name, idx| new_row[name] = row[idx] }

      content << new_row
    end

    pf = UploadedFile.create(:column_names => column_names, :content => content)
  end
end
