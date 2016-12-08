class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]



  def import
    if params[:csv_file].blank?
      redirect_to(books_url, alert: 'インポートするCSVファイルを選択してください')
    else
      num = Book.import(params[:csv_file])
      redirect_to(books_url, notice: "#{num.to_s}件の書籍情報を追加 / 更新しました")
    end
  end

  # GET /books
  # GET /books.json
  def index
    @conditions = OpenStruct.new(params[:conditions] || {})
  
    relation = Book.all
    
    unless @conditions.bname.blank?
       relation = relation.where("本の名前 like ? escape '!'", '%' + "#{@conditions.bname}" + '%')
    end
   
    unless @conditions.bauthor.blank?
       relation = relation.where("著者 like ? escape '!'", '%' + "#{@conditions.bauthor}" + '%')
    end
   
    unless @conditions.bcom.blank?
       relation = relation.where("出版社 like ? escape '!'", '%' + "#{@conditions.bcom}" + '%')
    end


    @books = relation.order(params[:sort])
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)
    @book.Time = Time.now
    @book.UpTime = Time.now

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: '新しい書籍が登録されました。' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    @book.UpTime = Time.now 
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: '書籍データを更新しました。' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: '書籍が削除されました。' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:本の名前, :著者, :出版社, :ページ数, :備考, :Time)
    end
end
