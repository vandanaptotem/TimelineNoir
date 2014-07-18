class ImageLibrariesController < ApplicationController
  before_action :set_image_library, only: [:show, :edit, :update, :destroy]

  # GET /image_libraries
  # GET /image_libraries.json
  def index
    @image_libraries = ImageLibrary.all
  end

  # GET /image_libraries/1
  # GET /image_libraries/1.json
  def show
  end

  # GET /image_libraries/new
  def new
    @image_library = ImageLibrary.new
  end

  # GET /image_libraries/1/edit
  def edit
  end

  # POST /image_libraries
  # POST /image_libraries.json
  def create
    @image_library = ImageLibrary.new(image_library_params)

    respond_to do |format|
      if @image_library.save
        format.html { redirect_to @image_library, notice: 'Image library was successfully created.' }
        format.json { render :show, status: :created, location: @image_library }
      else
        format.html { render :new }
        format.json { render json: @image_library.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /image_libraries/1
  # PATCH/PUT /image_libraries/1.json
  def update
    respond_to do |format|
      if @image_library.update(image_library_params)
        format.html { redirect_to @image_library, notice: 'Image library was successfully updated.' }
        format.json { render :show, status: :ok, location: @image_library }
      else
        format.html { render :edit }
        format.json { render json: @image_library.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /image_libraries/1
  # DELETE /image_libraries/1.json
  def destroy
    @image_library.destroy
    respond_to do |format|
      format.html { redirect_to image_libraries_url, notice: 'Image library was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def create_css
    @elements = params[:elements]
    a = ""
    @elements.each do |i,v|
      a=a+v["id"]+"{
        position : absolute;
        height : #{v["height"]};
        width : #{v["width"]};
        top : #{v["top"]};
        left : #{v["left"]};
      }\n"
    end

    directory = "#{Rails.root}/public/"
    File.open(File.join(directory, 'file.css'), 'w') do |f|
      f.puts a
    end

    @filename = "#{Rails.root}/public/file.css"

    @il = ImageLibrary.find(params[:id][0])
    @il.file = File.open(@filename)
    @il.save
    File.delete(@filename) if File.exist?(@filename)
    render :text => "Done"
    return

  end

  def download_css
    @image_library = ImageLibrary.find(params[:id])
    send_file(@image_library.file.path, :filename => "file.css")
    # redirect_to @image_library
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image_library
      @image_library = ImageLibrary.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_library_params
      params.require(:image_library).permit(:image)
    end
end
