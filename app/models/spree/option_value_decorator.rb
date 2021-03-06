Spree::OptionValue.class_eval do

  has_attached_file(
    :image,
    styles: { mini: "32x32>", small: "64x64>", normal: "128x128>" },
    default_style: SpreeVariantOptions::VariantConfig[:option_value_default_style],
    url: SpreeVariantOptions::VariantConfig[:option_value_url],
    path: SpreeVariantOptions::VariantConfig[:option_value_path]
  )
  validates_attachment_content_type :image, content_type: /\Aimage/

  def has_image?
    image_file_name && !image_file_name.empty?
  end

  default_scope { order(%{#{quoted_table_name}."position"}) }
  scope :for_product, lambda { |product| select("DISTINCT #{table_name}.*").where(spree_option_value_variants: {variant_id: product.variant_ids}).joins(:variants) }
end
