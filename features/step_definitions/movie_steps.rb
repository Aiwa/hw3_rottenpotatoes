# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  end
  #flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  page.body =~ /#{e1}.+#{e2}/m
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  #flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check ratings: (.*)/ do |uncheck, rating_list|
  if uncheck == "un"
     rating_list.split(", ").each {|va| step %{I uncheck "ratings_#{va}"}}
  else
     rating_list.split(", ").each {|va| step %{I check "ratings_#{va}"}}
  end
    # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
end

And /I should see all of the movies/ do
   movies = Movie.all.map(&:title)
   assert_equal page.all('table#movies tbody tr').count, movies.length
   movies.each do |movie|
     step %Q{I should see "#{movie}"}
   end
   #rows = page.all('#movies tr').size -1
   # assert rows == 0
end

And /I should not see all of the movies/ do
   #movies = Movie.all.map(&:title)
   #assert_equal page.all('table#movies tbody tr').count, movies.length
   #movies.each do |movie|
     #step %Q{I should not see "#{movie}"}
   #end
   #rows = page.all('#movies tr').size -1
   #assert rows == 0
end

