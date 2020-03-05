class HomePage < SitePrism::Page
  set_url "https://www.clickbus.com.br"

  element :logo, ".brand-logo"
  element :search_box, ".search-box"

  #Search box elements
  element :from, "#widget-vertical-origin-place"
  element :to, "#widget-vertical-destination-place"
  element :date_from, "#widget-vertical-departure-date"
  element :search_btn, ".search-btn"
  element :suggest, ".tt-dataset"

  def result_text_validation
    assert_text("Passagens de ônibus de São Paulo, SP para Recife, PE")
  end
end
