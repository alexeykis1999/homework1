class ArticlesController < ApplicationController
	#around_action :testing
	rescue_from ActionController::RoutingError, with: :record_not_found
	
	def testing
		puts "----------------------------------"
		puts "asd"
		puts "----------------------------------"
		@articles = Article.all
		@articles.each do |article|
			puts "#{article.id}-st article is #{article.title}"
		end
		yield
	end

  def index
    @articles = Article.all
  end

  def show
  	@article = Article.find(params[:id])
  	respond_to do |format|
			format.html # show.html.erb
			#format.xml { render :xml => @article.to_xml }
		end
		flash.now[:message] = "Hello current action"
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to root_url, notice: "You have successfully logged out."
  end

  private
    def article_params
      params.require(:article).permit(:title, :body)
    end

    def record_not_found
      render plain: "404 Not Found", status: 404
    end
end

