class BooksController < ApplicationController
  def index  # 一覧
    @books = Book.all
    @book = Book.new
  end


  def edit  # 編集
    @book = Book.find(params[:id])
  end


  def update  # 更新
    # book = Book.find(params[:id])
    # book.update(book_params)
    # redirect_to books_path(book.id)
    # showのアクションにリダイレクトするため必ず引数idを設定する
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book was successfully created."
      render :show
    else
      flash.now[:alert] = "Book was edit failed."
      render :edit
    end
  end


  def create
    # book = Book.new(book_params)  # １.&2. データを受け取り新規登録するためのインスタンス作成
    # book.save  # 3. データをデータベースに保存するためのsaveメソッド実行
    # redirect_to books_path(book.id)  # 4. トップ画面へリダイレクト
    @books = Book.all
    @book = Book.new(book_params)  # １.&2. データを受け取り新規登録するためのインスタンス作成
    if @book.valid?
      @book.save  # 3. データをデータベースに保存するためのsaveメソッド実行
      redirect_to book_path(@book.id), notice: 'Book was successfully created.' # flashメッセージ
    else
      render :index
    end
  end


  def show
    @book = Book.find(params[:id])
    # 1件だけ取得するのでインスタンス変数は単数形の@book
  end


  def destroy  # 削除
    @book = Book.find(params[:id])  # データ（レコード）を1件取得
    @book.destroy  # データ（レコード）を削除
    if @book.destroy
      redirect_to '/books', notice: "Book was successfully destroyed."  # flashメッセージ 投稿一覧画面へリダイレクト
    end
  end


  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end
end