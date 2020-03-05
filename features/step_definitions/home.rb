Given("I access the webpage") do
  @home.load
  expect(@home).to have_logo
  expect(@home).to have_search_box
end

Given("I fill the form with origin and destiny") do
  @home.from.set @from
  @home.suggest.click
  @home.to.set @to
  @home.suggest.click
  @home.date_from.set @date_from
  @home.search_btn.click
end

Then("I should see results in the Clickbus search result") do
  @home.result_text_validation
end
