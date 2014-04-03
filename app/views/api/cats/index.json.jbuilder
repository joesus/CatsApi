json.array(@cats) do |cat|
  json.extract! cat, :id, :name
  json.message I18n.t("cat_message", name: cat.name)
end