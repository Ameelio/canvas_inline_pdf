Rails.application.routes.draw do
  get "file_previews/:file_id", to: "file_previews#show"
end
