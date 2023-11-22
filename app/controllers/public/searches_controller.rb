class Public::SearchesController < ApplicationController
  def index
    case params[:search_type]
    # キーワード検索の場合
    when 'keywords' then
      @search_words = params[:publication_title_or_breed_or_animal_print_or_prefecture_or_city_cont].gsub(/　/," ").strip # 前後のスペースを削除
      if @search_words.blank? # 空検索判定
        flash[:alert] = '検索キーワードを入力してください。'
        redirect_back fallback_location: root_path
      else
        key_words = @search_words.split(/[\p{blank}\s]+/)
        grouping_hash = key_words.reduce({}){|hash, word| hash.merge(word => { publication_title_or_breed_or_animal_print_or_prefecture_or_city_cont: word })}
        @cats = Cat.ransack({ combinator: 'and', groupings: grouping_hash }).result
      end
      
    # カテゴリ検索の場合
    when 'categories' then
      @search_words = 'カテゴリ検索'
      @cats = Cat.all

      # 都道府県
      if !params[:prefecture].blank?
        @cats.where!(prefecture: params[:prefecture])
      end

      # 種類
      if !params[:breed].blank?
        @cats.where!(breed: params[:breed])
      end

      # 年齢
      if !params[:age].blank?
        case params[:age]
        when 'kitten' then
          # 1歳未満
          @cats.where!(age: ...1)
        when 'adult_cat' then
          # 1歳以上8歳以下
          @cats.where!(age: 1..8)
        when 'old_cat' then
          # 8歳より大きい
          @cats.where!(age: 8...)
        end
      end

      # 性別
      if !params[:gender].blank?
        @cats.where!(gender: params[:gender])
      end

      # 毛の柄
      if !params[:animal_print].blank?
        @cats.where!(animal_print: params[:animal_print])
      end
    end
  end
end
