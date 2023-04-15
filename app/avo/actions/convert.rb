class Convert < Avo::BaseAction
  self.name = "Convert"
  # self.visible = -> do
  #   true
  # end

  self.message = "Are you sure you want to convert"
  self.confirm_button_label = "Convert"
  self.cancel_button_label = "Not Yet"

  def handle(**args)
    models = args[:models]

    models.each do |model|
      model.convert_attachment
      model.convert_html
    end
    succeed "Post converted!"
    reload
  end
end
