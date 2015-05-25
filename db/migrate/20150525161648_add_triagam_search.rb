class AddTriagamSearch < ActiveRecord::Migration
  def change
    execute "create extension pg_trgm;"
    execute "CREATE INDEX name_similarity_idx ON words USING gist (content gist_trgm_ops);"
  end
end
