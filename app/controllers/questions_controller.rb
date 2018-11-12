class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /questions
  # GET /questions.json
  def index

    @questions = Question.where(subgenre_id: params[:subgenre])

  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    if Array(User.where(:id => session[:user_id])).first.id == 1
      @question = Question.new(question_params)

      respond_to do |format|
        if @question.save
          format.html { redirect_to @question, notice: 'Question was successfully created.' }
          format.json { render :show, status: :created, location: @question }
        else
          format.html { render :new }
          format.json { render json: @question.errors, status: :unprocessable_entity }
        end
      end
    else
          q = Question.find_by(id: params[:qid])
          @options = Option.where(question_id: q.id)
          flag = 1
          if params[:a] != nil and !@options[0].flag
             flag = 0
          end

          if params[:b] != nil and !@options[1].flag
              flag = 0
          end

          if params[:c] != nil and !@options[2].flag
              flag = 0
          end

          if params[:d] != nil and !@options[3].flag
              flag = 0
          end
          leaderboard = Score.find_by(user_id: Array(User.where(:id => session[:user_id])).first.id, subgenre_id: q.subgenre_id)
          if leaderboard == nil
            leaderboard = Score.create(Score: 0, user_id: Array(User.where(:id => session[:user_id])).first.id, subgenre_id: q.subgenre_id)
          end
          if flag == 1
                  scre = leaderboard.Score + 10
                  leaderboard.update(Score: scre)
          end
          leaderboard.save
          puts "Score"
          puts leaderboard.Score
          redirect_to questions_url(:subgenre => q.subgenre_id)
      end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:Question, :variety, :subgenre_id)
    end
end
