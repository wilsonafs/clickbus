require "capybara/cucumber"
require "selenium-webdriver"
require "site_prism"
require "faker"
require "cpf_faker"
require "pry-byebug"
require "dotenv"
require "allure-cucumber"
require "httparty"
require "httparty/request"
require "httparty/response/headers"

if ENV["ENV"]
  puts "env"
  Dotenv.load(".env." + ENV["ENV"], ".env")
else
  Dotenv.load(".env")
end

Capybara.register_driver :browserstack do |app|
  BS_TOKEN = ENV["BS_TOKEN"]
  BS_USER = ENV["BS_USER"]

  caps = Selenium::WebDriver::Remote::Capabilities.new
  caps["project"] = ENV["ENV"] if ENV["ENV"]
  caps["browserstack.debug"] = true
  caps["browser"] = "chrome"
  caps["build"] = ENV["BUILD"] if ENV["BUILD"]
  Capybara::Selenium::Driver.new(app,
                                 browser: :remote,
                                 url: "http://#{BS_USER}:#{BS_TOKEN}@hub-cloud.browserstack.com/wd/hub",
                                 desired_capabilities: caps)
end

Capybara.register_driver :selenium_standalone do |app|
  args = %w[--no-default-browser-check --start-maximized]
  caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {
                                                            "args" => args,
                                                          })

  Capybara::Selenium::Driver.new(
    app,
    browser: :remote,
    url: "http://localhost:4444/wd/hub",
    desired_capabilities: caps,
  )
end

Capybara.register_driver :chrome_headless do |app|
  args = %w[--enable-javascript no-sandbox window-size=1440,900 headless disable-gpu]

  caps = Selenium::WebDriver::Remote::Capabilities.chrome(
    "chromeOptions" => {
      "args" => args,
    },
  )

  Capybara::Selenium::Driver.new(app, browser: :chrome, desired_capabilities: caps)
end

Capybara.configure do |config|
  config.default_driver = (ENV["DRIVER"] || "selenium_chrome").to_sym

  config.app_host = ENV["url_padrao"]
  config.default_max_wait_time = 20
end
