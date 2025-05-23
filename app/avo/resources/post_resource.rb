class PostResource < Avo::BaseResource
  self.title = :title
  self.model_class = 'Post'
  self.includes = []
  self.resolve_query_scope = ->(model_class:) do
    model_class.order(created_at: :asc)
  end

  action Convert

  self.find_record_method = ->(model_class:, id:, params:) {
    model_class.friendly.find id
  }
  # self.search_query = -> do
  #   scope.ransack(id_eq: params[:q], m: "or").result(distinct: false)
  # end

  field :id, as: :id
  # Fields generated from the model
  field :title, as: :text
  field :pub_date, as: :date
  field :pub_order, as: :number
  field :image, as: :file
  field :artifacts, as: :has_and_belongs_to_many
  field :markdown, as: :file, hide_on: [:index]
  field :category, as: :belongs_to
  field :html_text, as: :text, hide_on: [:index]
  field :content, as: :trix, attachment_key: :trix_attachments, through: :action_text_rich_texts
  field :children, as: :has_many
  field :parent, as: :belongs_to
  # add fields here
end
