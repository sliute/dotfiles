root = File.expand_path(File.dirname(__FILE__))

file_cache_path root
cookbook_path   File.join(root, 'cookbooks')
recipe_path     File.join(root, 'recipes')
role_path       File.join(root, 'roles')
