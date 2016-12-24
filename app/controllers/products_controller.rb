class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!, only: [:new, :edit, :update, :destroy]

    
  # GET /products
  # GET /products.json
  def index
	  
	#@products = Product.all
	  
	# replace default function by a search
	@products = search 
	  
  end
	
  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    def authenticate_admin!
        unless current_user.try(:admin?)
            redirect_to  root_path, alert:"You are not an administrator."
        end
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :price, :description, :category_id, :animal_id, :image)
    end
	
	# if no parameter entered, then it will return the whole table (same as above commented code : Product.all)
    def search
	  
	  
	  # get the parameters from URL 
      # products/?keywords=food&min_price=2
      # filter the output to avoid SQL injection
      @safe_keywords = params[:keywords].gsub(/[^0-9a-z\ ]/i, '') if params[:keywords].present?  
      @safe_category_id = params[:category_id].to_i if params[:category_id].present?  
      @safe_animal_id = params[:animal_id].to_i if params[:animal_id].present?  
      @safe_min_price = params[:min_price].to_i if params[:min_price].present?
      @safe_max_price = params[:max_price].to_i if params[:max_price].present?
	  @safe_sort_by = 0;
	  @safe_sort_by = params[:sort_by].to_i if params[:sort_by].present?

	  # generate the SQL search
	  if @safe_sort_by == 3 # sort by price (highest to lowest)
      	products = Product.order(:price).reverse_order
	  elsif @safe_sort_by == 2 # sort by price (lowest to hightest)
      	products = Product.order(:price)
	  elsif @safe_sort_by == 1 # sort by keywords (Z to A)
      	products = Product.order(:name).reverse_order
	  else # otherwise & default 0. sort by keywords (A to Z)
      	products = Product.order(:name)
	  end
	  
	  products = products.where("name like ? OR description like ?",
		  						"%#{@safe_keywords}%",
		  						"%#{@safe_keywords}%") if @safe_keywords.present?
      products = products.where(category_id: @safe_category_id) if @safe_category_id.present?
      products = products.where(animal_id: @safe_animal_id) if @safe_animal_id.present?
      products = products.where("price >= ?", @safe_min_price) if @safe_min_price.present?
      products = products.where("price <= ?", @safe_max_price) if @safe_max_price.present?

      # return the result
      products
    end

end
