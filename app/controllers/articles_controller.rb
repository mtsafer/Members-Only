class ArticlesController < ApplicationController

	before_action :login_filter, only: [:new, :create]

	def index
		@articles = Article.all
	end

	def new
		@article = Article.new
	end

	def create
		@article = current_user.articles.new article_params
		if @article.save
			flash[:success] = "An excellent new piece of literature!"
			redirect_to @article
		else
			render :new
		end
	end

	def show
		@article = Article.find_by_id(params[:id])
	end

	private

		def article_params
			params.require(:article).permit(:title, :body, :user_id)
		end

		def login_filter
			user = current_user
			unless(user && user.authenticated?(user.remember_token))
				flash[:warning] = "You need to login to do that!"
				redirect_to root_path
			end
		end

end
