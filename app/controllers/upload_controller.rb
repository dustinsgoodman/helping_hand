class UploadController < ApplicationController
  def uploadFile
    post = DataFile.save(params[:upload])
    render :text => "File has been uploaded successfully"
  end
end
