class ArtifactResource < Avo::BaseResource
  self.title = :name
  self.includes = []
  # self.search_query = -> do
  #   scope.ransack(id_eq: params[:q], m: "or").result(distinct: false)
  # end
  self.resolve_find_scope = ->(model_class:) do
    model_class.friendly
  end

  field :id, as: :id
  # Fields generated from the model
  field :name, as: :text
  field :url, as: :text
  field :image, as: :file
  field :category, as: :belongs_to
  field :description, as: :trix, attachment_key: :trix_attachments, through: :action_text_rich_texts
  # add fields here
end
