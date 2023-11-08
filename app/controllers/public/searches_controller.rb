class Public::SearchesController < ApplicationController
  def index
    case params[:search_type]
    # キーワード検索の場合
    when 'keywords' then
      @search_words = params[:publication_title_or_name_or_breed_or_animal_print_or_prefecture_or_municipalitie_cont].gsub(/　/," ").strip # 前後のスペースを削除
      if @search_words.blank? # 空検索判定
        flash[:danger] = '検索キーワードを入力してください。'
        redirect_back fallback_location: root_path
      else
        key_words = @search_words.split(/[\p{blank}\s]+/)
        grouping_hash = key_words.reduce({}){|hash, word| hash.merge(word => { publication_title_or_name_or_breed_or_animal_print_or_prefecture_or_municipalitie_cont: word })}
        @cats = Cat.ransack({ combinator: 'and', groupings: grouping_hash }).result
      end

    # カテゴリ検索の場合
    when 'categories' then

    end
  end
end
