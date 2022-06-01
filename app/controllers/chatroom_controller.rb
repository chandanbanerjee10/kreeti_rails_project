class ChatroomController < ApplicationController
    before_action :require_candidate

    def index
      @message = Message.new
      @messages = Message.all  
    end
end