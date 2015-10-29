require 'rails_helper'

RSpec.describe "articles/edit", type: :view do
  before(:each) do
    @article = assign(:article, Article.create!(
      :url => "MyString",
      :title => "MyString",
      :author_id => 1,
      :parent_id => 1
    ))
  end

  it "renders the edit article form" do
    render

    assert_select "form[action=?][method=?]", article_path(@article), "post" do

      assert_select "input#article_url[name=?]", "article[url]"

      assert_select "input#article_title[name=?]", "article[title]"

      assert_select "input#article_author_id[name=?]", "article[author_id]"

      assert_select "input#article_parent_id[name=?]", "article[parent_id]"
    end
  end
end
