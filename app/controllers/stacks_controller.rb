class StacksController < ApplicationController

	def index
		@user_stacks=Stack.where(user_id: current_user.id)
		@fave_stacks=StackBookmark.where(user_id:current_user.id)
	end

	def show
		puts "hellooooo"
		puts params.inspect
		# @chronicles=Chronicle.all
		@stack=Stack.find(params[:id])
		@chronicles=@stack.chronicles
		@contributors=StackContributor.where(stack_id:params[:id])
		@categories=StackCategory.where(stack_id:@stack.id)
	end

	def new
		@stack=Stack.new
		@users=User.all
		@categories=Category.all
	end

	def create
		puts "creating stack"
		puts params.inspect
		@stack=Stack.new(stack_params)


		# if the category doesn't already exist, create it
		if Stack.exists?(stack_name: params[:stack][:stack_name], user_id: params[:stack][:user_id])
			puts "this exists"
		else
			puts "create"
			@stack.save!

			add_stack_contributors #add the contributors in the database

			# add categories and stackcategories
			add_stack_categories

			redirect_to stack_path(@stack.id)
		end

	end

	def edit
		@stack=Stack.find(params[:id])
		@users=User.all
		@stack_contributors=StackContributor.where(stack_id:params[:id])
		@categories=Category.all
		@stack_categories=StackCategory.where(stack_id:params[:id])
	end

	def update
		puts "in update"
		@stack=Stack.find(params[:id])

		# update the stack contributors in the database
		update_stack_contributors

		#update the categories
		update_stack_categories

		# save the updates
		@stack.update(stack_params)
		redirect_to stack_path(@stack.id)
	end

	def destroy
		puts "in destroy stack"
		@stack=Stack.find(params[:id])
		# ensure that all associated records are deleted
		@stack_bookmarks=StackBookmark.where(stack_id:params[:id])
		@stack_categories=StackCategory.where(stack_id:params[:id])
		@stack_chronicles=StackChronicle.where(stack_id:params[:id])
		@stack_contributors=StackContributor.where(stack_id:params[:id])

		@stack_bookmarks.destroy_all
		@stack_categories.destroy_all
		@stack_chronicles.destroy_all
		@stack_contributors.destroy_all
		@stack.destroy

		redirect_to user_path(current_user.id)
	end
	# strong parameters
	private
	def stack_params
		params.require(:stack).permit(:stack_name, :user_id)
	end

end
