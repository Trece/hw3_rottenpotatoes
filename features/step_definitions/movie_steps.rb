# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  end
  
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  i1 = page.text =~ /.*#{e1}/
  i2 = page.text =~ /.*?#{e2}/
  i1.should < i2
end

Then /I open the browser/ do
  save_and_open_page
end

Then /I should see all movies/ do 
  Movie.all.each do |movie|
    if page.respond_to? :should
      page.should have_content movie.title
    else
      assert page.has_content? movie.title
    end
  end
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  if uncheck == "un" then
    ratings = rating_list.split " "
    ratings.each do |field| 
      uncheck("ratings_"+field)
    end
  else
    ratings = rating_list.split " "
    ratings.each do |field| 
      check("ratings_"+field)
    end
  end
end
