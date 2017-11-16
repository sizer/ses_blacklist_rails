Rails.application.routes.draw do
  mount SesBlacklistRails::Engine => "/ses_blacklist_rails"
end
