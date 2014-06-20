root = File.expand_path(File.dirname(__FILE__))

file_cache_path root
cookbook_path   [
  File.join(root, 'cookbooks'),
  File.join(root, 'site-cookbooks'),
]
recipe_path     File.join(root, 'recipes')
role_path       File.join(root, 'roles')

ssl_verify_mode :verify_peer
