module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    mappings do
      indexes :title, type: 'text'
      indexes :content, type: 'text'
    end

    def self.search(query)
      params = {
        query: {
          multi_match: {
            query: query,
            fields: ['title', 'content'],
            fuzziness: "AUTO"
          }
        }
      }

      self.__elasticsearch__.search(params).records.to_a
    end
  end
end
