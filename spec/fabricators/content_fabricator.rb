# encoding: utf-8
Fabricator(:content) do
  path { sequence(:path) { |i| "/path/to/#{i}" } }
end

Fabricator(:deleted_content, from: :content) do
  deleted_at Time.now
end
