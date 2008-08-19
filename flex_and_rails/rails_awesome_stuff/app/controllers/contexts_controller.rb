class ContextsController < ApplicationController
  
  # return all Contexts
  def find_all
    respond_to do |format|
      format.amf  { render :amf => Context.find(:all) }
    end
  end

  def load_tree
    @root = Context.first :conditions => ['parent_id is null']
    respond_to do |format|
      format.amf { render :amf => @root }
    end
  end
  
  # return a single Context by id
  # expects id in params[0]
  def find_by_id
    respond_to do |format|
      format.amf { render :amf => Context.find(params[:id]) }
    end
  end

  # saves new or updates existing Context
  # expect params[0] to be incoming Context
  def save
    respond_to do |format|
      format.amf do
        @context = params[:context]

        if @context.save
          render :amf => @context
        else
          render :amf => FaultObject.new(@context.errors.full_messages.join('\n'))
        end
      end
    end
  end

  # destroy a Context
  # expects id in params[0]
  def destroy
    respond_to do |format|
      format.amf do
        @context = Context.find(params[:id])
        @context.destroy

        render :amf => true
      end
    end
  end

end
