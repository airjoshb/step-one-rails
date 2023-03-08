class ArtifactResource < Avo::BaseResource
  self.title = :id
  self.includes = []
  # self.search_query = -> do
  #   scope.ransack(id_eq: params[:q], m: "or").result(distinct: false)
  # end

  field :id, as: :id
  # Fields generated from the model
  field :name, as: :text
  field :url, as: :text
  field :image, as: :text
  field :category, as: :belongs_to
  field :description, as: :trix, attachment_key: :trix_attachments, through: :action_text_rich_texts

  # add fields here
end
