class ArtifactResource < Avo::BaseResource
  self.title = :name
  elf.model_class = 'Artifact'
  self.includes = []
  # self.search_query = -> do
  #   scope.ransack(id_eq: params[:q], m: "or").result(distinct: false)
  # end
  action ConvertMarkdown

  self.resolve_find_scope = ->(model_class:) do
    model_class.friendly
  end

  field :id, as: :id
  # Fields generated from the model
  field :name, as: :text
  field :artifact_date, as: :date
  field :url, as: :text
  field :image, as: :file
  field :markdown, as: :file
  field :posts, as: :has_and_belongs_to_many
  field :category, as: :belongs_to
  field :embed, as: :text
  field :description, as: :trix, attachment_key: :trix_attachments, through: :action_text_rich_texts, hide_on: [:new]
  # add fields here
end
