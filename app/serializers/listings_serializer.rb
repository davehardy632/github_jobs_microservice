class ListingsSerializer
  include FastJsonapi::ObjectSerializer
  attributes  :id,
              :return_all_listings
#               :type,
#               :url,
#               :created_at,
#               :company,
#               :company_url,
#               :location,
#               :title,
#               :description,
#               :how_to_apply,
#               :company_logo,
end
