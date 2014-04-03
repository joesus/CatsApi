module API

  class CatsController < ApplicationController
    before_action :set_cat, only: [:show, :edit, :update, :destroy]

    # GET /cats
    # GET /cats.json
    def index
      @cats = Cat.all

      respond_to do |format|
        format.json
        format.xml { render xml: @cats, status: 200 }
      end
    end

    # GET /cats/1.json
    def show
      @cat = Cat.order(age: :desc).first
      render json: @cat
    end

    # GET /cats/new
    def new
      @cat = Cat.new
    end

    # GET /cats/1/edit
    def edit
    end

    # POST /cats
    # POST /cats.json
    def create
      @cat = Cat.new(cat_params)

      if @cat.save
        # Can use :created instead of 201
        render json: @cat, status: 201, location: "/cats/#{@cat[:id]}"
      else
        # Can use :unprocessable_entity instead of 422
        render json: @cat.errors, status: 422
      end
    end

    # PATCH/PUT /cats/1
    # PATCH/PUT /cats/1.json
    def update
      cat = Cat.find(params[:id])
      if cat.update(cat_params)
        render json: cat, status: 200
      else
        render json: cat, status: 422
      end
    end

    # DELETE /cats/1
    # DELETE /cats/1.json
    def destroy
      @cat.destroy
      head 204
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_cat
        @cat = Cat.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def cat_params
        params.require(:cat).permit(:name, :breed, :age)
      end
  end
end