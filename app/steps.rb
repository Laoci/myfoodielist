# !!!After all 4 steps, run bundle install, yarn install, db:drop, db:create, db:migrate and db:seed
# Seeding takes around 5 minutes


# 1. Open .env file in the root directory (folder) and copy-paste all API keys below
TIH_API_KEY=4AreSBfYUKb8WoeK2hlavMhYgewEZsoB
MAPBOX_API_KEY=pk.eyJ1IjoicGlub2NoZXQiLCJhIjoiY2tzeTlqZXFnMmh2bjJ2bWRuZWUwemkxYiJ9.fpqV_cweQYxyUiIt2xA1KA
CLOUDINARY_URL=cloudinary://698416777718869:xqZxJdc8C4GvnDlyKwFcoyerMag@dlgi359wp

# 2. Open config/initializers/geocoder.rb file and set units from :mi to :km
Geocoder.configure(
  # [...]
  units: :km, # default value miles (:mi)
  # [...]
)

# 3. Open config/environments/development.rb file and set below configuration from :local to :cloudinary
config.active_storage.service = :cloudinary # defaults value local (:local)

# 4. Open config/storage.yml file and copy-paste below in:
cloudinary:
  service: Cloudinary
  folder: <%= Rails.env %>
