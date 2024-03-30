module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    mappings do
      indexes :chat_id, type: 'keyword'
      indexes :body, type: 'text'
    end

    def self.search(query, chat_id)
      params = {
        query: {
          bool: {
            must: [
              {
                match: {
                  body:{
                  query: query,
                  fuzziness: 'AUTO'
                  }
                }
              },
              {
                term: {
                  chat_id: chat_id
                }
              }
            ]
          }
        }
      }
      __elasticsearch__.search(params).records.to_a
    end
  end
end
